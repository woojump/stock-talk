// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PopularNewsResponseDto {

@JsonKey(name: 'target_stocks') List<String> get targetStocks; List<NewsItemDto> get news;
/// Create a copy of PopularNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularNewsResponseDtoCopyWith<PopularNewsResponseDto> get copyWith => _$PopularNewsResponseDtoCopyWithImpl<PopularNewsResponseDto>(this as PopularNewsResponseDto, _$identity);

  /// Serializes this PopularNewsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularNewsResponseDto&&const DeepCollectionEquality().equals(other.targetStocks, targetStocks)&&const DeepCollectionEquality().equals(other.news, news));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(targetStocks),const DeepCollectionEquality().hash(news));

@override
String toString() {
  return 'PopularNewsResponseDto(targetStocks: $targetStocks, news: $news)';
}


}

/// @nodoc
abstract mixin class $PopularNewsResponseDtoCopyWith<$Res>  {
  factory $PopularNewsResponseDtoCopyWith(PopularNewsResponseDto value, $Res Function(PopularNewsResponseDto) _then) = _$PopularNewsResponseDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'target_stocks') List<String> targetStocks, List<NewsItemDto> news
});




}
/// @nodoc
class _$PopularNewsResponseDtoCopyWithImpl<$Res>
    implements $PopularNewsResponseDtoCopyWith<$Res> {
  _$PopularNewsResponseDtoCopyWithImpl(this._self, this._then);

  final PopularNewsResponseDto _self;
  final $Res Function(PopularNewsResponseDto) _then;

/// Create a copy of PopularNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetStocks = null,Object? news = null,}) {
  return _then(_self.copyWith(
targetStocks: null == targetStocks ? _self.targetStocks : targetStocks // ignore: cast_nullable_to_non_nullable
as List<String>,news: null == news ? _self.news : news // ignore: cast_nullable_to_non_nullable
as List<NewsItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PopularNewsResponseDto].
extension PopularNewsResponseDtoPatterns on PopularNewsResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PopularNewsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PopularNewsResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PopularNewsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _PopularNewsResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PopularNewsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _PopularNewsResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'target_stocks')  List<String> targetStocks,  List<NewsItemDto> news)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PopularNewsResponseDto() when $default != null:
return $default(_that.targetStocks,_that.news);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'target_stocks')  List<String> targetStocks,  List<NewsItemDto> news)  $default,) {final _that = this;
switch (_that) {
case _PopularNewsResponseDto():
return $default(_that.targetStocks,_that.news);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'target_stocks')  List<String> targetStocks,  List<NewsItemDto> news)?  $default,) {final _that = this;
switch (_that) {
case _PopularNewsResponseDto() when $default != null:
return $default(_that.targetStocks,_that.news);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PopularNewsResponseDto extends PopularNewsResponseDto {
  const _PopularNewsResponseDto({@JsonKey(name: 'target_stocks') required final  List<String> targetStocks, required final  List<NewsItemDto> news}): _targetStocks = targetStocks,_news = news,super._();
  factory _PopularNewsResponseDto.fromJson(Map<String, dynamic> json) => _$PopularNewsResponseDtoFromJson(json);

 final  List<String> _targetStocks;
@override@JsonKey(name: 'target_stocks') List<String> get targetStocks {
  if (_targetStocks is EqualUnmodifiableListView) return _targetStocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetStocks);
}

 final  List<NewsItemDto> _news;
@override List<NewsItemDto> get news {
  if (_news is EqualUnmodifiableListView) return _news;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_news);
}


/// Create a copy of PopularNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularNewsResponseDtoCopyWith<_PopularNewsResponseDto> get copyWith => __$PopularNewsResponseDtoCopyWithImpl<_PopularNewsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularNewsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularNewsResponseDto&&const DeepCollectionEquality().equals(other._targetStocks, _targetStocks)&&const DeepCollectionEquality().equals(other._news, _news));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_targetStocks),const DeepCollectionEquality().hash(_news));

@override
String toString() {
  return 'PopularNewsResponseDto(targetStocks: $targetStocks, news: $news)';
}


}

/// @nodoc
abstract mixin class _$PopularNewsResponseDtoCopyWith<$Res> implements $PopularNewsResponseDtoCopyWith<$Res> {
  factory _$PopularNewsResponseDtoCopyWith(_PopularNewsResponseDto value, $Res Function(_PopularNewsResponseDto) _then) = __$PopularNewsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'target_stocks') List<String> targetStocks, List<NewsItemDto> news
});




}
/// @nodoc
class __$PopularNewsResponseDtoCopyWithImpl<$Res>
    implements _$PopularNewsResponseDtoCopyWith<$Res> {
  __$PopularNewsResponseDtoCopyWithImpl(this._self, this._then);

  final _PopularNewsResponseDto _self;
  final $Res Function(_PopularNewsResponseDto) _then;

/// Create a copy of PopularNewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetStocks = null,Object? news = null,}) {
  return _then(_PopularNewsResponseDto(
targetStocks: null == targetStocks ? _self._targetStocks : targetStocks // ignore: cast_nullable_to_non_nullable
as List<String>,news: null == news ? _self._news : news // ignore: cast_nullable_to_non_nullable
as List<NewsItemDto>,
  ));
}


}


