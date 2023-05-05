import 'package:json_annotation/json_annotation.dart';
import 'buy_links_vo.dart';

part 'books_vo.g.dart';

@JsonSerializable()
class BooksVO{

  @JsonKey(name: "age_group")
  String? ageGroup;

  @JsonKey(name: "amazon_product_url")
  String? amazonProductUrlLink;

  @JsonKey(name: "article_chapter_link")
  String? articleChapterLink;

  @JsonKey(name: "author")
  String? author;

  @JsonKey(name: "book_image")
  String? bookImage;

  @JsonKey(name: "book_image_width")
  int? bookImageWidth;

  @JsonKey(name: "book_image_height")
  int? bookImageHeight;

  @JsonKey(name: "book_review_link")
  String? bookReviewLink;

  @JsonKey(name: "contributor")
  String? contributor;

  @JsonKey(name: "contributor_note")
  String? contributorNote;

  @JsonKey(name: "created_date")
  String? createdDate;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "first_chapter_link")
  String? firstChapterLink;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "primary_isbn10")
  String? primaryISBN10;

  @JsonKey(name: "primary_isbn13")
  String? primaryISBN13;

  @JsonKey(name: "book_uri")
  String? bookUri;

  @JsonKey(name: "publisher")
  String? publisher;

  @JsonKey(name: "rank")
  int? rank;

  @JsonKey(name: "rank_last_week")
  int? rankLastWeek;

  @JsonKey(name: "sunday_review_link")
  String? sundayReviewLink;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "updated_date")
  String? updatedDate;

  @JsonKey(name: "weeks_on_list")
  int? weeksOnList;

  @JsonKey(name: "buy_links")
  List<BuyLinksVO>? buyLinks;

  BooksVO(
      this.ageGroup,
      this.amazonProductUrlLink,
      this.articleChapterLink,
      this.author,
      this.bookImage,
      this.bookImageWidth,
      this.bookImageHeight,
      this.bookReviewLink,
      this.contributor,
      this.contributorNote,
      this.createdDate,
      this.description,
      this.firstChapterLink,
      this.price,
      this.primaryISBN10,
      this.primaryISBN13,
      this.bookUri,
      this.publisher,
      this.rank,
      this.rankLastWeek,
      this.sundayReviewLink,
      this.title,
      this.updatedDate,
      this.weeksOnList,
      this.buyLinks);

  factory BooksVO.fromJson(Map<String, dynamic> json) => _$BooksVOFromJson(json);

  Map<String, dynamic> toJson() => _$BooksVOToJson(this);
}