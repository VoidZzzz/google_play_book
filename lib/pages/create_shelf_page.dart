import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/blocs/add_to_shelf_bloc.dart';
import 'package:google_play_book/blocs/create_shelf_bloc.dart';
import 'package:google_play_book/blocs/your_books_bloc.dart';
import 'package:google_play_book/data/data_vos/shelf_vo.dart';
import 'package:google_play_book/data/models/google_play_book_model.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/divider_view.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:provider/provider.dart';

import '../data/models/google_play_book_model_impl.dart';

class CreateShelfPage extends StatefulWidget {
  const CreateShelfPage({Key? key}) : super(key: key);

  @override
  State<CreateShelfPage> createState() => _CreateShelfPageState();
}

class _CreateShelfPageState extends State<CreateShelfPage> {
  CreateShelfBloc bloc = CreateShelfBloc();
  AddToShelfBloc? addToShelfBloc;
  YourBooksBloc? yourBooksBloc;

  @override
  void dispose() {
    bloc.clearDisposeNotify();
    bloc.dispose();
    addToShelfBloc?.dispose();
    addToShelfBloc?.clearDisposeNotify();
    yourBooksBloc?.dispose();
    yourBooksBloc?.clearDisposeNotify();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateShelfBloc(),
      builder: (context,child){
        return Scaffold(
          backgroundColor: WHITE_COLOR,
          appBar: AppBar(
            leading: const IconView(
                icon: Icons.keyboard_arrow_left,
                iconColor: Colors.black87,
                iconSize: 30),
            title: const TextView(
              text: "Create shelf",
              fontSize: 18,
              fontColor: Colors.black87,
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: APP_TERTIARY_COLOR)),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    onFieldSubmitted: (str) {
                      CreateShelfBloc bloc = CreateShelfBloc();
                      bloc = Provider.of<CreateShelfBloc>(context, listen: false);
                      bloc.createNewShelf(str);
                      Navigator.of(context).pop();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: WHITE_COLOR,
                      hintText: 'Shelf name',
                      hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black45),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const DividerView(dividerColor: GREY_COLOR, dividerThickness: 0.5)
            ],
          ),
        );
      },
    );
  }
}