/// @nodoc
mixin _$NewsItemDto {

 String get title;@JsonKey(name: 'pubDate') String get pubDate;@JsonKey(name: 'stock_name') String get stockName; String? get description; String? get link;
/// Create a copy of NewsItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsItemDtoCopyWith<NewsItemDto> get copyWith => _$NewsItemDtoCopyWithImpl<NewsItemDto>(this as NewsItemDto, _$identity);

  /// Serializes this NewsItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsItemDto&&(identical(other.title, title) || other.title == title)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.stockName, stockName) || other.stockName == stockName)&&(identical(other.description, description) || other.description == description)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,pubDate,stockName,description,link);

@override
String toString() {
  return 'NewsItemDto(title: $title, pubDate: $pubDate, stockName: $stockName, description: $description, link: $link)';
}


}

/// @nodoc
abstract mixin class $NewsItemDtoCopyWith<$Res>  {
  factory $NewsItemDtoCopyWith(NewsItemDto value, $Res Function(NewsItemDto) _then) = _$NewsItemDtoCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(name: 'pubDate') String pubDate,@JsonKey(name: 'stock_name') String stockName, String? description, String? link
});




}
/// @nodoc
class _$NewsItemDtoCopyWithImpl<$Res>
    implements $NewsItemDtoCopyWith<$Res> {
  _$NewsItemDtoCopyWithImpl(this._self, this._then);

  final NewsItemDto _self;
  final $Res Function(NewsItemDto) _then;

/// Create a copy of NewsItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? pubDate = null,Object? stockName = null,Object? description = freezed,Object? link = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as String,stockName: null == stockName ? _self.stockName : stockName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsItemDto].
extension NewsItemDtoPatterns on NewsItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsItemDto value)  $default,){
final _that = this;
switch (_that) {
case _NewsItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _NewsItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'pubDate')  String pubDate, @JsonKey(name: 'stock_name')  String stockName,  String? description,  String? link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsItemDto() when $default != null:
return $default(_that.title,_that.pubDate,_that.stockName,_that.description,_that.link);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'pubDate')  String pubDate, @JsonKey(name: 'stock_name')  String stockName,  String? description,  String? link)  $default,) {final _that = this;
switch (_that) {
case _NewsItemDto():
return $default(_that.title,_that.pubDate,_that.stockName,_that.description,_that.link);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(name: 'pubDate')  String pubDate, @JsonKey(name: 'stock_name')  String stockName,  String? description,  String? link)?  $default,) {final _that = this;
switch (_that) {
case _NewsItemDto() when $default != null:
return $default(_that.title,_that.pubDate,_that.stockName,_that.description,_that.link);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsItemDto extends NewsItemDto {
  const _NewsItemDto({required this.title, @JsonKey(name: 'pubDate') required this.pubDate, @JsonKey(name: 'stock_name') required this.stockName, this.description, this.link}): super._();
  factory _NewsItemDto.fromJson(Map<String, dynamic> json) => _$NewsItemDtoFromJson(json);

@override final  String title;
@override@JsonKey(name: 'pubDate') final  String pubDate;
@override@JsonKey(name: 'stock_name') final  String stockName;
@override final  String? description;
@override final  String? link;

/// Create a copy of NewsItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsItemDtoCopyWith<_NewsItemDto> get copyWith => __$NewsItemDtoCopyWithImpl<_NewsItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsItemDto&&(identical(other.title, title) || other.title == title)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.stockName, stockName) || other.stockName == stockName)&&(identical(other.description, description) || other.description == description)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,pubDate,stockName,description,link);

@override
String toString() {
  return 'NewsItemDto(title: $title, pubDate: $pubDate, stockName: $stockName, description: $description, link: $link)';
}


}

/// @nodoc
abstract mixin class _$NewsItemDtoCopyWith<$Res> implements $NewsItemDtoCopyWith<$Res> {
  factory _$NewsItemDtoCopyWith(_NewsItemDto value, $Res Function(_NewsItemDto) _then) = __$NewsItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(name: 'pubDate') String pubDate,@JsonKey(name: 'stock_name') String stockName, String? description, String? link
});




}
/// @nodoc
class __$NewsItemDtoCopyWithImpl<$Res>
    implements _$NewsItemDtoCopyWith<$Res> {
  __$NewsItemDtoCopyWithImpl(this._self, this._then);

  final _NewsItemDto _self;
  final $Res Function(_NewsItemDto) _then;

/// Create a copy of NewsItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? pubDate = null,Object? stockName = null,Object? description = freezed,Object? link = freezed,}) {
  return _then(_NewsItemDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as String,stockName: null == stockName ? _self.stockName : stockName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
