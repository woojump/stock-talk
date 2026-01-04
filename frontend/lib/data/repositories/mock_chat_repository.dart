import 'dart:async';

import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/i_chat_repository.dart';

class MockChatRepository implements IChatRepository {
  final List<ChatMessage> _chatHistory = [];

  final Map<String, String> _mockResponses = {
    '삼성전자': '삼성전자(005930)는 현재 71,500원에 거래되고 있습니다. 전일 대비 500원(+0.70%) 상승했습니다. 매수를 원하시면 "삼성전자 10주 매수해줘"라고 말씀해 주세요.',
    '매수': '주문을 처리하겠습니다. 현재 시장가로 매수 주문을 넣을까요? 확인을 위해 "확인" 또는 "취소"라고 말씀해 주세요.',
    '매도': '매도 주문을 처리하겠습니다. 보유 중인 종목과 수량을 확인 중입니다. 어떤 종목을 얼마나 매도하시겠어요?',
    '잔고': '현재 보유 종목을 확인해 드릴게요:\n\n1. 삼성전자 100주 (수익률 +5.15%)\n2. SK하이닉스 30주 (수익률 -3.78%)\n3. NAVER 20주 (수익률 +7.50%)\n\n총 평가금액: 23,155,000원\n총 수익률: +1.78%',
    '추천': '현재 시장 상황을 분석한 결과, 다음 종목들이 관심 대상입니다:\n\n1. NAVER - 실적 개선 기대\n2. LG전자 - 가전 수요 회복\n3. KB금융 - 금리 인상 수혜\n\n더 자세한 정보를 원하시면 종목명을 말씀해 주세요.',
  };

  final String _defaultResponse =
      '안녕하세요! 저는 주식 거래를 도와드리는 AI 어시스턴트입니다. 다음과 같은 기능을 제공합니다:\n\n• 종목 검색 및 시세 조회\n• 매수/매도 주문\n• 포트폴리오 조회\n• 투자 추천\n\n무엇을 도와드릴까요?';

  @override
  Stream<String> sendMessage(String message, List<ChatMessage> history) async* {
    await Future.delayed(const Duration(milliseconds: 500));

    String response = _defaultResponse;

    for (final keyword in _mockResponses.keys) {
      if (message.contains(keyword)) {
        response = _mockResponses[keyword]!;
        break;
      }
    }

    // Simulate streaming by yielding characters one by one
    for (int i = 0; i < response.length; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      yield response.substring(0, i + 1);
    }
  }

  @override
  Future<List<ChatMessage>> getChatHistory() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_chatHistory);
  }

  @override
  Future<void> clearHistory() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _chatHistory.clear();
  }
}
