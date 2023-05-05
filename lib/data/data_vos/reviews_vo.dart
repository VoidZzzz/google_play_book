import 'package:json_annotation/json_annotation.dart';

part 'reviews_vo.g.dart';

@JsonSerializable()
class ReviewsVO{

  @JsonKey(name: "book_review_link")
  String? bookReviewLink;

  @JsonKey(name: "first_chapter_link")
  String? firstChapterLink;

  @JsonKey(name: "sunday_review_link")
  String? sundayReviewLink;

  @JsonKey(name: "article_chapter_link")
  String? articleChapterLink;

  ReviewsVO(this.bookReviewLink, this.firstChapterLink, this.sundayReviewLink,
      this.articleChapterLink);

  factory ReviewsVO.fromJson(Map<String, dynamic> json) => _$ReviewsVOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsVOToJson(this);
}