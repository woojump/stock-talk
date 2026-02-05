// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResultDto _$SearchResultDtoFromJson(Map<String, dynamic> json) =>
    _SearchResultDto(
      ticker: json['srtnCd'] as String,
      name: json['itmsNm'] as String,
    );

Map<String, dynamic> _$SearchResultDtoToJson(_SearchResultDto instance) =>
    <String, dynamic>{'srtnCd': instance.ticker, 'itmsNm': instance.name};
