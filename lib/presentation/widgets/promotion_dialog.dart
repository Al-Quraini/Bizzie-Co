import 'package:bizzie_co/presentation/screens/profile/card/choose_template_card.dart';
import 'package:bizzie_co/presentation/screens/profile/components/save_button.dart';
import 'package:bizzie_co/presentation/screens/profile/place_ad_page.dart';

import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class PromotionDialog extends StatefulWidget {
  const PromotionDialog({Key? key, required this.rootContext})
      : super(key: key);

  final BuildContext rootContext;

  @override
  State<PromotionDialog> createState() => _PromotionDialogState();
}

class _PromotionDialogState extends State<PromotionDialog> {
  int _currentPlan = 0;

  List<String> tailTexts = [
    'By placing this order, you agree to Bizzie’s Terms of Services and Privacy Policy. Your ApplePay Account or Debit/Credit card will be charged \$1.99.',
    'By placing this order, you agree to Bizzie’s Terms of Services and Privacy Policy. Your ApplePay Account or Debit/Credit card will be charged \$10.00 each month. You can manage your subscription and turn off auto renew from your Account settings.',
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height * 0.9),
        child: Container(
          width: width,
          // height: height * 0.85,
          // padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ]),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Promote your business with a sponsored ad!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    'Brian Adams and millions of others use premium',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                ),
                // placeAdContainer(width),
                SizedBox(
                  height: 320,
                  child: PageView(
                    children: [
                      placeAdContainer(width),
                      upgradeToPremiumContainer(width),
                    ],
                    onPageChanged: (value) => setState(() {
                      _currentPlan = value;
                    }),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 2; i++)
                        Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPlan == i
                                ? const Color.fromRGBO(0, 0, 0, 0.9)
                                : const Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        )
                    ],
                  ),
                ),

                SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                    child: Text(
                      tailTexts[_currentPlan],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  child: SaveButton(
                    onPress: placeAd,
                    title:
                        _currentPlan == 0 ? 'Place Ad' : 'Upgrade to Premium',
                    color: const Color(0xff6563FF),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container placeAdContainer(double width) {
    return Container(
      width: width * 0.85,
      // height: 400,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  'Place an ad for \$1.99',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primary),
                ),
              ),
              const Divider(
                height: 10,
                color: primary,
                thickness: 2,
              ),
              featureWidget('Displayed on connections feed for 48 hours'),
              featureWidget('Encourage new connections'),
              featureWidget('Grow your business'),
              featureWidget(
                  'Data analytics on every post to capture views, clicks, shares, and downloads'),
            ],
          ),
        ],
      ),
    );
  }

  Container upgradeToPremiumContainer(double width) {
    return Container(
      width: width * 0.85,
      // height: 400,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  'Upgrade to Premium for \$10/month',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primary),
                ),
              ),
              const Divider(
                height: 10,
                color: primary,
                thickness: 2,
              ),
              featureWidget('Unlimited ads'),
              featureWidget('Unlimited ads'),
            ],
          ),
        ],
      ),
    );
  }

  Padding featureWidget(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.check,
              color: primary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void placeAd() {
    Navigator.pop(context);
    Navigator.push(widget.rootContext,
        MaterialPageRoute(builder: (_) => const PlaceAddPage()));
  }
}
