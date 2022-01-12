import 'dart:developer';

import 'package:bizzie_co/presentation/screens/authentication/login_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buttons/auth_button.dart';
import 'components/primary_container.dart';
import 'components/secondary_container.dart';

class InitialPage extends StatelessWidget {
  static const String id = '/';
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Stack(children: [
              // secondary container
              SecondaryContainer(
                containerHeight: 0.68 * height,
              ),

              // primary container
              PrimaryContainer(
                containerHeight: 0.63 * height,
                padding: 50,
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            AuthButton(
              title: 'Sign In',
              onPress: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            Container(
              width: 0.705 * width,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 15, color: Colors.grey, offset: Offset(-1, 6))
                ],
                // gradient: authButtonGredient,
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.id);
                },
                child: Text("Sign Up",
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(width * .7, height * .05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            )
          ],
        ));
  }
}
