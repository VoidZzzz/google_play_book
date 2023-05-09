import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/data/models/google_search_model.dart';
import 'package:google_play_book/data/models/google_search_model_impl.dart';
import 'package:google_play_book/pages/book_details_page.dart';
import 'package:google_play_book/pages/home_page.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../data/data_vos/books_vo.dart';
import '../data/data_vos/items_vo.dart';
import '../data/models/google_play_book_model.dart';
import '../data/models/google_play_book_model_impl.dart';
import '../resources/colors.dart';
import 'book_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  bool onChanged = false;
  bool onSubmit = false;

  GooglePlayBookModel model = GooglePlayBookModelImpl();
  GoogleSearchModel gModel = GoogleSearchModelImpl();
  List<BooksVO>? savedBookList;
  List<BooksVO>? searchItems;

  @override
  void initState() {
    /// persistence layer
    model.getSavedAllBooks().then((value) {
      setState(() {
        savedBookList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBarView(
                onTapClear: () => _searchController.clear(),
                controller: _searchController,
                onTapBack: () => Navigator.of(context).pop(),
                onChangedText: (str) {
                  if (str.isNotEmpty) {
                    setState(() {
                      onChanged = true;
                      onSubmit = false;
                    });
                  } else {
                    setState(() {
                      onChanged = false;
                    });
                  }
                },
                onSubmitText: (text) {
                  /// GoogleSearch Api
                  gModel.getGoogleSearch(text)?.then((searchResponse) {
                    setState(() {
                      searchItems = searchResponse;
                    });
                    print("Search fst ============> ${searchItems?.length}");
                  });
                  setState(() {
                    onSubmit = true;
                  });
                },
              ),
              // Visibility(
              //   visible: onSubmit,
              //   child: SizedBox(
              //     height: 295,
              //     width: double.infinity,
              //     child: Column(
              //       children: [
              //         const CategoryTitleView(
              //           listViewTitle: "From your Library",
              //         ),
              //         SizedBox(
              //             height: 245,
              //             child: ListView.builder(
              //               itemBuilder: (context, index) => BookView(
              //                 onTapMenu: () {},
              //                 bookCover: savedBookList?[index].bookImage ?? "",
              //                 bookName: savedBookList?[index].title ?? "",
              //                 bookAuthorName:
              //                     savedBookList?[index].author ?? "",
              //                 onTapBookView: () {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder: (context) => BookDetails(
              //                           bookDetails: savedBookList?[index],
              //                           bookLists: null),
              //                     ),
              //                   );
              //                 },
              //               ),
              //               itemCount: savedBookList?.length ?? 0,
              //               scrollDirection: Axis.horizontal,
              //               shrinkWrap: true,
              //               padding: EdgeInsets.zero,
              //               physics: const BouncingScrollPhysics(),
              //             )),
              //       ],
              //     ),
              //   ),
              // ),
              Visibility(
                visible: onSubmit,
                child: SizedBox(
                  height: 772,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchItems?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookDetails(
                                bookDetails: searchItems?[index],
                                bookLists: null),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 20),
                          child: SizedBox(
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 75,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.network(
                                    searchItems?[index].bookImage ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextView(
                                        fontColor: Colors.black87,
                                        fontSize: 15,
                                        text: searchItems?[index].title ?? "",
                                      ),
                                      TextView(
                                        text: searchItems?[index].author ?? "",
                                        fontColor: Colors.black54,
                                      ),
                                      const TextView(
                                        text: "Ebook",
                                        fontColor: Colors.black54,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarView extends StatefulWidget {
  const AppBarView(
      {Key? key,
      required this.controller,
      required this.onTapBack,
      required this.onChangedText,
      required this.onSubmitText,
      required this.onTapClear})
      : super(key: key);

  final TextEditingController controller;
  final Function onTapBack;
  final Function onTapClear;
  final Function(String) onChangedText;
  final Function(String) onSubmitText;

  @override
  State<AppBarView> createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black54, width: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => widget.onTapBack(),
            child: const IconView(
                icon: Icons.keyboard_arrow_left,
                iconColor: Colors.black54,
                iconSize: 30),
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: widget.controller,
              cursorColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
              onChanged: (str) {
                widget.onChangedText(str);
              },
              onFieldSubmitted: (text) {
                widget.onSubmitText(text);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                hintText: "Search Play Books",
                hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, color: Colors.black54),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          InkWell(
            onTap: () => widget.onTapClear(),
            child: const IconView(
                icon: Icons.clear, iconColor: Colors.black54, iconSize: 25),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
