import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';
import 'package:stock_talk/features/chat/domain/repositories/chat_repository.dart';

/// landing: 새 대화 화면, conversation: 기존 대화 화면
enum ChatViewState { landing, conversation }

class ChatProvider extends ChangeNotifier {
  final ChatRepository _repository;

  ChatProvider(this._repository);

  // State
  ChatViewState _viewState = ChatViewState.landing;
  List<ChatMessage> _messages = [];
  int? _currentRoomId;
  bool _isLoading = false;
  bool _isSending = false;
  String? _error;
  String _inputText = '';

  // Chat History State
  List<ChatRoom> _chatRooms = [];
  bool _isLoadingRooms = false;

  // Getters
  ChatViewState get viewState => _viewState;
  List<ChatMessage> get messages => _messages;
  int? get currentRoomId => _currentRoomId;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
  String? get error => _error;
  String get inputText => _inputText;
  bool get canSend => _inputText.trim().isNotEmpty && !_isSending;

  // Chat History Getters
  List<ChatRoom> get chatRooms => _chatRooms;
  bool get isLoadingRooms => _isLoadingRooms;

  /// 랜딩 페이지 제안 문구
  static const List<String> suggestions = [
    '삼성전자 시세 알려줘',
    '내 잔고 확인해줘',
    '현대차 1주 매수해줘',
    '내 주문 내역 보여줘',
  ];

  /// 입력 텍스트 업데이트
  void updateInputText(String text) {
    _inputText = text;
    notifyListeners();
  }

  /// 메시지 전송
  Future<void> sendMessage(String query) async {
    if (query.trim().isEmpty || _isSending) return;

    _isSending = true;
    _error = null;

    // 사용자 메시지를 먼저 추가 (낙관적 업데이트)
    final userMessage = ChatMessage(
      roomId: _currentRoomId ?? 0,
      role: MessageRole.user,
      msgType: MessageType.text,
      content: query,
      sentAt: DateTime.now(),
    );
    _messages.add(userMessage);
    _inputText = '';

    // 대화 화면으로 전환
    if (_viewState == ChatViewState.landing) {
      _viewState = ChatViewState.conversation;
    }
    notifyListeners();

    try {
      final response = await _repository.sendMessage(
        query: query,
        roomId: _currentRoomId,
      );

      _currentRoomId = response.roomId;

      // 서버 응답으로 받은 새로운 메시지들을 기존 목록에 추가
      _messages.addAll(response.messages);
      _error = null;
    } on DioException catch (e) {
      _error = _mapDioError(e);
      // 에러 시 마지막 사용자 메시지 제거
      if (_messages.isNotEmpty && _messages.last.isUser) {
        _messages.removeLast();
      }
    } catch (e) {
      _error = '메시지를 보내지 못했어요.';
      debugPrint('ChatProvider Error: $e');
      if (_messages.isNotEmpty && _messages.last.isUser) {
        _messages.removeLast();
      }
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  /// 새 대화 시작
  void startNewConversation() {
    _viewState = ChatViewState.landing;
    _messages = [];
    _currentRoomId = null;
    _error = null;
    _inputText = '';
    notifyListeners();
  }

  /// 에러 초기화
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // ============ Chat History Methods ============

  /// 채팅방 목록 로드
  Future<void> loadChatRooms() async {
    _isLoadingRooms = true;
    notifyListeners();

    try {
      _chatRooms = await _repository.getChatRooms();
    } catch (e) {
      debugPrint('Failed to load chat rooms: $e');
    } finally {
      _isLoadingRooms = false;
      notifyListeners();
    }
  }

  /// 채팅방 선택 (해당 채팅방의 메시지 로드)
  Future<void> selectChatRoom(int roomId) async {
    _isLoading = true;
    _currentRoomId = roomId;
    _viewState = ChatViewState.conversation;
    _error = null;
    notifyListeners();

    try {
      _messages = await _repository.getRoomMessages(roomId);
    } catch (e, stackTrace) {
      _error = '대화 내역을 불러오지 못했어요.';
      debugPrint('Failed to load room messages: $e');
      debugPrint('Stack trace: $stackTrace');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 채팅방 삭제
  Future<bool> deleteChatRoom(int roomId) async {
    try {
      await _repository.deleteChatRoom(roomId);
      _chatRooms.removeWhere((r) => r.roomId == roomId);

      // 현재 보고 있던 방이면 랜딩으로 이동
      if (_currentRoomId == roomId) {
        startNewConversation();
      } else {
        notifyListeners();
      }
      return true;
    } catch (e) {
      debugPrint('Failed to delete chat room: $e');
      return false;
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return '연결 시간이 초과되었어요.';
      case DioExceptionType.connectionError:
        return '네트워크 연결을 확인해주세요.';
      default:
        return e.message ?? '메시지를 보내지 못했어요.';
    }
  }
}
