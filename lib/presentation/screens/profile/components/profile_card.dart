import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.card,
    this.isCurrentUser = false,
  }) : super(key: key);
  final UserCard card;
  final bool isCurrentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      // height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(-5, 5))
          ]),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: LayoutBuilder(
          builder: (context, constraint) => Stack(
            children: [
              // horizontalHalf(constraint),
              if (card.cardTemplate == CardTemplate.regular)
                regularCard(constraint)
              else if (card.cardTemplate == CardTemplate.verticalHalf)
                verticalHalf(constraint)
              else if (card.cardTemplate == CardTemplate.horizontalHalf)
                horizontalHalf(constraint),

              if (isCurrentUser)
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: InkWell(
                        // onTap: () =>
                        //     Navigator.pushNamed(context, AddNewCardPage.id),
                        child: Icon(
                          Icons.drive_file_rename_outline_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Container regularCard(BoxConstraints constraint) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

    String phone = maskFormatter.maskText(card.mobilePhone);
    return Container(
      height: constraint.maxHeight,
      width: constraint.maxWidth,
      color: const Color(0xFF162651),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(card.proffession,
              maxLines: 1,
              minFontSize: 12,
              style: GoogleFonts.odibeeSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AutoSizeText('Boston, MA',
                maxLines: 1,
                minFontSize: 10,
                style: GoogleFonts.odibeeSans(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.15,
          ),
          AutoSizeText('${card.firstName} ${card.lastName}',
              maxLines: 1,
              minFontSize: 8,
              style: GoogleFonts.odibeeSans(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: constraint.maxHeight * 0.03,
          ),
          AutoSizeText(phone,
              maxLines: 1,
              minFontSize: 8,
              style: GoogleFonts.odibeeSans(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: constraint.maxHeight * 0.03,
          ),
          AutoSizeText(card.email,
              maxLines: 1,
              minFontSize: 8,
              style: GoogleFonts.odibeeSans(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  // vertical half
  Column verticalHalf(BoxConstraints constraint) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

    String phone = maskFormatter.maskText(card.mobilePhone);
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
            children: [
              AutoSizeText('${card.firstName} ${card.lastName}',
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              AutoSizeText(card.proffession,
                  maxLines: 1,
                  minFontSize: 12,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 10,
              ),
              // AutoSizeText(
              //     '${user.location?.city ?? ''}, ${getStateAbriviation() ?? ''}',
              //     maxLines: 1,
              //     minFontSize: 10,
              //     style: GoogleFonts.averiaSansLibre(
              //         color: const Color(0xFF00AEEF),
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: constraint.maxWidth / 10,
              vertical: constraint.maxWidth / 20),
          width: constraint.maxWidth,
          height: constraint.maxHeight / 2,
          color: const Color(0xFF00AEEF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              AutoSizeText(phone,
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
              SizedBox(
                height: constraint.maxHeight * 0.015,
              ),
              AutoSizeText(card.email,
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
              SizedBox(
                height: constraint.maxHeight * 0.015,
              ),
              AutoSizeText('www.google.com',
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ],
    );
  }

  // horizontal half
  Row horizontalHalf(BoxConstraints constraint) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

    String phone = maskFormatter.maskText(card.mobilePhone);
    return Row(
      children: [
        Container(
          width: constraint.maxWidth / 2.2,
          height: constraint.maxHeight,
          color: const Color(0xFF262626),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText(card.proffession,
                    maxLines: 1,
                    minFontSize: 12,
                    style: GoogleFonts.averiaSansLibre(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AutoSizeText('${card.proffession}',
                    maxLines: 1,
                    minFontSize: 10,
                    style: GoogleFonts.averiaSansLibre(
                        color: Colors.white,
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
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              AutoSizeText('${card.firstName} ${card.lastName}',
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              AutoSizeText(phone,
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              AutoSizeText(card.email,
                  maxLines: 1,
                  minFontSize: 8,
                  style: GoogleFonts.averiaSansLibre(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }

  // String? getStateAbriviation() {
  //   if (user.location == null) return null;
  //   String state = user.location?.state ?? '';
  //   List<String> splitted = state.split('');
  //   String abriviation = state.substring(0, 2).toUpperCase();

  //   if (splitted.length == 2) {
  //     abriviation =
  //         '${splitted[0].substring(0, 1)}${splitted[1].substring(0, 1)}';
  //     return abriviation.toUpperCase();
  //   }

  //   return abriviation;
  // }
}
