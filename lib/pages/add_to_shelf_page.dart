import 'package:flutter/material.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/persistence/daos/shelf_dao.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import '../data/data_vos/shelf_vo.dart';
import '../data/models/google_play_book_model_impl.dart';

class AddToShelfPage extends StatefulWidget {
  const AddToShelfPage({Key? key, required this.selectedBook})
      : super(key: key);

  final BooksVO selectedBook;

  @override
  State<AddToShelfPage> createState() => _AddToShelfPageState();
}

class _AddToShelfPageState extends State<AddToShelfPage> {
  GooglePlayBookModel model = GooglePlayBookModelImpl();
  List<ShelfVO>? allShelf;

  @override
  void initState() {

    model.getAllShelvesStream().listen((value) {
      setState(() {
        allShelf = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarView(
          onTapDone: () {
            allShelf = allShelf
                    ?.where((element) => element.isSelected == true)
                    .toList() ??
                [];
            model.addBookToShelf(widget.selectedBook);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: allShelf?.length ?? 0,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 90,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: GREY_COLOR, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 75,
                    width: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: (allShelf?[index].books?.isEmpty ?? true)
                        ? Container(
                            color: GREY_COLOR,
                          )
                        : Image.network(
                            allShelf?[index].books?.last.bookImage ?? "", fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: allShelf?[index].shelfName ?? "",
                        fontColor: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 5,),
                      TextView(
                        text: "${allShelf?[index].books?.length ?? 0} books",
                        fontColor: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      allShelf?[index].isSelected =
                          !(allShelf?[index].isSelected ?? false);
                    });
                  },
                  child: allShelf?[index].isSelected ?? false
                      ? const IconView(
                          icon: Icons.check_box_outlined,
                          iconColor: Colors.black87,
                          iconSize: 22)
                      : const IconView(
                          icon: Icons.check_box_outline_blank,
                          iconColor: Colors.black87,
                          iconSize: 22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarView extends StatelessWidget {
  const AppBarView({Key? key, required this.onTapDone}) : super(key: key);

  final Function onTapDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.12,
        ),
        const TextView(
          text: "Add to Shelves",
          fontColor: Colors.black87,
          fontSize: 18,
        ),
        const Spacer(),
        InkWell(
          onTap: () => onTapDone(),
          child: const TextView(text: "Done", fontColor: LIGHT_THEME_SELECTED_CHIP_COLOR, fontSize: 16,),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
