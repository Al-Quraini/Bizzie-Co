import 'dart:io';

import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'buttons/auth_button.dart';
import 'textfields/reusable_textfield.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  static const String id = '/user_info_page';

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  // controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  // focus nodes
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode occupationFocusNode = FocusNode();

  // fields error
  bool firstError = false;
  bool lastError = false;
  bool phoneError = false;

  // formatter
  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});
  // user photo
  File? selectedPhoto;

  @override
  void initState() {
    super.initState();
    final user = FirestoreService.currentUser!;

    if (user.firstName != null) firstNameController.text = user.firstName!;
    if (user.lastName != null) lastNameController.text = user.lastName!;
    if (user.phone != null) phoneNumberController.text = user.phone!;
    if (user.occupation != null) occupationController.text = user.occupation!;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SafeArea(
              // contains back button
              child: SizedBox(
            width: double.infinity,
            height: 30,
          )),
          Stack(
            children: [
              Container(
                  clipBehavior: Clip.antiAlias,
                  height: 0.35 * width,
                  width: 0.35 * width,
                  child: selectedPhoto == null
                      ? Icon(
                          Icons.camera_alt_outlined,
                          size: width * 0.15,
                        )
                      : Image.file(
                          selectedPhoto!,
                          fit: BoxFit.cover,
                        ),
                  decoration: const BoxDecoration(
                    color: Color(0XFFEAEAEA),
                    shape: BoxShape.circle,
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    minWidth: 0,
                    height: 0,
                    padding: EdgeInsets.zero,
                    onPressed: pickImage,
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: primary, shape: BoxShape.circle),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        )),
                  ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Fill your profile and upload your photo',
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          ReusableTextField(
              fieldError: firstError,
              controller: firstNameController,
              focusNode: firstNameFocusNode,
              function: () {
                setState(() {
                  FocusScope.of(context).requestFocus(firstNameFocusNode);
                  setState(() {
                    firstError = false;
                  });
                });
              },
              hint: 'First Name'),
          if (firstError)
            Text(
              'Please Enter Your First Name!',
              style: GoogleFonts.poppins(fontSize: 8, color: Colors.red),
            ),
          const SizedBox(
            height: 10,
          ),
          ReusableTextField(
              fieldError: lastError,
              controller: lastNameController,
              focusNode: lastNameFocusNode,
              function: () {
                setState(() {
                  FocusScope.of(context).requestFocus(lastNameFocusNode);
                  setState(() {
                    lastError = false;
                  });
                });
              },
              hint: 'Last Name'),
          if (lastError)
            Text(
              'Please Enter Your Last Name!',
              style: GoogleFonts.poppins(fontSize: 8, color: Colors.red),
            ),
          const SizedBox(
            height: 10,
          ),
          ReusableTextField(
              inputFormatter: maskFormatter,
              fieldError: phoneError,
              inputType: TextInputType.phone,
              controller: phoneNumberController,
              focusNode: phoneNumberFocusNode,
              function: () {
                setState(() {
                  FocusScope.of(context).requestFocus(phoneNumberFocusNode);
                  setState(() {
                    phoneError = false;
                  });
                });
              },
              hint: 'Phone Number'),
          if (phoneError)
            Text(
              'Please Enter Your Phone Number!',
              style: GoogleFonts.poppins(fontSize: 8, color: Colors.red),
            ),
          const SizedBox(
            height: 10,
          ),
          ReusableTextField(
              controller: occupationController,
              focusNode: occupationFocusNode,
              function: () {
                setState(() {
                  FocusScope.of(context).requestFocus(occupationFocusNode);
                });
              },
              hint: 'Occupation'),
          const SizedBox(
            height: 25,
          ),
          AuthButton(
            title: 'Continue',
            onPress: submitData,
          ),
          const SizedBox(
            height: 40,
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
                      color: inactiveIndicator, shape: BoxShape.circle),
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      color: inactiveIndicator, shape: BoxShape.circle),
                ),
              ],
            ),
          ),
          /* const SizedBox(
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
                        ..onTap = () {
                          Navigator.pushNamed(context, SetLocation.id);
                        }),
                ]),
          ), */
          const SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }

  void pickImage() async {
    ImageSource? imageSource;
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  imageSource = ImageSource.gallery;
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.filter_frames_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Gallery',
                      style: GoogleFonts.quicksand(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              SimpleDialogOption(
                onPressed: () {
                  imageSource = ImageSource.camera;

                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Camera',
                      style: GoogleFonts.quicksand(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
    if (imageSource == null) return;

    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: imageSource!);
    setState(() {
      selectedPhoto = File(image!.path);
    });
  }

  Future<void> submitData() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phoneNumber =
        maskFormatter.unmaskText(phoneNumberController.text.trim());
    String occupation = occupationController.text.trim();

    if (firstName.isEmpty) {
      setState(() {
        firstError = true;
      });
    }

    if (lastName.isEmpty) {
      setState(() {
        lastError = true;
      });
    }

    if (phoneNumber.isEmpty) {
      setState(() {
        phoneError = true;
      });
    }

    if (firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty) return;

    String? imageUrl;

    if (selectedPhoto != null) {
      imageUrl = await StorageService().uploadImage(selectedPhoto!);
    }

    String cardUUid = const Uuid().v4();
    Map<String, dynamic> map = {
      'firstName': firstName.isNotEmpty ? firstName : null,
      'lastName': lastName.isNotEmpty ? lastName : null,
      'phone': phoneNumber.isNotEmpty ? phoneNumber : null,
      'occupation': occupation.isNotEmpty ? occupation : null,
      'imageUrl': imageUrl,
      'primaryCard': cardUUid,
    };

    await FirestoreService().updateUser(map: map);
    final card = UserCard(
        firstName: firstName,
        lastName: lastName,
        cardUid: cardUUid,
        userUid: FirestoreService.currentUser!.uid,
        mobilePhone: phoneNumber,
        email: FirestoreService.currentUser!.email,
        cardTemplate: CardTemplate.regular,
        proffession: occupation);

    await FirestoreService().addCard(card: card);
    await FirestoreService().getCardData(
        userUid: FirestoreService.currentUser!.uid, cardUid: cardUUid);

    Navigator.pushNamed(context, SetLocation.id);
  }

  @override
  void dispose() {
    super.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    occupationController.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    occupationFocusNode.dispose();
  }
}
