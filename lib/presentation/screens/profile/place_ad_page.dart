import 'dart:io';

import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/buttons/auth_button.dart';
import 'package:bizzie_co/presentation/screens/profile/components/upload_button.dart';
import 'package:bizzie_co/presentation/screens/profile/components/visibility_page.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PlaceAddPage extends StatefulWidget {
  const PlaceAddPage({Key? key}) : super(key: key);

  @override
  State<PlaceAddPage> createState() => _PlaceAddPageState();
}

class _PlaceAddPageState extends State<PlaceAddPage> {
  File? selectedPhoto;

  final TextEditingController _subjectController = TextEditingController(),
      _descriptionController = TextEditingController();

  String visibility = 'Anyone';
  ActivityVisibility activityVisibility = ActivityVisibility.anyone;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 60,
                    child: IconButton(
                      // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Text('Sponsored Ad',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  Container(
                    width: 60,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 5),
                    child: TextButton(
                      onPressed:
                          _subjectController.text.isEmpty ? null : uploadAd,
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Text('Next',
                          style: GoogleFonts.poppins(
                              // color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              controller: _subjectController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (value) => setState(() {}),
              style: GoogleFonts.poppins(fontSize: 14, height: 1.5),
              decoration: InputDecoration(
                hintText: 'Subject',
                hintStyle: GoogleFonts.poppins(fontSize: 14, height: 1.5),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                border: InputBorder.none,
              ),
            ),
            const Divider(
              height: 10,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              style: GoogleFonts.poppins(fontSize: 12, height: 1.5),
              decoration: InputDecoration(
                hintText: 'Write your description...',
                hintStyle: GoogleFonts.poppins(fontSize: 12, height: 1.5),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            if (selectedPhoto != null)
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Image.file(
                      selectedPhoto!,
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  ],
                ),
              ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Add Location',
                          style: GoogleFonts.poppins(
                              color: primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              height: 5,
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: setVisibility,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Visible to ',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                          TextSpan(
                            text: visibility,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[500],
                  )
                ]),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            UploadButton(
              color: const Color(0x00DADADA),
              onPress: showBottomSheet,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadAd() async {
    String activityUid = const Uuid().v4();
    String? imageUrl;

    if (selectedPhoto != null) {
      imageUrl = await StorageService().uploadImage(selectedPhoto!,
          path: 'activity/${DateTime.now().millisecondsSinceEpoch}');
    }
    final Activity activity = Activity(
        likedBy: [],
        timestamp: DateTime.now(),
        description: _descriptionController.text.trim(),
        activityUser: FirestoreService.currentUser!.uid,
        activityUid: activityUid,
        userFirstName: FirestoreService.currentUser!.firstName!,
        userLastName: FirestoreService.currentUser!.lastName!,
        industry: FirestoreService.currentUser!.industry,
        isSponsored: true,
        visibility: activityVisibility,
        url: imageUrl,
        userImagePath: FirestoreService.currentUser!.imagePath);

    final success = await FirestoreService().addActivity(activity: activity);

    if (success) Navigator.pop(context);
  }

  void setVisibility() async {
    activityVisibility = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => VisibilityPage(
                  visibilityType: activityVisibility,
                )));

    setState(() {
      if (activityVisibility == ActivityVisibility.anyone) {
        visibility = 'Anyone';
      } else if (activityVisibility == ActivityVisibility.connections) {
        visibility = 'Connections';
      } else {
        visibility = 'Nearby Users';
      }
      // visibility = EnumToString.convertToString(
      //     activityVisibility);
    });
  }

  void showBottomSheet() {
    final rootNavigatorContext =
        Navigator.of(context, rootNavigator: true).context;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: rootNavigatorContext,
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
    final XFile? image = await _picker.pickImage(
        source: imageSource, maxHeight: 480, maxWidth: 640, imageQuality: 75);
    if (image == null) return;

    // log(image.path);
    setState(() {
      selectedPhoto = File(image.path);
    });

    // _cropImage(image);
  }
}
