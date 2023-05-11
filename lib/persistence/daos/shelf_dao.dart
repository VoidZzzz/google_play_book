import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import '../../data/data_vos/books_vo.dart';
import '../../data/data_vos/shelf_vo.dart';
import '../hive_constant.dart';

class ShelfDao{
  static final ShelfDao _singleton = ShelfDao._internal();

  factory ShelfDao(){
    return _singleton;
  }

  ShelfDao._internal();

  void createShelf(ShelfVO shelf) async {
    return getShelfBox().put(shelf.shelfId, shelf);
  }

  List<ShelfVO> getAllShelves() {
    return getShelfBox().values.toList();
  }

  Stream<List<ShelfVO>> getAllShelvesStream() {
    return Stream.value(getAllShelves());
  }

  Stream<void> getAllShelvesEventStream() {
    return getShelfBox().watch();
  }

  Box<ShelfVO> getShelfBox(){
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }

  void addBookToShelf(BooksVO book) async{
    List<ShelfVO> selectedShelf = getAllShelves().where((element) => element.isSelected == true).toList();
    List<int?> id = selectedShelf.map((e) => e.shelfId).toList();
    selectedShelf.mapIndexed((index,e) {
      e.books?.add(book);
      getShelfBox().put(id  [index], e);
      return e;
    }).toList();
  }

  void deleteShelf(int shelfId) {
    getShelfBox().delete(shelfId);
  }

  Future<ShelfVO> renameShelf(int shelfId, String newName) async{
    return getShelfById(shelfId).then((value) {
      value?.shelfName = newName;
      getShelfBox().put(shelfId, value!);
      return Future.value(value);
    });
  }

  Future<ShelfVO?> getShelfById(int shelfId) {
    return Future.value(getShelfBox().get(shelfId));
  }

}