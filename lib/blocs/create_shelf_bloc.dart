import 'package:flutter/foundation.dart';
import '../data/data_vos/shelf_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';

class CreateShelfBloc extends ChangeNotifier {
  /// Model
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  bool isDisposed = false;

  void createNewShelf(str) {
    model.createShelf(
      ShelfVO(str, DateTime.now().millisecond, [], false),
    );
    print('----------------> create');
    notifyListeners();
  }

  void checkNotifyListener() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void clearDisposeNotify() {
    if (!isDisposed) {
      isDisposed = true;
    }
  }
}
