import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';

import 'package:bizzie_co/presentation/screens/profile/card/choose_template_card.dart';
import 'package:bizzie_co/presentation/widgets/info_fields.dart';
import 'package:bizzie_co/utils/clippers/clipper_theme.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:bizzie_co/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardDetailPage extends StatefulWidget {
  static const String id = '/card_detail_page';
  const CardDetailPage(
      {Key? key, this.card, this.cardUid, this.isInitialCard = true})
      : super(key: key);

  final UserCard? card;
  final String? cardUid;
  final bool isInitialCard;

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  late CardTemplate selectedTemplate;
  // validate fields

  int selectedCard = 0;

  // final bool phoneValidated = true;

  bool emailValidated = true;

  bool addressValidated = true;
  bool companyValidated = true;

  bool positionValidated = true;

  int selectThemeIndex = -1;

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController companyController = TextEditingController();

  final TextEditingController poositionController = TextEditingController();

  final TextEditingController websiteController = TextEditingController();

  final phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();

    if (widget.card != null) {
      selectThemeIndex = myThemes.indexWhere((element) =>
          widget.card!.primary == element.primary &&
          widget.card!.secondary == element.secondary);
    }
    selectedTemplate = widget.card?.cardTemplate ?? CardTemplate.regular;
    phoneController.text = widget.card?.workPhone ?? '';
    emailController.text = widget.card?.email ?? '';
    addressController.text = widget.card?.workAddress ?? '';
    companyController.text = widget.card?.company ?? '';
    poositionController.text = widget.card?.position ?? '';
    websiteController.text = widget.card?.website ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Navigator.canPop(context)
                        ? IconButton(
                            // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Spacer(),
                  AutoSizeText('Add New Card',
                      minFontSize: 14,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const SizedBox(
                    width: 60,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // first template
            // if (cardTemplate == CardTemplate.regular)
            Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
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
                  builder: (context, constraint) {
                    if (selectedTemplate == CardTemplate.horizontalHalf) {
                      return horizontalHalf(constraint);
                    } else if (selectedTemplate == CardTemplate.verticalHalf) {
                      return verticalHalf(constraint);
                    } else {
                      return regularCard(constraint);
                    }
                  },
                ),
              ),
            ),

            TextButton(
              onPressed: () async {
                final template = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ChooseTemplateCard()));

                if (template is CardTemplate) {
                  setState(() {
                    selectedTemplate = template;
                  });
                }
              },
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(industryIndicator)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeText('Template',
                      style: GoogleFonts.poppins(
                          color: primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(Icons.arrow_forward)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Container(
              width: double.infinity,
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(vertical: 5),
              // width: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: const [
                        AutoSizeText('Select a Theme',
                            maxLines: 1,
                            minFontSize: 10,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => setState(() {
                              selectThemeIndex = index;
                            }),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectThemeIndex == index
                                      ? primary
                                      : Colors.transparent),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.topCenter,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: myThemes[index].secondary,
                                    shape: BoxShape.circle),
                                child: ClipPath(
                                  clipper: ThemeClipper(height: 35, width: 20),
                                  child: Container(
                                    height: 33,
                                    width: 50,
                                    color: myThemes[index].primary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: myThemes.length),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: Column(
                children: [
                  InfoFields(
                    errorMessage: 'Please enter your phone',
                    isValidated: true,
                    inputType: TextInputType.phone,
                    inputFormatter: phoneMaskFormatter,
                    title: 'Work Phone',
                    hint: 'Enter your phone number here',
                    controller: phoneController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider()),
                  InfoFields(
                    errorMessage: 'Please enter your email',
                    isValidated: emailValidated,
                    inputType: TextInputType.emailAddress,
                    onTap: () => setState(() {
                      emailValidated = true;
                    }),
                    title: 'Work Email',
                    hint: 'Enter your email',
                    controller: emailController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider()),
                  InfoFields(
                    errorMessage: '',
                    isValidated: true,
                    inputType: TextInputType.streetAddress,
                    title: 'Address',
                    hint: 'Enter your address',
                    onTap: () => setState(() {
                      addressValidated = true;
                    }),
                    controller: addressController,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: Column(
                children: [
                  InfoFields(
                    errorMessage: 'Please Enter Company or Institution',
                    isValidated: companyValidated,
                    inputType: TextInputType.text,
                    title: 'Company',
                    hint: 'Enter Your Company',
                    controller: companyController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider()),
                  InfoFields(
                    errorMessage: 'Please Enter You Position',
                    isValidated: positionValidated,
                    inputType: TextInputType.text,
                    title: 'Position',
                    hint: 'Enter Your Position',
                    onTap: () => setState(() {
                      positionValidated = true;
                    }),
                    controller: poositionController,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: InfoFields(
                errorMessage: '',
                isValidated: true,
                inputType: TextInputType.url,
                title: 'Home Page',
                hint: 'Enter Your Home Page Url',
                controller: websiteController,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),

            const SizedBox(
              height: 15,
            ),
            Container(
              width: 200,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5, color: Colors.grey, offset: Offset(-3, 6))
                ],
                gradient: authButtonGredient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: submit,
                child: Text('Save',
                    style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            const SizedBox(
              height: 45,
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
      color: selectThemeIndex > -1
          ? myThemes[selectThemeIndex].primary
          : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText('First Last',
              maxLines: 1,
              minFontSize: 12,
              style: TextStyle(
                  color: selectThemeIndex > -1
                      ? myThemes[selectThemeIndex].textColor
                      : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AutoSizeText('Position',
                maxLines: 1,
                minFontSize: 10,
                style: TextStyle(
                    color: selectThemeIndex > -1
                        ? myThemes[selectThemeIndex].textColor
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.15,
          ),
          AutoSizeText('123 456 7890',
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                  color: selectThemeIndex > -1
                      ? myThemes[selectThemeIndex].textColor
                      : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: constraint.maxHeight * 0.03,
          ),
          AutoSizeText('email',
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                  color: selectThemeIndex > -1
                      ? myThemes[selectThemeIndex].textColor
                      : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: constraint.maxHeight * 0.03,
          ),
          AutoSizeText('website',
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                  color: selectThemeIndex > -1
                      ? myThemes[selectThemeIndex].textColor
                      : Colors.black,
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
          color: selectThemeIndex > -1
              ? myThemes[selectThemeIndex].primary
              : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText('First Last',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].textColor
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              AutoSizeText('Position',
                  maxLines: 1,
                  minFontSize: 12,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].textColor
                          : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
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
          color: selectThemeIndex > -1
              ? myThemes[selectThemeIndex].secondary
              : Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              AutoSizeText('123 456 7890',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].secondTextColor
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
              SizedBox(
                height: constraint.maxHeight * 0.015,
              ),
              AutoSizeText('email',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].secondTextColor
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
              SizedBox(
                height: constraint.maxHeight * 0.015,
              ),
              AutoSizeText('www.google.com',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].secondTextColor
                          : Colors.white,
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
          color: selectThemeIndex > -1
              ? myThemes[selectThemeIndex].primary
              : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText('Position',
                    maxLines: 1,
                    minFontSize: 12,
                    style: TextStyle(
                        color: selectThemeIndex > -1
                            ? myThemes[selectThemeIndex].textColor
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AutoSizeText('Company',
                    maxLines: 1,
                    minFontSize: 10,
                    style: TextStyle(
                        color: selectThemeIndex > -1
                            ? myThemes[selectThemeIndex].textColor
                            : Colors.black,
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
          color: selectThemeIndex > -1
              ? myThemes[selectThemeIndex].secondary
              : Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              AutoSizeText('First Last',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].secondTextColor
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              AutoSizeText('123 456 7890',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].secondTextColor
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: constraint.maxHeight * 0.03,
              ),
              AutoSizeText('email',
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                      color: selectThemeIndex > -1
                          ? myThemes[selectThemeIndex].secondTextColor
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }

  Future submit() async {
    if (emailController.text.trim().isEmpty) {
      setState(() {
        emailValidated = false;
      });
    }

    if (addressController.text.trim().isEmpty) {
      setState(() {
        addressValidated = false;
      });
    }
    if (companyController.text.trim().isEmpty) {
      setState(() {
        companyValidated = false;
      });
    }

    if (poositionController.text.trim().isEmpty) {
      setState(() {
        positionValidated = false;
      });
    }

    if (emailController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        companyController.text.trim().isEmpty ||
        poositionController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      return;
    }

    final selectedTheme =
        selectThemeIndex > -1 ? myThemes[selectThemeIndex] : myThemes[0];

    final card = UserCard(
        firstName: FirestoreService.currentUser!.firstName!,
        lastName: FirestoreService.currentUser!.lastName!,
        cardUid: widget.cardUid ?? FirestoreService.currentUser!.primaryCard!,
        userUid: FirestoreService.currentUser!.uid,
        mobilePhone: FirestoreService.currentUser!.phone!,
        email: emailController.text.trim(),
        cardTemplate: selectedTemplate,
        company: companyController.text.trim(),
        primary: selectedTheme.primary,
        secondary: selectedTheme.secondary,
        textColor: selectedTheme.textColor,
        secondaryTextColor: selectedTheme.secondTextColor,
        website: websiteController.text.trim(),
        workAddress: addressController.text.trim(),
        workPhone: phoneController.text.trim(),
        position: poositionController.text.trim());

    await FirestoreService().addCard(card: card);
    await FirestoreService().getCardData(
        userUid: FirestoreService.currentUser!.uid, cardUid: card.cardUid);
    final List<UserCard> cards = await FirestoreService()
        .getAllCards(userUid: FirestoreService.currentUser!.uid);

    FirestoreService.setUserCards(cards);

    final tickets = await FirestoreService()
        .getTickets(userUid: FirestoreService.currentUser!.uid);
    FirestoreService.setTickets(tickets);
    if (widget.isInitialCard) {
      Navigator.pushReplacementNamed(context, SetLocation.id);
    } else {
      Navigator.pop(context, true);
    }
  }
}
