// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_list_results_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoreListResultsVO _$MoreListResultsVOFromJson(Map<String, dynamic> json) =>
    MoreListResultsVO(
      json['list_name'] as String?,
      json['display_name'] as String?,
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['rank'] as int?,
      json['rank_last_week'] as int?,
      json['weeks_on_list'] as int?,
      json['asterisk'] as int?,
      json['dagger'] as int?,
      json['amazon_product_url'] as String?,
      (json['isbns'] as List<dynamic>?)
          ?.map((e) => IsbnsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['book_details'] as List<dynamic>?)
          ?.map((e) => BooksVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoreListResultsVOToJson(MoreListResultsVO instance) =>
    <String, dynamic>{
      'list_name': instance.listName,
      'display_name': instance.displayName,
      'bestsellers_date': instance.bestSellersDate,
      'published_date': instance.publishedDate,
      'rank': instance.rank,
      'rank_last_week': instance.rankLastWeek,
      'weeks_on_list': instance.weeksOnList,
      'asterisk': instance.asterIsk,
      'dagger': instance.dagger,
      'amazon_product_url': instance.amazonProductUrl,
      'isbns': instance.isbns,
      'book_details': instance.bookDetails,
      'reviews': instance.reviews,
    };
