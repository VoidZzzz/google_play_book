import 'package:google_play_book/persistence/hive_constant.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'books_vo.dart';

part 'shelf_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SHELF_VO, adapterName: "ShelfVOAdapter")
class ShelfVO {

  @HiveField(0)
  String? shelfName;

  @HiveField(1)
  int? shelfId;

  @HiveField(2)
  List<BooksVO>? books;

  @HiveField(3)
  bool isSelected = false;

  ShelfVO(this.shelfName, this.shelfId, this.books, this.isSelected);
}
