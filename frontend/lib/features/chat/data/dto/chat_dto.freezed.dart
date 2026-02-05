// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatResponseDto {

 String? get status;@JsonKey(name: 'room_id') int get roomId; String? get answer; List<ChatMessageDto> get messages;
/// Create a copy of ChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatResponseDtoCopyWith<ChatResponseDto> get copyWith => _$ChatResponseDtoCopyWithImpl<ChatResponseDto>(this as ChatResponseDto, _$identity);

  /// Serializes this ChatResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.answer, answer) || other.answer == answer)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,roomId,answer,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'ChatResponseDto(status: $status, roomId: $roomId, answer: $answer, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatResponseDtoCopyWith<$Res>  {
  factory $ChatResponseDtoCopyWith(ChatResponseDto value, $Res Function(ChatResponseDto) _then) = _$ChatResponseDtoCopyWithImpl;
@useResult
$Res call({
 String? status,@JsonKey(name: 'room_id') int roomId, String? answer, List<ChatMessageDto> messages
});




}
/// @nodoc
class _$ChatResponseDtoCopyWithImpl<$Res>
    implements $ChatResponseDtoCopyWith<$Res> {
  _$ChatResponseDtoCopyWithImpl(this._self, this._then);

  final ChatResponseDto _self;
  final $Res Function(ChatResponseDto) _then;

/// Create a copy of ChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? roomId = null,Object? answer = freezed,Object? messages = null,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatResponseDto].
extension ChatResponseDtoPatterns on ChatResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? status, @JsonKey(name: 'room_id')  int roomId,  String? answer,  List<ChatMessageDto> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatResponseDto() when $default != null:
return $default(_that.status,_that.roomId,_that.answer,_that.messages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? status, @JsonKey(name: 'room_id')  int roomId,  String? answer,  List<ChatMessageDto> messages)  $default,) {final _that = this;
switch (_that) {
case _ChatResponseDto():
return $default(_that.status,_that.roomId,_that.answer,_that.messages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? status, @JsonKey(name: 'room_id')  int roomId,  String? answer,  List<ChatMessageDto> messages)?  $default,) {final _that = this;
switch (_that) {
case _ChatResponseDto() when $default != null:
return $default(_that.status,_that.roomId,_that.answer,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatResponseDto extends ChatResponseDto {
  const _ChatResponseDto({this.status, @JsonKey(name: 'room_id') required this.roomId, this.answer, required final  List<ChatMessageDto> messages}): _messages = messages,super._();
  factory _ChatResponseDto.fromJson(Map<String, dynamic> json) => _$ChatResponseDtoFromJson(json);

@override final  String? status;
@override@JsonKey(name: 'room_id') final  int roomId;
@override final  String? answer;
 final  List<ChatMessageDto> _messages;
@override List<ChatMessageDto> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatResponseDtoCopyWith<_ChatResponseDto> get copyWith => __$ChatResponseDtoCopyWithImpl<_ChatResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.answer, answer) || other.answer == answer)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,roomId,answer,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ChatResponseDto(status: $status, roomId: $roomId, answer: $answer, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ChatResponseDtoCopyWith<$Res> implements $ChatResponseDtoCopyWith<$Res> {
  factory _$ChatResponseDtoCopyWith(_ChatResponseDto value, $Res Function(_ChatResponseDto) _then) = __$ChatResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String? status,@JsonKey(name: 'room_id') int roomId, String? answer, List<ChatMessageDto> messages
});




}
/// @nodoc
class __$ChatResponseDtoCopyWithImpl<$Res>
    implements _$ChatResponseDtoCopyWith<$Res> {
  __$ChatResponseDtoCopyWithImpl(this._self, this._then);

  final _ChatResponseDto _self;
  final $Res Function(_ChatResponseDto) _then;

/// Create a copy of ChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? roomId = null,Object? answer = freezed,Object? messages = null,}) {
  return _then(_ChatResponseDto(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageDto>,
  ));
}


}


/// @nodoc
mixin _$ChatMessageDto {

@JsonKey(name: 'message_id') int? get messageId;@JsonKey(name: 'room_id') int? get roomId; String? get role;@JsonKey(name: 'msg_type') String? get msgType; String? get content;@JsonKey(name: 'payload_json') Map<String, dynamic>? get payloadJson;@JsonKey(name: 'parent_id') int? get parentId; String? get status;@JsonKey(name: 'sent_at') String? get sentAt;
/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageDtoCopyWith<ChatMessageDto> get copyWith => _$ChatMessageDtoCopyWithImpl<ChatMessageDto>(this as ChatMessageDto, _$identity);

  /// Serializes this ChatMessageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.role, role) || other.role == role)&&(identical(other.msgType, msgType) || other.msgType == msgType)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.payloadJson, payloadJson)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,roomId,role,msgType,content,const DeepCollectionEquality().hash(payloadJson),parentId,status,sentAt);

@override
String toString() {
  return 'ChatMessageDto(messageId: $messageId, roomId: $roomId, role: $role, msgType: $msgType, content: $content, payloadJson: $payloadJson, parentId: $parentId, status: $status, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class $ChatMessageDtoCopyWith<$Res>  {
  factory $ChatMessageDtoCopyWith(ChatMessageDto value, $Res Function(ChatMessageDto) _then) = _$ChatMessageDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'message_id') int? messageId,@JsonKey(name: 'room_id') int? roomId, String? role,@JsonKey(name: 'msg_type') String? msgType, String? content,@JsonKey(name: 'payload_json') Map<String, dynamic>? payloadJson,@JsonKey(name: 'parent_id') int? parentId, String? status,@JsonKey(name: 'sent_at') String? sentAt
});




}
/// @nodoc
class _$ChatMessageDtoCopyWithImpl<$Res>
    implements $ChatMessageDtoCopyWith<$Res> {
  _$ChatMessageDtoCopyWithImpl(this._self, this._then);

  final ChatMessageDto _self;
  final $Res Function(ChatMessageDto) _then;

/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = freezed,Object? roomId = freezed,Object? role = freezed,Object? msgType = freezed,Object? content = freezed,Object? payloadJson = freezed,Object? parentId = freezed,Object? status = freezed,Object? sentAt = freezed,}) {
  return _then(_self.copyWith(
messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,msgType: freezed == msgType ? _self.msgType : msgType // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,payloadJson: freezed == payloadJson ? _self.payloadJson : payloadJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageDto].
extension ChatMessageDtoPatterns on ChatMessageDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'message_id')  int? messageId, @JsonKey(name: 'room_id')  int? roomId,  String? role, @JsonKey(name: 'msg_type')  String? msgType,  String? content, @JsonKey(name: 'payload_json')  Map<String, dynamic>? payloadJson, @JsonKey(name: 'parent_id')  int? parentId,  String? status, @JsonKey(name: 'sent_at')  String? sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
return $default(_that.messageId,_that.roomId,_that.role,_that.msgType,_that.content,_that.payloadJson,_that.parentId,_that.status,_that.sentAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'message_id')  int? messageId, @JsonKey(name: 'room_id')  int? roomId,  String? role, @JsonKey(name: 'msg_type')  String? msgType,  String? content, @JsonKey(name: 'payload_json')  Map<String, dynamic>? payloadJson, @JsonKey(name: 'parent_id')  int? parentId,  String? status, @JsonKey(name: 'sent_at')  String? sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageDto():
return $default(_that.messageId,_that.roomId,_that.role,_that.msgType,_that.content,_that.payloadJson,_that.parentId,_that.status,_that.sentAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'message_id')  int? messageId, @JsonKey(name: 'room_id')  int? roomId,  String? role, @JsonKey(name: 'msg_type')  String? msgType,  String? content, @JsonKey(name: 'payload_json')  Map<String, dynamic>? payloadJson, @JsonKey(name: 'parent_id')  int? parentId,  String? status, @JsonKey(name: 'sent_at')  String? sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
return $default(_that.messageId,_that.roomId,_that.role,_that.msgType,_that.content,_that.payloadJson,_that.parentId,_that.status,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageDto extends ChatMessageDto {
  const _ChatMessageDto({@JsonKey(name: 'message_id') this.messageId, @JsonKey(name: 'room_id') this.roomId, this.role, @JsonKey(name: 'msg_type') this.msgType, this.content, @JsonKey(name: 'payload_json') final  Map<String, dynamic>? payloadJson, @JsonKey(name: 'parent_id') this.parentId, this.status, @JsonKey(name: 'sent_at') this.sentAt}): _payloadJson = payloadJson,super._();
  factory _ChatMessageDto.fromJson(Map<String, dynamic> json) => _$ChatMessageDtoFromJson(json);

@override@JsonKey(name: 'message_id') final  int? messageId;
@override@JsonKey(name: 'room_id') final  int? roomId;
@override final  String? role;
@override@JsonKey(name: 'msg_type') final  String? msgType;
@override final  String? content;
 final  Map<String, dynamic>? _payloadJson;
@override@JsonKey(name: 'payload_json') Map<String, dynamic>? get payloadJson {
  final value = _payloadJson;
  if (value == null) return null;
  if (_payloadJson is EqualUnmodifiableMapView) return _payloadJson;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'parent_id') final  int? parentId;
@override final  String? status;
@override@JsonKey(name: 'sent_at') final  String? sentAt;

/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageDtoCopyWith<_ChatMessageDto> get copyWith => __$ChatMessageDtoCopyWithImpl<_ChatMessageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageDto&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.role, role) || other.role == role)&&(identical(other.msgType, msgType) || other.msgType == msgType)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._payloadJson, _payloadJson)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,roomId,role,msgType,content,const DeepCollectionEquality().hash(_payloadJson),parentId,status,sentAt);

