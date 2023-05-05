import 'package:json_annotation/json_annotation.dart';
import 'books_vo.dart';

part 'lists_vo.g.dart';

@JsonSerializable()
class ListsVO{

  @JsonKey(name: "list_id")
  int? listId;

  @JsonKey(name: "list_name")
  String? listName;

  @JsonKey(name: "list_name_encoded")
  String? listNameEncoded;

  @JsonKey(name: "display_name")
  String? displayName;

  @JsonKey(name: "updated")
  String? updated;

  @JsonKey(name: "list_image")
  String? listImage;

  @JsonKey(name: "list_image_width")
  String? listImageWidth;

  @JsonKey(name: "list_image_height")
  String? listImageHeight;

  @JsonKey(name: "books")
  List<BooksVO>? books;

  ListsVO(
      this.listId,
      this.listName,
      this.listNameEncoded,
      this.displayName,
      this.updated,
      this.listImage,
      this.listImageWidth,
      this.listImageHeight,
      this.books);

  factory ListsVO.fromJson(Map<String, dynamic> json) => _$ListsVOFromJson(json);

  Map<String, dynamic> toJson() => _$ListsVOToJson(this);
}