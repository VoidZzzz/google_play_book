// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsVO _$ReviewsVOFromJson(Map<String, dynamic> json) => ReviewsVO(
      json['book_review_link'] as String?,
      json['first_chapter_link'] as String?,
      json['sunday_review_link'] as String?,
      json['article_chapter_link'] as String?,
    );

Map<String, dynamic> _$ReviewsVOToJson(ReviewsVO instance) => <String, dynamic>{
      'book_review_link': instance.bookReviewLink,
      'first_chapter_link': instance.firstChapterLink,
      'sunday_review_link': instance.sundayReviewLink,
      'article_chapter_link': instance.articleChapterLink,
    };
