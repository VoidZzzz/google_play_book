// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksVO _$BooksVOFromJson(Map<String, dynamic> json) => BooksVO(
      json['age_group'] as String?,
      json['amazon_product_url'] as String?,
      json['article_chapter_link'] as String?,
      json['author'] as String?,
      json['book_image'] as String?,
      json['book_image_width'] as int?,
      json['book_image_height'] as int?,
      json['book_review_link'] as String?,
      json['contributor'] as String?,
      json['contributor_note'] as String?,
      json['created_date'] as String?,
      json['description'] as String?,
      json['first_chapter_link'] as String?,
      json['price'] as String?,
      json['primary_isbn10'] as String?,
      json['primary_isbn13'] as String?,
      json['book_uri'] as String?,
      json['publisher'] as String?,
      json['rank'] as int?,
      json['rank_last_week'] as int?,
      json['sunday_review_link'] as String?,
      json['title'] as String?,
      json['updated_date'] as String?,
      json['weeks_on_list'] as int?,
      (json['buy_links'] as List<dynamic>?)
          ?.map((e) => BuyLinksVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksVOToJson(BooksVO instance) => <String, dynamic>{
      'age_group': instance.ageGroup,
      'amazon_product_url': instance.amazonProductUrlLink,
      'article_chapter_link': instance.articleChapterLink,
      'author': instance.author,
      'book_image': instance.bookImage,
      'book_image_width': instance.bookImageWidth,
      'book_image_height': instance.bookImageHeight,
      'book_review_link': instance.bookReviewLink,
      'contributor': instance.contributor,
      'contributor_note': instance.contributorNote,
      'created_date': instance.createdDate,
      'description': instance.description,
      'first_chapter_link': instance.firstChapterLink,
      'price': instance.price,
      'primary_isbn10': instance.primaryISBN10,
      'primary_isbn13': instance.primaryISBN13,
      'book_uri': instance.bookUri,
      'publisher': instance.publisher,
      'rank': instance.rank,
      'rank_last_week': instance.rankLastWeek,
      'sunday_review_link': instance.sundayReviewLink,
      'title': instance.title,
      'updated_date': instance.updatedDate,
      'weeks_on_list': instance.weeksOnList,
      'buy_links': instance.buyLinks,
    };
