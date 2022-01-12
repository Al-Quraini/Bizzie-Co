import 'dart:developer';
import 'dart:io';

import 'package:bizzie_co/data/models/industry_user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/components/industries_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';
import 'package:bizzie_co/presentation/screens/profile/card/card_detail_page.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:image_cropper/image_cropper.dart';

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

  // focus nodes
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();

  // selected industry
  String? selectedIndustry;

  // fields error
  bool firstError = false;
  bool lastError = false;
  bool phoneError = false;
  bool industryError = false;

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
                    onPressed: showBottomSheet,
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
          GestureDetector(
            onTap: () async {
              industryError = false;
              selectedIndustry =
                  (await Navigator.pushNamed(context, IndustriesPage.id)
                          as String?) ??
                      selectedIndustry;
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: width * .805,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    width: 1,
                    color: industryError ? Colors.red : Colors.transparent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200]!,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    selectedIndustry ?? 'Industry...',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          /* ReusableTextField(
              controller: industryController,
              focusNode: industryFocusNode,
              function: () {
                setState(() {
                  FocusScope.of(context).requestFocus(industryFocusNode);
                });
              },
              hint: 'Industry'), */
          const SizedBox(
            height: 25,
          ),
          AuthButton(
            title: 'Continue',
            onPress: submitData,
          ),
          // const SizedBox(
          //   height: 40,
          // ),
          // SizedBox(
          //   width: 200,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Container(
          //         height: 12,
          //         width: 12,
          //         decoration: const BoxDecoration(
          //             color: activeIndicator, shape: BoxShape.circle),
          //       ),
          //       Container(
          //         height: 12,
          //         width: 12,
          //         decoration: const BoxDecoration(
          //             color: inactiveIndicator, shape: BoxShape.circle),
          //       ),
          //       Container(
          //         height: 12,
          //         width: 12,
          //         decoration: const BoxDecoration(
          //             color: inactiveIndicator, shape: BoxShape.circle),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }

  Future<void> submitData() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phoneNumber =
        maskFormatter.unmaskText(phoneNumberController.text.trim());

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

    if (selectedIndustry == null) {
      setState(() {
        industryError = true;
      });
    }

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phoneNumber.isEmpty ||
        selectedIndustry == null) return;

    String? imageUrl;

    if (selectedPhoto != null) {
      imageUrl = await StorageService()
          .uploadImage(selectedPhoto!, path: 'avatar.jpeg');
    }

    String cardUUid = const Uuid().v4();
    Map<String, dynamic> map = {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phoneNumber,
      'industry': selectedIndustry,
      'imagePath': imageUrl,
      'primaryCard': cardUUid,
    };

    await FirestoreService().updateUser(map: map);
    await FirestoreService()
        .loadUserData(userUid: FirestoreService.currentUser!.uid);

    final IndustryUser industryUser = IndustryUser(
        firstName: firstName,
        lastName: lastName,
        imagePath: imageUrl,
        industry: selectedIndustry ?? 'industry',
        uid: FirestoreService.currentUser!.uid);

    FirestoreService().addUserToIndustry(industryUser: industryUser);

    Navigator.pushReplacementNamed(
      context,
      CardDetailPage.id,
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
            // height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 100,
                  color: primary,
                ),
                const SizedBox(
                  height: 20,
                ),
                SheetItemList(
                  title: 'Choose From Library',
                  onPress: () {
                    Navigator.pop(context);

                    pickImage(ImageSource.gallery);
                  },
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                SheetItemList(
                  title: 'Take Photo',
                  onPress: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.camera);
                  },
                ),
              ],
            )));
  }

  void pickImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: imageSource);
    if (image == null) return;

    // log(image.path);
    // setState(() {
    //   selectedPhoto = File(image.path);
    // });

    _cropImage(image);
  }

  Future<void> _cropImage(XFile pickedFile) async {
    File? croppedFile = await ImageCropper.cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          // CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        // compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(

            // minimumAspectRatio: 1.0,
            // aspectRatioLockDimensionSwapEnabled: true,
            // aspectRatioLockEnabled: true,
            // aspectRatioPickerButtonHidden: true
            ));

    if (croppedFile != null) {
      setState(() {
        selectedPhoto = croppedFile;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
  }
}
