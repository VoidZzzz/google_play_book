import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data_vos/shelf_vo.dart';
class ShelfView extends StatelessWidget {
  const ShelfView({Key? key, required this.shelf}) : super(key: key);

  final ShelfVO shelf;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey("Educational"),
      height: 101,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                clipBehavior: Clip.antiAlias,
                width: 55,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: (shelf.books?.isEmpty ?? true)
                    ? Container(
                  color: Colors.black26,
                )
                    : Image.network(
                  shelf.books?.last.bookImage ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 230,
                child: Text(
                  shelf.shelfName ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ),
              Text(
                "${shelf.books?.length ?? 0} books",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}