import 'package:bizzie_co/data/models/user_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'card_detail_page.dart';

class AddNewCardPage extends StatelessWidget {
  static const String id = '/add_new_card_page';
  const AddNewCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Spacer(),
                  AutoSizeText('Add New Card',
                      maxLines: 1,
                      minFontSize: 14,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            Text('Choose a template!',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 20,
            ),

            // first template
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, CardDetailPage.id,
                    arguments: CardTemplate.regular);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                // height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(-5, 5))
                    ]),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: LayoutBuilder(
                    builder: (context, constraint) => regularCard(constraint),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // second template
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, CardDetailPage.id,
                    arguments: CardTemplate.horizontalHalf);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                // height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(-5, 5))
                    ]),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: LayoutBuilder(
                    builder: (context, constraint) =>
                        horizontalHalf(constraint),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // third template
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, CardDetailPage.id,
                    arguments: CardTemplate.verticalHalf);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                // height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(-5, 5))
                    ]),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: LayoutBuilder(
                    builder: (context, constraint) => verticalHalf(constraint),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Container regularCard(BoxConstraints constraint) {
    return Container(
      height: constraint.maxHeight,
      width: constraint.maxWidth,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AutoSizeText('First Last',
              maxLines: 1,
              minFontSize: 12,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: AutoSizeText('Profession',
                maxLines: 1,
                minFontSize: 10,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.15,
          ),
          const AutoSizeText('123 456 7890',
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: constraint.maxHeight * 0.03,
          ),
          const AutoSizeText('email',
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: constraint.maxHeight * 0.03,
          ),
          const AutoSizeText('website',
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  // vertical half
  Column verticalHalf(BoxConstraints constraint) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: constraint.maxWidth / 10,
              vertical: constraint.maxWidth / 15),
          width: constraint.maxWidth,
          height: constraint.maxHeight / 2,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              AutoSizeText('First Last',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 5,
              ),
              AutoSizeText('Profession',
                  maxLines: 1,
                  minFontSize: 12,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: constraint.maxWidth / 10,
              vertical: constraint.maxWidth / 20),
          width: constraint.maxWidth,
          height: constraint.maxHeight / 2,
          color: Colors.grey[400],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              const AutoSizeText('123 456 7890',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
              SizedBox(
                height: constraint.maxHeight * 0.015,
              ),
              const AutoSizeText('email',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
              SizedBox(
                height: constraint.maxHeight * 0.015,
              ),
              const AutoSizeText('www.google.com',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ],
    );
  }

  // horizontal half
  Row horizontalHalf(BoxConstraints constraint) {
    return Row(
      children: [
        Container(
          width: constraint.maxWidth / 2.2,
          height: constraint.maxHeight,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText('Profession',
                    maxLines: 1,
                    minFontSize: 12,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: AutoSizeText('Location',
                    maxLines: 1,
                    minFontSize: 10,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12).copyWith(bottom: 20),
          width: constraint.maxWidth * (1 - 1 / 2.2),
          height: constraint.maxHeight,
          color: Colors.grey[400],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const AutoSizeText('First Last',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              const AutoSizeText('123 456 7890',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              const AutoSizeText('email',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }
}
