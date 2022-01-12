import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/google_sign_in_provider.dart';

import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';
import 'package:bizzie_co/presentation/screens/authentication/signup_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/user_info.dart';
import 'package:bizzie_co/presentation/screens/authentication/verify_email.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';
import 'package:bizzie_co/presentation/screens/profile/card/card_detail_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'buttons/apple_button.dart';
import 'buttons/auth_button.dart';
import 'buttons/google_button.dart';

import 'components/primary_container.dart';
import 'components/secondary_container.dart';
import 'textfields/email_textfield.dart';
import 'textfields/password_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String id = '/login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  //look at late later
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Focus nodes for person tab fields
  bool _obscureText = true;
  FocusNode emailFocusNode = FocusNode(); //focusNode for email
  FocusNode passwordFocusNode = FocusNode(); //focusNode for password

  late auth.User currentUser;

  void _requestPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  void _requestEmailFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }

  @override
  void initState() {
    super.initState();

    //init
    _obscureText = true;
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SecondaryContainer(containerHeight: 0.71 * width),
              PrimaryContainer(
                containerHeight: 0.68 * width,
              ),
              SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 0.1 * height,
                        left: 10.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      iconSize: 30,
                    ),
                    SizedBox(
                      //space between top of screen and bizzie logo
                      width: width * .125,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            //space between Bizzie co and welcome text
            height: 10,
          ),
          Text(
            "Welcome Back!",
            style: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: height * .04,
          ),
          EmailTextField(
            controller: emailController,
            focusNode: emailFocusNode,
            function: _requestEmailFocus,
          ),
          const SizedBox(
            height: 15,
          ),
          PasswordTextField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            function: _requestPasswordFocus,
            hint: "Password",
            obsecured: _obscureText,
            toggleFunction: _toggleVisibility,
          ),
          SizedBox(
            height: height * .017,
          ),
          Row(
            children: [
              SizedBox(width: width * .59),
              const Text(
                "forgot password?",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.right,
              )
            ],
          ),
          SizedBox(
            height: height * .035,
          ),
          AuthButton(
            title: 'Sign In',
            onPress: signInUser,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                      height: 0.8, width: width * .35, color: Colors.grey),
                ),
                const Text(
                  "or",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                      height: 0.8, width: width * .35, color: Colors.grey),
                ),
              ],
            ),
          ),
          GoogleButton(
            onPress: signInWithGoogle,
          ),

          // const LinkedinButton(),
          if (Platform.isIOS) const AppleButton(),
          SizedBox(height: height * 0.02),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Don\'t have an account? ',
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                  TextSpan(
                      text: 'Sign up here',
                      style: GoogleFonts.quicksand(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                              context, SignUpPage.id);
                        }),
                ]),
          ),
          SizedBox(height: height * 0.05),
        ],
      ),
    ));
  }

  void signInUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    // User user = User(email: email, uid: currentUser.uid);

    final error =
        await AuthenticationService().signIn(email: email, password: password);

    if (error == null) {
      currentUser = AuthenticationService().getUser()!;
      if (currentUser.emailVerified) {
        String initialRout = HomePage.id;
        final user = FirestoreService.currentUser!;

        if (user.firstName == null ||
            user.lastName == null ||
            user.phone == null) {
          initialRout = UserInfoPage.id;
        } else {
          final UserCard? card = await FirestoreService()
              .getCardData(userUid: user.uid, cardUid: user.primaryCard!);

          if (card == null) {
            initialRout = CardDetailPage.id;
          } else {
            final cards = await FirestoreService()
                .getAllCards(userUid: FirestoreService.currentUser!.uid);

            final tickets = await FirestoreService()
                .getTickets(userUid: FirestoreService.currentUser!.uid);
            FirestoreService.setTickets(tickets);
            FirestoreService.setUserCards(cards);
            initialRout = HomePage.id;
          }
          initialRout = HomePage.id;
        }
        Navigator.pushNamedAndRemoveUntil(
            context, initialRout, ModalRoute.withName(initialRout));
      } else {
        Navigator.pushNamed(context, VerifyEmail.id);
      }
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Sign in error'),
                content: Text(error),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                ],
              ));
    }
  }

  // sign in with google method
  Future<void> signInWithGoogle() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    // if user returns false, the user signed up before
    // otherwise, it is the first time
    final result = await provider.googleLogin();

    // user successfully login or register
    if (result != null) {
      if (result) {
        Navigator.pushNamedAndRemoveUntil(
            context, UserInfoPage.id, ModalRoute.withName(UserInfoPage.id));
      } else {
        String initialRout = HomePage.id;

        // get current user data
        final user = FirestoreService.currentUser!;

        // if the user didn't enter their name before,
        // they will be directed to user infor page
        if (user.firstName == null ||
            user.lastName == null ||
            user.phone == null) {
          initialRout = UserInfoPage.id;
        } else {
          await FirestoreService()
              .getCardData(userUid: user.uid, cardUid: user.primaryCard!);

          initialRout = HomePage.id;
        }
        Navigator.pushNamedAndRemoveUntil(
            context, initialRout, ModalRoute.withName(initialRout));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
}
