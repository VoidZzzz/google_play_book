import 'package:flutter/material.dart';
import 'package:google_play_book/blocs/add_to_shelf_bloc.dart';
import 'package:google_play_book/blocs/shelf_details_bloc.dart';
import 'package:google_play_book/blocs/your_books_bloc.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:provider/provider.dart';

import '../blocs/home_bloc.dart';

class AddToShelfPage extends StatefulWidget {
  const AddToShelfPage({Key? key, required this.selectedBook})
      : super(key: key);

  final BooksVO selectedBook;

  @override
  State<AddToShelfPage> createState() => _AddToShelfPageState();
}

class _AddToShelfPageState extends State<AddToShelfPage> {
  AddToShelfBloc addToShelfBloc = AddToShelfBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    addToShelfBloc.clearDisposeNotify();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => addToShelfBloc,
      child: Consumer<AddToShelfBloc>(
          builder: (context, bloc, Widget? child)  {
            return Scaffold(
              appBar: AppBar(
                title: AppBarView(
                  onTapDone: () {
                    bloc.addBookToSelectedShelves(widget.selectedBook);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: bloc.allShelf?.length ?? 0,
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
                            child: (bloc.allShelf?[index].books?.isEmpty ?? true)
                                ? Container(
                                    color: GREY_COLOR,
                                  )
                                : Image.network(
                              bloc.allShelf?[index].books?.last.bookImage ??
                                        "",
                                    fit: BoxFit.cover,
                                  ),
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
                                text: bloc.allShelf?[index].shelfName ?? "",
                                fontColor: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextView(
                                text:
                                    "${bloc.allShelf?[index].books?.length ?? 0} books",
                                fontColor: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            bloc.setSelectedShelf(index);
                            // setState(() {
                            //   allShelf?[index].isSelected =
                            //   !(allShelf[index].isSelected ?? false);
                            // });
                          },
                          child: bloc.allShelf?[index].isSelected ?? false
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
          }),
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
          child: const TextView(
            text: "Done",
            fontColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
