import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../persistence/hive_constant.dart';
import 'buy_links_vo.dart';

part 'books_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_VO, adapterName: "BookVOAdapter")
class BooksVO{

  @JsonKey(name: "age_group")
  @HiveField(0)
  String? ageGroup;

  @JsonKey(name: "amazon_product_url")
  @HiveField(1)
  String? amazonProductUrlLink;

  @JsonKey(name: "article_chapter_link")
  @HiveField(2)
  String? articleChapterLink;

  @JsonKey(name: "author")
  @HiveField(3)
  String? author;

  @JsonKey(name: "book_image")
  @HiveField(4)
  String? bookImage;

  @JsonKey(name: "book_image_width")
  @HiveField(5)
  int? bookImageWidth;

  @JsonKey(name: "book_image_height")
  @HiveField(6)
  int? bookImageHeight;

  @JsonKey(name: "book_review_link")
  @HiveField(7)
  String? bookReviewLink;

  @JsonKey(name: "contributor")
  @HiveField(8)
  String? contributor;

  @JsonKey(name: "contributor_note")
  @HiveField(9)
  String? contributorNote;

  @JsonKey(name: "created_date")
  @HiveField(10)
  String? createdDate;

  @JsonKey(name: "description")
  @HiveField(11)
  String? description;

  @JsonKey(name: "first_chapter_link")
  @HiveField(12)
  String? firstChapterLink;

  @JsonKey(name: "price")
  @HiveField(13)
  String? price;

  @JsonKey(name: "primary_isbn10")
  @HiveField(14)
  String? primaryISBN10;

  @JsonKey(name: "primary_isbn13")
  @HiveField(15)
  String? primaryISBN13;

  @JsonKey(name: "book_uri")
  @HiveField(16)
  String? bookUri;

  @JsonKey(name: "publisher")
  @HiveField(17)
  String? publisher;

  @JsonKey(name: "rank")
  @HiveField(18)
  int? rank;

  @JsonKey(name: "rank_last_week")
  @HiveField(19)
  int? rankLastWeek;

  @JsonKey(name: "sunday_review_link")
  @HiveField(20)
  String? sundayReviewLink;

  @JsonKey(name: "title")
  @HiveField(21)
  String? title;

  @JsonKey(name: "updated_date")
  @HiveField(22)
  String? updatedDate;

  @JsonKey(name: "weeks_on_list")
  @HiveField(23)
  int? weeksOnList;

  @JsonKey(name: "buy_links")
  @HiveField(24)
  List<BuyLinksVO>? buyLinks;


  @HiveField(25)
  int? saveTime;

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