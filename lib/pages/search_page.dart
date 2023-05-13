import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/blocs/search_bloc.dart';
import 'package:google_play_book/data/models/google_search_model.dart';
import 'package:google_play_book/data/models/google_search_model_impl.dart';
import 'package:google_play_book/pages/book_details_page.dart';
import 'package:google_play_book/pages/home_page.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:provider/provider.dart';

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

  SearchBloc bloc = SearchBloc();

  void _searchBook(BuildContext context, String text) {
    bloc = Provider.of<SearchBloc>(context, listen: false);
    bloc.onUserSubmit();
    bloc.getGoogleSearch(text);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bloc,
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AppBarView(
                    onTapClear: () => _searchController.clear(),
                    controller: _searchController,
                    onTapBack: () => Navigator.of(context).pop(),
                    onSubmitText: (text) {
                      _searchBook(context, text);
                    },
                  ),
                  Selector<SearchBloc, bool>(
                    selector: (context, bloc) => bloc.onSubmit,
                    builder: (context, onSubmit, child) => Visibility(
                      visible: onSubmit,
                      child: SizedBox(
                        height: 772,
                        child: Selector<SearchBloc, List<BooksVO>?>(
                          selector: (context, bloc) => bloc.searchItems,
                          builder: (context, searchItems, child) => (bloc
                                      .searchItems !=
                                  null)
                              ? ListView.builder(
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
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 20),
                                        child: SizedBox(
                                          height: 80,
                                          child: Row(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                height: 75,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Image.network(
                                                  searchItems?[index]
                                                          .bookImage ??
                                                      "",
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextView(
                                                      fontColor: Colors.black87,
                                                      fontSize: 15,
                                                      text: searchItems?[index]
                                                              .title ??
                                                          "",
                                                    ),
                                                    TextView(
                                                      text: searchItems?[index]
                                                              .author ??
                                                          "",
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
                                )
                              : const CircularProgressIndicatorView(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CircularProgressIndicatorView extends StatelessWidget {
  const CircularProgressIndicatorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
          color: LIGHT_THEME_SELECTED_CHIP_COLOR,
        ),
      );
  }
}

class AppBarView extends StatefulWidget {
  const AppBarView(
      {Key? key,
      required this.controller,
      required this.onTapBack,
      required this.onSubmitText,
      required this.onTapClear})
      : super(key: key);

  final TextEditingController controller;
  final Function onTapBack;
  final Function onTapClear;
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
            width: 5,
          ),
          InkWell(
            onTap: () => widget.onTapBack(),
            child: const IconView(
                icon: Icons.keyboard_arrow_left,
                iconColor: Colors.black54,
                iconSize: 33),
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              cursorHeight: 23,
              cursorWidth: 1.5,
              controller: widget.controller,
              cursorColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
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
