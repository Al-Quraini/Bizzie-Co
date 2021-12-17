// todo: user can't sign in unless email was verified

import 'dart:async';

import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  static const String id = '/verify_email';

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late Timer timer;

  @override
  void initState() {
    AuthenticationService().getUser()!.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  // Email icon
                  children: [
                    Container(
                      width: 169.0,
                      height: 169.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDECFFA),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.mark_email_read_outlined,
                        color: Color(0xFF30136C),
                        size: 90.0,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 53.0,
                ),
                Text("Confirm your email!",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(54.0, 0, 54.0, 0),
                  child: Text(
                    "Your account has been successfully registered. To complete the process please check your email for a validation request.",
                    style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            color: Color(0xFF838383),
                            fontWeight: FontWeight.w500)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Didn't recieve any email? ",
                            style: GoogleFonts.quicksand(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                        TextSpan(
                            text: 'resend email',
                            style: GoogleFonts.quicksand(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = resendEmail),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                // ReusableButton(
                //   title: "Resend Email",
                //   onPress: resendEmail,
                // ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    final user = AuthenticationService().getUser();
    user!.reload();
    if (user.emailVerified) {
      timer.cancel();

      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoPage.id, ModalRoute.withName(UserInfoPage.id));
    }
  }

  @override
  void dispose() {
    timer.cancel();
    if (!AuthenticationService().getUser()!.emailVerified) {
      AuthenticationService().userSignOut();
    }
    super.dispose();
  }

  void resendEmail() {
    dispose(); // dispose the current timer and initState
    initState(); // send the email again
  }
}
