
import 'package:hive/hive.dart';

import '../../data/data_vos/shelf_vo.dart';
import '../hive_constant.dart';

class ShelfDao{
  static final ShelfDao _singleton = ShelfDao._internal();

  factory ShelfDao(){
    return _singleton;
  }

  ShelfDao._internal();

  void createShelf(ShelfVO shelf) async {
    return getShelfBox().put(shelf.shelfName, shelf);
  }

  List<ShelfVO> getAllShelves() {
    return getShelfBox().values.toList();
  }

  Box<ShelfVO> getShelfBox(){
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }

}