import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/colors.dart';
class DefaultAppBarView extends StatelessWidget {
  const DefaultAppBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: APP_SECONDARY_COLOR),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.68,
                    child: TextFormField(
                      cursorColor: Colors.blueGrey,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        hintText: "Search Play Books",
                        hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500, color: Colors.grey),
                        enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset("images/cat2.jpg"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
