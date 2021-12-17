import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';

import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'buttons/auth_button.dart';
import 'components/filter_chip.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({Key? key}) : super(key: key);

  static const String id = '/interests_page';

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<String> selectedCategories = [];

  void addToCategoriesList(String category) {
    selectedCategories.add(category);
  }

  void removeFromCategoriesList(String category) {
    selectedCategories.remove(category);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            // contains back button
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Back',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'What are your interests?',
            style: GoogleFonts.poppins(fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 0.01 * height,
              runSpacing: 0.015 * height,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                for (ItemType category in categoriesList)
                  FilterChipWidget(
                    category: category,
                    addToList: addToCategoriesList,
                    removeFromList: removeFromCategoriesList,
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 0.02 * height,
          ),
          AuthButton(title: 'Continue', onPress: submitInterests),
          SizedBox(
            height: 0.05 * height,
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      color: activeIndicator, shape: BoxShape.circle),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      color: activeIndicator, shape: BoxShape.circle),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      color: activeIndicator, shape: BoxShape.circle),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Fill this out later? ',
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                  TextSpan(
                      text: 'Skip',
                      style: GoogleFonts.quicksand(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await FirestoreService().loadUserData(
                              userUid: AuthenticationService().getUser()!.uid);
                          Navigator.pushNamedAndRemoveUntil(context,
                              HomePage.id, ModalRoute.withName(HomePage.id));
                        }),
                ]),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    ));
  }

  Future<void> submitInterests() async {
    Map<String, dynamic> map = {'interests': selectedCategories};

    await FirestoreService().updateUser(map: map);

    await FirestoreService()
        .loadUserData(userUid: AuthenticationService().getUser()!.uid);
    Navigator.pushNamedAndRemoveUntil(
        context, HomePage.id, ModalRoute.withName(HomePage.id));
  }
}
