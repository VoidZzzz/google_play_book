import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/pages/book_details_page.dart';
import 'package:google_play_book/pages/home_page.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../data/data_vos/books_vo.dart';
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
  List<BooksVO>? savedBookList;

  @override
  void initState() {
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
                  setState(() {
                    onSubmit = true;
                  });
                },
              ),
              Visibility(
                visible: onSubmit,
                child: SizedBox(
                  height: 295,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const CategoryTitleView(
                        listViewTitle: "From your Library",
                      ),
                      SizedBox(
                          height: 245,
                          child: ListView.builder(
                            itemBuilder: (context, index) => BookView(
                              onTapMenu: () {},
                              bookCover: savedBookList?[index].bookImage ?? "",
                              bookName: savedBookList?[index].title ?? "",
                              bookAuthorName:
                                  savedBookList?[index].author ?? "",
                              onTapBookView: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BookDetails(
                                        bookDetails: savedBookList?[index],
                                        bookLists: null),
                                  ),
                                );
                              },
                            ),
                            itemCount: savedBookList?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                          )),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: onChanged,
                child: SizedBox(
                  height: 772,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                              height: 50,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextView(
                                    text: "Results from Google Play",
                                    fontColor: Colors.black,
                                    fontSize: 16,
                                  ))),
                        );
                      } else {
                        return Padding(
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
                                    "https://c4.wallpaperflare.com/wallpaper/59/782/494/birds-viking-axe-cross-horns-hd-wallpaper-preview.jpg",
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
                                    children: const [
                                      TextView(
                                        text: "The man on a Mission",
                                        fontColor: Colors.black87,
                                        fontSize: 15,
                                      ),
                                      TextView(
                                        text: "Paular Hawkkins",
                                        fontColor: Colors.black54,
                                      ),
                                      TextView(
                                        text: "Ebool",
                                        fontColor: Colors.black54,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
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
  const AppBarView({
    Key? key,
    required this.controller,
    required this.onTapBack,
    required this.onChangedText,
    required this.onSubmitText,
  }) : super(key: key);

  final TextEditingController controller;
  final Function onTapBack;
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
          const IconView(
              icon: Icons.clear, iconColor: Colors.black54, iconSize: 25),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
