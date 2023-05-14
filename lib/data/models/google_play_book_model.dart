import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/network/response/get_more_list_response.dart';

import '../../network/response/get_overview_response.dart';
import '../data_vos/shelf_vo.dart';

abstract class GooglePlayBookModel {
Future<GetOverviewResponse> getOverview(String apiKey);
Future<GetMoreListResponse> getMoreList(String apiKey, String list, String offset);
Future<void> saveBook(BooksVO book);
Future<List<BooksVO>> getSavedAllBooks();
Stream<List<BooksVO>> getSaveBookListStream();
Future<void> createShelf(ShelfVO shelf);
void addBookToShelf(BooksVO book);
Future<List<ShelfVO>> getAllShelves();
Stream<List<ShelfVO>> getAllShelvesStream();
Stream<ShelfVO> getBookByShelfStream(String name);
void deleteShelf(int shelfId);
Future<ShelfVO> renameShelf(int shelfId, String newName);
void setToDefault();
}