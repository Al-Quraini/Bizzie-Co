import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/google_sign_in_provider.dart';
import 'package:bizzie_co/presentation/screens/authentication/login_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';
import 'package:bizzie_co/presentation/screens/authentication/verify_email.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';
import 'dart:io' show Platform;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';
import 'buttons/apple_button.dart';
import 'buttons/auth_button.dart';
import 'buttons/google_button.dart';

import 'components/primary_container.dart';
import 'components/secondary_container.dart';
import 'textfields/email_textfield.dart';
import 'textfields/password_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String id = '/signup_page';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  //look at late later
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //Focus nodes for person tab fields
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  FocusNode emailFocusNode = FocusNode(); //focusNode for email
  FocusNode passwordFocusNode = FocusNode(); //focusNode for password
  FocusNode confirmPasswordFocusNode = FocusNode();

  late auth.User currentUser;

  @override
  void initState() {
    super.initState();

    //init
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    _obscureText1 = true;
    _obscureText1 = true;
  }

  void _requestPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  void _requestConfirmPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
    });
  }

  void _requestEmailFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }

  void _toggleVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggleVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
        SecondaryContainer(height: height, width: width),
        PrimaryContainer(height: height, width: width),
        Column(
          children: [
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
            SizedBox(
              //space between Bizzie co and welcome text
              height: height * .1,
            ),
            Text(
              "Create Account",
              style: GoogleFonts.quicksand(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: height * .03,
            ),
            EmailTextField(
              controller: emailController,
              focusNode: emailFocusNode,
              function: _requestEmailFocus,
            ),
            const SizedBox(
              height: 12,
            ),
            PasswordTextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              function: _requestPasswordFocus,
              hint: "Password",
              obsecured: _obscureText1,
              toggleFunction: _toggleVisibility1,
            ),
            const SizedBox(
              height: 12,
            ),
            PasswordTextField(
              controller: confirmPasswordController,
              focusNode: confirmPasswordFocusNode,
              function: _requestConfirmPasswordFocus,
              hint: "Confirm Password",
              obsecured: _obscureText2,
              toggleFunction: _toggleVisibility2,
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
            AuthButton(title: 'Sign Up', onPress: signUpUser),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: height * .001,
                    width: width * .25,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  "or sign up with",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                      height: height * .002,
                      width: width * .25,
                      color: Colors.grey),
                ),
              ],
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
                        text: 'Already have an account? ',
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                    TextSpan(
                        text: 'Sign in here',
                        style: GoogleFonts.quicksand(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, LoginPage.id);
                          }),
                  ]),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ]),
    ));
  }

  void signUpUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String? error;
    if (password != confirmPassword) {
      error = 'The passwords are different';
    } else {
      error = await AuthenticationService()
          .signUp(email: email, password: password);
    }
    if (error == null) {
      currentUser = AuthenticationService().getUser()!;
      User user = User(email: email, uid: currentUser.uid, numOfConnections: 0);

      await FirestoreService().addUser(user: user);

      await FirestoreService()
          .loadUserData(userUid: AuthenticationService().getUser()!.uid);

      await FirestoreService().getConnections();

      Navigator.pushNamed(context, VerifyEmail.id);
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Sign in error'),
                content: Text(error!),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                ],
              ));
    }
  }

  Future<void> signInWithGoogle() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final result = await provider.googleLogin();

    if (result != null) {
      if (result) {
        Navigator.pushNamedAndRemoveUntil(
            context, SetLocation.id, ModalRoute.withName(SetLocation.id));
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.id, ModalRoute.withName(HomePage.id));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    confirmPasswordFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
}