@override
String toString() {
  return 'ChatMessageDto(messageId: $messageId, roomId: $roomId, role: $role, msgType: $msgType, content: $content, payloadJson: $payloadJson, parentId: $parentId, status: $status, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageDtoCopyWith<$Res> implements $ChatMessageDtoCopyWith<$Res> {
  factory _$ChatMessageDtoCopyWith(_ChatMessageDto value, $Res Function(_ChatMessageDto) _then) = __$ChatMessageDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'message_id') int? messageId,@JsonKey(name: 'room_id') int? roomId, String? role,@JsonKey(name: 'msg_type') String? msgType, String? content,@JsonKey(name: 'payload_json') Map<String, dynamic>? payloadJson,@JsonKey(name: 'parent_id') int? parentId, String? status,@JsonKey(name: 'sent_at') String? sentAt
});




}
/// @nodoc
class __$ChatMessageDtoCopyWithImpl<$Res>
    implements _$ChatMessageDtoCopyWith<$Res> {
  __$ChatMessageDtoCopyWithImpl(this._self, this._then);

  final _ChatMessageDto _self;
  final $Res Function(_ChatMessageDto) _then;

/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = freezed,Object? roomId = freezed,Object? role = freezed,Object? msgType = freezed,Object? content = freezed,Object? payloadJson = freezed,Object? parentId = freezed,Object? status = freezed,Object? sentAt = freezed,}) {
  return _then(_ChatMessageDto(
messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as int?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,msgType: freezed == msgType ? _self.msgType : msgType // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,payloadJson: freezed == payloadJson ? _self._payloadJson : payloadJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StockCardPayloadDto {

@JsonKey(name: 'card_type') String? get cardType; String? get title; String? get ticker; String? get range; String? get interval; Map<String, dynamic>? get summary; List<Map<String, dynamic>>? get candles;
/// Create a copy of StockCardPayloadDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockCardPayloadDtoCopyWith<StockCardPayloadDto> get copyWith => _$StockCardPayloadDtoCopyWithImpl<StockCardPayloadDto>(this as StockCardPayloadDto, _$identity);

  /// Serializes this StockCardPayloadDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockCardPayloadDto&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.title, title) || other.title == title)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.range, range) || other.range == range)&&(identical(other.interval, interval) || other.interval == interval)&&const DeepCollectionEquality().equals(other.summary, summary)&&const DeepCollectionEquality().equals(other.candles, candles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardType,title,ticker,range,interval,const DeepCollectionEquality().hash(summary),const DeepCollectionEquality().hash(candles));

@override
String toString() {
  return 'StockCardPayloadDto(cardType: $cardType, title: $title, ticker: $ticker, range: $range, interval: $interval, summary: $summary, candles: $candles)';
}


}

/// @nodoc
abstract mixin class $StockCardPayloadDtoCopyWith<$Res>  {
  factory $StockCardPayloadDtoCopyWith(StockCardPayloadDto value, $Res Function(StockCardPayloadDto) _then) = _$StockCardPayloadDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'card_type') String? cardType, String? title, String? ticker, String? range, String? interval, Map<String, dynamic>? summary, List<Map<String, dynamic>>? candles
});




}
/// @nodoc
class _$StockCardPayloadDtoCopyWithImpl<$Res>
    implements $StockCardPayloadDtoCopyWith<$Res> {
  _$StockCardPayloadDtoCopyWithImpl(this._self, this._then);

  final StockCardPayloadDto _self;
  final $Res Function(StockCardPayloadDto) _then;

/// Create a copy of StockCardPayloadDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardType = freezed,Object? title = freezed,Object? ticker = freezed,Object? range = freezed,Object? interval = freezed,Object? summary = freezed,Object? candles = freezed,}) {
  return _then(_self.copyWith(
cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,range: freezed == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as String?,interval: freezed == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,candles: freezed == candles ? _self.candles : candles // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockCardPayloadDto].
extension StockCardPayloadDtoPatterns on StockCardPayloadDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockCardPayloadDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockCardPayloadDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockCardPayloadDto value)  $default,){
final _that = this;
switch (_that) {
case _StockCardPayloadDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockCardPayloadDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockCardPayloadDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'card_type')  String? cardType,  String? title,  String? ticker,  String? range,  String? interval,  Map<String, dynamic>? summary,  List<Map<String, dynamic>>? candles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockCardPayloadDto() when $default != null:
return $default(_that.cardType,_that.title,_that.ticker,_that.range,_that.interval,_that.summary,_that.candles);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'card_type')  String? cardType,  String? title,  String? ticker,  String? range,  String? interval,  Map<String, dynamic>? summary,  List<Map<String, dynamic>>? candles)  $default,) {final _that = this;
switch (_that) {
case _StockCardPayloadDto():
return $default(_that.cardType,_that.title,_that.ticker,_that.range,_that.interval,_that.summary,_that.candles);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'card_type')  String? cardType,  String? title,  String? ticker,  String? range,  String? interval,  Map<String, dynamic>? summary,  List<Map<String, dynamic>>? candles)?  $default,) {final _that = this;
switch (_that) {
case _StockCardPayloadDto() when $default != null:
return $default(_that.cardType,_that.title,_that.ticker,_that.range,_that.interval,_that.summary,_that.candles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockCardPayloadDto extends StockCardPayloadDto {
  const _StockCardPayloadDto({@JsonKey(name: 'card_type') this.cardType, this.title, this.ticker, this.range, this.interval, final  Map<String, dynamic>? summary, final  List<Map<String, dynamic>>? candles}): _summary = summary,_candles = candles,super._();
  factory _StockCardPayloadDto.fromJson(Map<String, dynamic> json) => _$StockCardPayloadDtoFromJson(json);

@override@JsonKey(name: 'card_type') final  String? cardType;
@override final  String? title;
@override final  String? ticker;
@override final  String? range;
@override final  String? interval;
 final  Map<String, dynamic>? _summary;
@override Map<String, dynamic>? get summary {
  final value = _summary;
  if (value == null) return null;
  if (_summary is EqualUnmodifiableMapView) return _summary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _candles;
@override List<Map<String, dynamic>>? get candles {
  final value = _candles;
  if (value == null) return null;
  if (_candles is EqualUnmodifiableListView) return _candles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of StockCardPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockCardPayloadDtoCopyWith<_StockCardPayloadDto> get copyWith => __$StockCardPayloadDtoCopyWithImpl<_StockCardPayloadDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockCardPayloadDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockCardPayloadDto&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.title, title) || other.title == title)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.range, range) || other.range == range)&&(identical(other.interval, interval) || other.interval == interval)&&const DeepCollectionEquality().equals(other._summary, _summary)&&const DeepCollectionEquality().equals(other._candles, _candles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardType,title,ticker,range,interval,const DeepCollectionEquality().hash(_summary),const DeepCollectionEquality().hash(_candles));

@override
String toString() {
  return 'StockCardPayloadDto(cardType: $cardType, title: $title, ticker: $ticker, range: $range, interval: $interval, summary: $summary, candles: $candles)';
}


}

/// @nodoc
abstract mixin class _$StockCardPayloadDtoCopyWith<$Res> implements $StockCardPayloadDtoCopyWith<$Res> {
  factory _$StockCardPayloadDtoCopyWith(_StockCardPayloadDto value, $Res Function(_StockCardPayloadDto) _then) = __$StockCardPayloadDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'card_type') String? cardType, String? title, String? ticker, String? range, String? interval, Map<String, dynamic>? summary, List<Map<String, dynamic>>? candles
});




}
/// @nodoc
class __$StockCardPayloadDtoCopyWithImpl<$Res>
    implements _$StockCardPayloadDtoCopyWith<$Res> {
  __$StockCardPayloadDtoCopyWithImpl(this._self, this._then);

  final _StockCardPayloadDto _self;
  final $Res Function(_StockCardPayloadDto) _then;

/// Create a copy of StockCardPayloadDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardType = freezed,Object? title = freezed,Object? ticker = freezed,Object? range = freezed,Object? interval = freezed,Object? summary = freezed,Object? candles = freezed,}) {
  return _then(_StockCardPayloadDto(
cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,range: freezed == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as String?,interval: freezed == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,candles: freezed == candles ? _self._candles : candles // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}


}


/// @nodoc
mixin _$StockSummaryDto {

@JsonKey(name: 'stock_name') String? get stockName; String? get ticker;@JsonKey(name: 'current_price') double? get currentPrice;@JsonKey(name: 'price_change') double? get priceChange;@JsonKey(name: 'price_change_percent') double? get priceChangePercent;@JsonKey(name: 'open_price') double? get openPrice;@JsonKey(name: 'high_price') double? get highPrice;@JsonKey(name: 'low_price') double? get lowPrice; int? get volume;
/// Create a copy of StockSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockSummaryDtoCopyWith<StockSummaryDto> get copyWith => _$StockSummaryDtoCopyWithImpl<StockSummaryDto>(this as StockSummaryDto, _$identity);

  /// Serializes this StockSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockSummaryDto&&(identical(other.stockName, stockName) || other.stockName == stockName)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.priceChangePercent, priceChangePercent) || other.priceChangePercent == priceChangePercent)&&(identical(other.openPrice, openPrice) || other.openPrice == openPrice)&&(identical(other.highPrice, highPrice) || other.highPrice == highPrice)&&(identical(other.lowPrice, lowPrice) || other.lowPrice == lowPrice)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stockName,ticker,currentPrice,priceChange,priceChangePercent,openPrice,highPrice,lowPrice,volume);

@override
String toString() {
  return 'StockSummaryDto(stockName: $stockName, ticker: $ticker, currentPrice: $currentPrice, priceChange: $priceChange, priceChangePercent: $priceChangePercent, openPrice: $openPrice, highPrice: $highPrice, lowPrice: $lowPrice, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $StockSummaryDtoCopyWith<$Res>  {
  factory $StockSummaryDtoCopyWith(StockSummaryDto value, $Res Function(StockSummaryDto) _then) = _$StockSummaryDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'stock_name') String? stockName, String? ticker,@JsonKey(name: 'current_price') double? currentPrice,@JsonKey(name: 'price_change') double? priceChange,@JsonKey(name: 'price_change_percent') double? priceChangePercent,@JsonKey(name: 'open_price') double? openPrice,@JsonKey(name: 'high_price') double? highPrice,@JsonKey(name: 'low_price') double? lowPrice, int? volume
});




}
/// @nodoc
class _$StockSummaryDtoCopyWithImpl<$Res>
    implements $StockSummaryDtoCopyWith<$Res> {
  _$StockSummaryDtoCopyWithImpl(this._self, this._then);

  final StockSummaryDto _self;
  final $Res Function(StockSummaryDto) _then;

/// Create a copy of StockSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stockName = freezed,Object? ticker = freezed,Object? currentPrice = freezed,Object? priceChange = freezed,Object? priceChangePercent = freezed,Object? openPrice = freezed,Object? highPrice = freezed,Object? lowPrice = freezed,Object? volume = freezed,}) {
  return _then(_self.copyWith(
stockName: freezed == stockName ? _self.stockName : stockName // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,currentPrice: freezed == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double?,priceChange: freezed == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as double?,priceChangePercent: freezed == priceChangePercent ? _self.priceChangePercent : priceChangePercent // ignore: cast_nullable_to_non_nullable
as double?,openPrice: freezed == openPrice ? _self.openPrice : openPrice // ignore: cast_nullable_to_non_nullable
as double?,highPrice: freezed == highPrice ? _self.highPrice : highPrice // ignore: cast_nullable_to_non_nullable
as double?,lowPrice: freezed == lowPrice ? _self.lowPrice : lowPrice // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockSummaryDto].
extension StockSummaryDtoPatterns on StockSummaryDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockSummaryDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _StockSummaryDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockSummaryDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'stock_name')  String? stockName,  String? ticker, @JsonKey(name: 'current_price')  double? currentPrice, @JsonKey(name: 'price_change')  double? priceChange, @JsonKey(name: 'price_change_percent')  double? priceChangePercent, @JsonKey(name: 'open_price')  double? openPrice, @JsonKey(name: 'high_price')  double? highPrice, @JsonKey(name: 'low_price')  double? lowPrice,  int? volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockSummaryDto() when $default != null:
return $default(_that.stockName,_that.ticker,_that.currentPrice,_that.priceChange,_that.priceChangePercent,_that.openPrice,_that.highPrice,_that.lowPrice,_that.volume);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'stock_name')  String? stockName,  String? ticker, @JsonKey(name: 'current_price')  double? currentPrice, @JsonKey(name: 'price_change')  double? priceChange, @JsonKey(name: 'price_change_percent')  double? priceChangePercent, @JsonKey(name: 'open_price')  double? openPrice, @JsonKey(name: 'high_price')  double? highPrice, @JsonKey(name: 'low_price')  double? lowPrice,  int? volume)  $default,) {final _that = this;
switch (_that) {
case _StockSummaryDto():
return $default(_that.stockName,_that.ticker,_that.currentPrice,_that.priceChange,_that.priceChangePercent,_that.openPrice,_that.highPrice,_that.lowPrice,_that.volume);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'stock_name')  String? stockName,  String? ticker, @JsonKey(name: 'current_price')  double? currentPrice, @JsonKey(name: 'price_change')  double? priceChange, @JsonKey(name: 'price_change_percent')  double? priceChangePercent, @JsonKey(name: 'open_price')  double? openPrice, @JsonKey(name: 'high_price')  double? highPrice, @JsonKey(name: 'low_price')  double? lowPrice,  int? volume)?  $default,) {final _that = this;
switch (_that) {
case _StockSummaryDto() when $default != null:
return $default(_that.stockName,_that.ticker,_that.currentPrice,_that.priceChange,_that.priceChangePercent,_that.openPrice,_that.highPrice,_that.lowPrice,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockSummaryDto extends StockSummaryDto {
  const _StockSummaryDto({@JsonKey(name: 'stock_name') this.stockName, this.ticker, @JsonKey(name: 'current_price') this.currentPrice, @JsonKey(name: 'price_change') this.priceChange, @JsonKey(name: 'price_change_percent') this.priceChangePercent, @JsonKey(name: 'open_price') this.openPrice, @JsonKey(name: 'high_price') this.highPrice, @JsonKey(name: 'low_price') this.lowPrice, this.volume}): super._();
  factory _StockSummaryDto.fromJson(Map<String, dynamic> json) => _$StockSummaryDtoFromJson(json);

@override@JsonKey(name: 'stock_name') final  String? stockName;
@override final  String? ticker;
@override@JsonKey(name: 'current_price') final  double? currentPrice;
@override@JsonKey(name: 'price_change') final  double? priceChange;
@override@JsonKey(name: 'price_change_percent') final  double? priceChangePercent;
@override@JsonKey(name: 'open_price') final  double? openPrice;
@override@JsonKey(name: 'high_price') final  double? highPrice;
@override@JsonKey(name: 'low_price') final  double? lowPrice;
@override final  int? volume;

/// Create a copy of StockSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockSummaryDtoCopyWith<_StockSummaryDto> get copyWith => __$StockSummaryDtoCopyWithImpl<_StockSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockSummaryDto&&(identical(other.stockName, stockName) || other.stockName == stockName)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.priceChangePercent, priceChangePercent) || other.priceChangePercent == priceChangePercent)&&(identical(other.openPrice, openPrice) || other.openPrice == openPrice)&&(identical(other.highPrice, highPrice) || other.highPrice == highPrice)&&(identical(other.lowPrice, lowPrice) || other.lowPrice == lowPrice)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stockName,ticker,currentPrice,priceChange,priceChangePercent,openPrice,highPrice,lowPrice,volume);

@override
String toString() {
  return 'StockSummaryDto(stockName: $stockName, ticker: $ticker, currentPrice: $currentPrice, priceChange: $priceChange, priceChangePercent: $priceChangePercent, openPrice: $openPrice, highPrice: $highPrice, lowPrice: $lowPrice, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$StockSummaryDtoCopyWith<$Res> implements $StockSummaryDtoCopyWith<$Res> {
  factory _$StockSummaryDtoCopyWith(_StockSummaryDto value, $Res Function(_StockSummaryDto) _then) = __$StockSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'stock_name') String? stockName, String? ticker,@JsonKey(name: 'current_price') double? currentPrice,@JsonKey(name: 'price_change') double? priceChange,@JsonKey(name: 'price_change_percent') double? priceChangePercent,@JsonKey(name: 'open_price') double? openPrice,@JsonKey(name: 'high_price') double? highPrice,@JsonKey(name: 'low_price') double? lowPrice, int? volume
});




}
/// @nodoc
class __$StockSummaryDtoCopyWithImpl<$Res>
    implements _$StockSummaryDtoCopyWith<$Res> {
  __$StockSummaryDtoCopyWithImpl(this._self, this._then);

  final _StockSummaryDto _self;
  final $Res Function(_StockSummaryDto) _then;

/// Create a copy of StockSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stockName = freezed,Object? ticker = freezed,Object? currentPrice = freezed,Object? priceChange = freezed,Object? priceChangePercent = freezed,Object? openPrice = freezed,Object? highPrice = freezed,Object? lowPrice = freezed,Object? volume = freezed,}) {
  return _then(_StockSummaryDto(
stockName: freezed == stockName ? _self.stockName : stockName // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,currentPrice: freezed == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double?,priceChange: freezed == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as double?,priceChangePercent: freezed == priceChangePercent ? _self.priceChangePercent : priceChangePercent // ignore: cast_nullable_to_non_nullable
as double?,openPrice: freezed == openPrice ? _self.openPrice : openPrice // ignore: cast_nullable_to_non_nullable
as double?,highPrice: freezed == highPrice ? _self.highPrice : highPrice // ignore: cast_nullable_to_non_nullable
as double?,lowPrice: freezed == lowPrice ? _self.lowPrice : lowPrice // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CandleDataDto {

 String? get time; double? get open; double? get high; double? get low; double? get close; int? get volume;
/// Create a copy of CandleDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandleDataDtoCopyWith<CandleDataDto> get copyWith => _$CandleDataDtoCopyWithImpl<CandleDataDto>(this as CandleDataDto, _$identity);

  /// Serializes this CandleDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandleDataDto&&(identical(other.time, time) || other.time == time)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,open,high,low,close,volume);

@override
String toString() {
  return 'CandleDataDto(time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $CandleDataDtoCopyWith<$Res>  {
  factory $CandleDataDtoCopyWith(CandleDataDto value, $Res Function(CandleDataDto) _then) = _$CandleDataDtoCopyWithImpl;
@useResult
$Res call({
 String? time, double? open, double? high, double? low, double? close, int? volume
});




}
/// @nodoc
class _$CandleDataDtoCopyWithImpl<$Res>
    implements $CandleDataDtoCopyWith<$Res> {
  _$CandleDataDtoCopyWithImpl(this._self, this._then);

  final CandleDataDto _self;
  final $Res Function(CandleDataDto) _then;

/// Create a copy of CandleDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = freezed,Object? open = freezed,Object? high = freezed,Object? low = freezed,Object? close = freezed,Object? volume = freezed,}) {
  return _then(_self.copyWith(
time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,close: freezed == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CandleDataDto].
extension CandleDataDtoPatterns on CandleDataDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandleDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandleDataDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandleDataDto value)  $default,){
final _that = this;
switch (_that) {
case _CandleDataDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandleDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _CandleDataDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? time,  double? open,  double? high,  double? low,  double? close,  int? volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandleDataDto() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? time,  double? open,  double? high,  double? low,  double? close,  int? volume)  $default,) {final _that = this;
switch (_that) {
case _CandleDataDto():
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? time,  double? open,  double? high,  double? low,  double? close,  int? volume)?  $default,) {final _that = this;
switch (_that) {
case _CandleDataDto() when $default != null:
return $default(_that.time,_that.open,_that.high,_that.low,_that.close,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CandleDataDto extends CandleDataDto {
  const _CandleDataDto({this.time, this.open, this.high, this.low, this.close, this.volume}): super._();
  factory _CandleDataDto.fromJson(Map<String, dynamic> json) => _$CandleDataDtoFromJson(json);

@override final  String? time;
@override final  double? open;
@override final  double? high;
@override final  double? low;
@override final  double? close;
@override final  int? volume;

/// Create a copy of CandleDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandleDataDtoCopyWith<_CandleDataDto> get copyWith => __$CandleDataDtoCopyWithImpl<_CandleDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandleDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandleDataDto&&(identical(other.time, time) || other.time == time)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,open,high,low,close,volume);

@override
String toString() {
  return 'CandleDataDto(time: $time, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$CandleDataDtoCopyWith<$Res> implements $CandleDataDtoCopyWith<$Res> {
  factory _$CandleDataDtoCopyWith(_CandleDataDto value, $Res Function(_CandleDataDto) _then) = __$CandleDataDtoCopyWithImpl;
@override @useResult
$Res call({
 String? time, double? open, double? high, double? low, double? close, int? volume
});




}
/// @nodoc
class __$CandleDataDtoCopyWithImpl<$Res>
    implements _$CandleDataDtoCopyWith<$Res> {
  __$CandleDataDtoCopyWithImpl(this._self, this._then);

  final _CandleDataDto _self;
  final $Res Function(_CandleDataDto) _then;

/// Create a copy of CandleDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = freezed,Object? open = freezed,Object? high = freezed,Object? low = freezed,Object? close = freezed,Object? volume = freezed,}) {
  return _then(_CandleDataDto(
time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,close: freezed == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ChatRoomDto {

@JsonKey(name: 'room_id') int get roomId;@JsonKey(name: 'owner_user_id') int? get ownerUserId; String? get title;@JsonKey(name: 'last_preview') String? get lastPreview;@JsonKey(name: 'last_message_id') int? get lastMessageId;@JsonKey(name: 'last_sent_at') String? get lastSentAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of ChatRoomDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomDtoCopyWith<ChatRoomDto> get copyWith => _$ChatRoomDtoCopyWithImpl<ChatRoomDto>(this as ChatRoomDto, _$identity);

  /// Serializes this ChatRoomDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomDto&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.title, title) || other.title == title)&&(identical(other.lastPreview, lastPreview) || other.lastPreview == lastPreview)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastSentAt, lastSentAt) || other.lastSentAt == lastSentAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,ownerUserId,title,lastPreview,lastMessageId,lastSentAt,updatedAt);

@override
String toString() {
  return 'ChatRoomDto(roomId: $roomId, ownerUserId: $ownerUserId, title: $title, lastPreview: $lastPreview, lastMessageId: $lastMessageId, lastSentAt: $lastSentAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ChatRoomDtoCopyWith<$Res>  {
  factory $ChatRoomDtoCopyWith(ChatRoomDto value, $Res Function(ChatRoomDto) _then) = _$ChatRoomDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'room_id') int roomId,@JsonKey(name: 'owner_user_id') int? ownerUserId, String? title,@JsonKey(name: 'last_preview') String? lastPreview,@JsonKey(name: 'last_message_id') int? lastMessageId,@JsonKey(name: 'last_sent_at') String? lastSentAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$ChatRoomDtoCopyWithImpl<$Res>
    implements $ChatRoomDtoCopyWith<$Res> {
  _$ChatRoomDtoCopyWithImpl(this._self, this._then);

  final ChatRoomDto _self;
  final $Res Function(ChatRoomDto) _then;

/// Create a copy of ChatRoomDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? ownerUserId = freezed,Object? title = freezed,Object? lastPreview = freezed,Object? lastMessageId = freezed,Object? lastSentAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,lastPreview: freezed == lastPreview ? _self.lastPreview : lastPreview // ignore: cast_nullable_to_non_nullable
as String?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as int?,lastSentAt: freezed == lastSentAt ? _self.lastSentAt : lastSentAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoomDto].
extension ChatRoomDtoPatterns on ChatRoomDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoomDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoomDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoomDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoomDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoomDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoomDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'owner_user_id')  int? ownerUserId,  String? title, @JsonKey(name: 'last_preview')  String? lastPreview, @JsonKey(name: 'last_message_id')  int? lastMessageId, @JsonKey(name: 'last_sent_at')  String? lastSentAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoomDto() when $default != null:
return $default(_that.roomId,_that.ownerUserId,_that.title,_that.lastPreview,_that.lastMessageId,_that.lastSentAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'owner_user_id')  int? ownerUserId,  String? title, @JsonKey(name: 'last_preview')  String? lastPreview, @JsonKey(name: 'last_message_id')  int? lastMessageId, @JsonKey(name: 'last_sent_at')  String? lastSentAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ChatRoomDto():
return $default(_that.roomId,_that.ownerUserId,_that.title,_that.lastPreview,_that.lastMessageId,_that.lastSentAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'room_id')  int roomId, @JsonKey(name: 'owner_user_id')  int? ownerUserId,  String? title, @JsonKey(name: 'last_preview')  String? lastPreview, @JsonKey(name: 'last_message_id')  int? lastMessageId, @JsonKey(name: 'last_sent_at')  String? lastSentAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoomDto() when $default != null:
return $default(_that.roomId,_that.ownerUserId,_that.title,_that.lastPreview,_that.lastMessageId,_that.lastSentAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoomDto extends ChatRoomDto {
  const _ChatRoomDto({@JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'owner_user_id') this.ownerUserId, this.title, @JsonKey(name: 'last_preview') this.lastPreview, @JsonKey(name: 'last_message_id') this.lastMessageId, @JsonKey(name: 'last_sent_at') this.lastSentAt, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _ChatRoomDto.fromJson(Map<String, dynamic> json) => _$ChatRoomDtoFromJson(json);

@override@JsonKey(name: 'room_id') final  int roomId;
@override@JsonKey(name: 'owner_user_id') final  int? ownerUserId;
@override final  String? title;
@override@JsonKey(name: 'last_preview') final  String? lastPreview;
@override@JsonKey(name: 'last_message_id') final  int? lastMessageId;
@override@JsonKey(name: 'last_sent_at') final  String? lastSentAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of ChatRoomDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomDtoCopyWith<_ChatRoomDto> get copyWith => __$ChatRoomDtoCopyWithImpl<_ChatRoomDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoomDto&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.title, title) || other.title == title)&&(identical(other.lastPreview, lastPreview) || other.lastPreview == lastPreview)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastSentAt, lastSentAt) || other.lastSentAt == lastSentAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,ownerUserId,title,lastPreview,lastMessageId,lastSentAt,updatedAt);

@override
String toString() {
  return 'ChatRoomDto(roomId: $roomId, ownerUserId: $ownerUserId, title: $title, lastPreview: $lastPreview, lastMessageId: $lastMessageId, lastSentAt: $lastSentAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomDtoCopyWith<$Res> implements $ChatRoomDtoCopyWith<$Res> {
  factory _$ChatRoomDtoCopyWith(_ChatRoomDto value, $Res Function(_ChatRoomDto) _then) = __$ChatRoomDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'room_id') int roomId,@JsonKey(name: 'owner_user_id') int? ownerUserId, String? title,@JsonKey(name: 'last_preview') String? lastPreview,@JsonKey(name: 'last_message_id') int? lastMessageId,@JsonKey(name: 'last_sent_at') String? lastSentAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$ChatRoomDtoCopyWithImpl<$Res>
    implements _$ChatRoomDtoCopyWith<$Res> {
  __$ChatRoomDtoCopyWithImpl(this._self, this._then);

  final _ChatRoomDto _self;
  final $Res Function(_ChatRoomDto) _then;

/// Create a copy of ChatRoomDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? ownerUserId = freezed,Object? title = freezed,Object? lastPreview = freezed,Object? lastMessageId = freezed,Object? lastSentAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ChatRoomDto(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,lastPreview: freezed == lastPreview ? _self.lastPreview : lastPreview // ignore: cast_nullable_to_non_nullable
as String?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as int?,lastSentAt: freezed == lastSentAt ? _self.lastSentAt : lastSentAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatRoomsResponseDto {

 String? get status; List<ChatRoomDto> get data;
/// Create a copy of ChatRoomsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomsResponseDtoCopyWith<ChatRoomsResponseDto> get copyWith => _$ChatRoomsResponseDtoCopyWithImpl<ChatRoomsResponseDto>(this as ChatRoomsResponseDto, _$identity);

  /// Serializes this ChatRoomsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomsResponseDto&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ChatRoomsResponseDto(status: $status, data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatRoomsResponseDtoCopyWith<$Res>  {
  factory $ChatRoomsResponseDtoCopyWith(ChatRoomsResponseDto value, $Res Function(ChatRoomsResponseDto) _then) = _$ChatRoomsResponseDtoCopyWithImpl;
@useResult
$Res call({
 String? status, List<ChatRoomDto> data
});




}
/// @nodoc
class _$ChatRoomsResponseDtoCopyWithImpl<$Res>
    implements $ChatRoomsResponseDtoCopyWith<$Res> {
  _$ChatRoomsResponseDtoCopyWithImpl(this._self, this._then);

  final ChatRoomsResponseDto _self;
  final $Res Function(ChatRoomsResponseDto) _then;

/// Create a copy of ChatRoomsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? data = null,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<ChatRoomDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoomsResponseDto].
extension ChatRoomsResponseDtoPatterns on ChatRoomsResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoomsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoomsResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoomsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoomsResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoomsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoomsResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? status,  List<ChatRoomDto> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoomsResponseDto() when $default != null:
return $default(_that.status,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? status,  List<ChatRoomDto> data)  $default,) {final _that = this;
switch (_that) {
case _ChatRoomsResponseDto():
return $default(_that.status,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? status,  List<ChatRoomDto> data)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoomsResponseDto() when $default != null:
return $default(_that.status,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoomsResponseDto extends ChatRoomsResponseDto {
  const _ChatRoomsResponseDto({this.status, required final  List<ChatRoomDto> data}): _data = data,super._();
  factory _ChatRoomsResponseDto.fromJson(Map<String, dynamic> json) => _$ChatRoomsResponseDtoFromJson(json);

@override final  String? status;
 final  List<ChatRoomDto> _data;
@override List<ChatRoomDto> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of ChatRoomsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomsResponseDtoCopyWith<_ChatRoomsResponseDto> get copyWith => __$ChatRoomsResponseDtoCopyWithImpl<_ChatRoomsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoomsResponseDto&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ChatRoomsResponseDto(status: $status, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomsResponseDtoCopyWith<$Res> implements $ChatRoomsResponseDtoCopyWith<$Res> {
  factory _$ChatRoomsResponseDtoCopyWith(_ChatRoomsResponseDto value, $Res Function(_ChatRoomsResponseDto) _then) = __$ChatRoomsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String? status, List<ChatRoomDto> data
});




}
/// @nodoc
class __$ChatRoomsResponseDtoCopyWithImpl<$Res>
    implements _$ChatRoomsResponseDtoCopyWith<$Res> {
  __$ChatRoomsResponseDtoCopyWithImpl(this._self, this._then);

  final _ChatRoomsResponseDto _self;
  final $Res Function(_ChatRoomsResponseDto) _then;

/// Create a copy of ChatRoomsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? data = null,}) {
  return _then(_ChatRoomsResponseDto(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ChatRoomDto>,
  ));
}


}


/// @nodoc
mixin _$ChatMessagesResponseDto {

 String? get status;@JsonKey(name: 'room_id') int get roomId; List<ChatMessageDto> get messages;
/// Create a copy of ChatMessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessagesResponseDtoCopyWith<ChatMessagesResponseDto> get copyWith => _$ChatMessagesResponseDtoCopyWithImpl<ChatMessagesResponseDto>(this as ChatMessagesResponseDto, _$identity);

  /// Serializes this ChatMessagesResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessagesResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,roomId,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'ChatMessagesResponseDto(status: $status, roomId: $roomId, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatMessagesResponseDtoCopyWith<$Res>  {
  factory $ChatMessagesResponseDtoCopyWith(ChatMessagesResponseDto value, $Res Function(ChatMessagesResponseDto) _then) = _$ChatMessagesResponseDtoCopyWithImpl;
@useResult
$Res call({
 String? status,@JsonKey(name: 'room_id') int roomId, List<ChatMessageDto> messages
});




}
/// @nodoc
class _$ChatMessagesResponseDtoCopyWithImpl<$Res>
    implements $ChatMessagesResponseDtoCopyWith<$Res> {
  _$ChatMessagesResponseDtoCopyWithImpl(this._self, this._then);

  final ChatMessagesResponseDto _self;
  final $Res Function(ChatMessagesResponseDto) _then;

/// Create a copy of ChatMessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? roomId = null,Object? messages = null,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessagesResponseDto].
extension ChatMessagesResponseDtoPatterns on ChatMessagesResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessagesResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessagesResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessagesResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessagesResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessagesResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessagesResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? status, @JsonKey(name: 'room_id')  int roomId,  List<ChatMessageDto> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessagesResponseDto() when $default != null:
return $default(_that.status,_that.roomId,_that.messages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? status, @JsonKey(name: 'room_id')  int roomId,  List<ChatMessageDto> messages)  $default,) {final _that = this;
switch (_that) {
case _ChatMessagesResponseDto():
return $default(_that.status,_that.roomId,_that.messages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? status, @JsonKey(name: 'room_id')  int roomId,  List<ChatMessageDto> messages)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessagesResponseDto() when $default != null:
return $default(_that.status,_that.roomId,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessagesResponseDto extends ChatMessagesResponseDto {
  const _ChatMessagesResponseDto({this.status, @JsonKey(name: 'room_id') required this.roomId, required final  List<ChatMessageDto> messages}): _messages = messages,super._();
  factory _ChatMessagesResponseDto.fromJson(Map<String, dynamic> json) => _$ChatMessagesResponseDtoFromJson(json);

@override final  String? status;
@override@JsonKey(name: 'room_id') final  int roomId;
 final  List<ChatMessageDto> _messages;
@override List<ChatMessageDto> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatMessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessagesResponseDtoCopyWith<_ChatMessagesResponseDto> get copyWith => __$ChatMessagesResponseDtoCopyWithImpl<_ChatMessagesResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessagesResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessagesResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,roomId,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ChatMessagesResponseDto(status: $status, roomId: $roomId, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ChatMessagesResponseDtoCopyWith<$Res> implements $ChatMessagesResponseDtoCopyWith<$Res> {
  factory _$ChatMessagesResponseDtoCopyWith(_ChatMessagesResponseDto value, $Res Function(_ChatMessagesResponseDto) _then) = __$ChatMessagesResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String? status,@JsonKey(name: 'room_id') int roomId, List<ChatMessageDto> messages
});




}
/// @nodoc
class __$ChatMessagesResponseDtoCopyWithImpl<$Res>
    implements _$ChatMessagesResponseDtoCopyWith<$Res> {
  __$ChatMessagesResponseDtoCopyWithImpl(this._self, this._then);

  final _ChatMessagesResponseDto _self;
  final $Res Function(_ChatMessagesResponseDto) _then;

/// Create a copy of ChatMessagesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? roomId = null,Object? messages = null,}) {
  return _then(_ChatMessagesResponseDto(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as int,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageDto>,
  ));
}


}

// dart format on
