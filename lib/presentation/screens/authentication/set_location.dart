import 'package:bizzie_co/data/models/user/geo_location.dart';
import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({Key? key}) : super(key: key);

  static const String id = '/set_location';

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  Position? _currentPosition;
  String? _currentAddress;
  GeoLocation? userLocation;

  @override
  void initState() {
    super.initState();

    initializeLocation();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Back button

            SafeArea(
              // contains back button
              child: Row(
                  // children: [
                  //   IconButton(
                  //     icon: const Icon(Icons.arrow_back),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //   ),
                  //   Text(
                  //     'Back',
                  //     style: GoogleFonts.poppins(
                  //       textStyle: const TextStyle(
                  //           fontSize: 18.0, fontWeight: FontWeight.w400),
                  //     ),
                  //   ),
                  // ],
                  ),
            ),

            // page
            SizedBox(
              height: 0.08 * height,
            ),

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
                    Icons.map_outlined,
                    color: Color(0xFF30136C),
                    size: 90.0,
                  ),
                ))
              ],
            ),

            SizedBox(
              height: 0.06 * height,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(75.0, 0, 75.0, 0),
              child: AutoSizeText(
                "Set your location to find events near you",
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 0.05 * height,
            ),

            if (_currentAddress != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      FontAwesomeIcons.mapPin,
                      size: 40,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: width / 2,
                      child: AutoSizeText(
                        _currentAddress!,
                        maxLines: 3,
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: primary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )
            else
              const CircularProgressIndicator(),

            SizedBox(
              height: 0.05 * height,
            ),

            // Use your location button
            Container(
              width: 0.85 * width,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5, color: Colors.grey, offset: Offset(-3, 6))
                ],
                gradient: authButtonGredient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: submitLocation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Use your Location",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          fontFamily: ('Quicksand'),
                        )),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    minimumSize: Size(width * .7, height * .05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),

            // SizedBox(
            //   height: 0.08 * height, // 146.0
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
            //             color: activeIndicator, shape: BoxShape.circle),
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
              height: 20.0, // 44.0
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
                                userUid:
                                    AuthenticationService().getUser()!.uid);
                            Navigator.pushNamedAndRemoveUntil(context,
                                HomePage.id, ModalRoute.withName(HomePage.id));
                          }),
                  ]),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      // print(e);
    });
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      userLocation = GeoLocation(
          city: place.locality,
          state: place.administrativeArea,
          country: place.country);

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.administrativeArea}\n ${place.country}";
      });
    } catch (e) {
      // print(e);
    }
  }

  Future<void> initializeLocation() async {
    await Future.delayed(const Duration(seconds: 2));

    await _getCurrentLocation();
    setState(() {});
  }

  Future<void> submitLocation() async {
    if (userLocation == null) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Sign in error'),
                content: const Text(
                    'Please enable the location feature to be able to submit your location.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                ],
              ));
      return;
    }
    Map<String, dynamic> map = {'location': userLocation!.toMap()};
    bool isSent = await FirestoreService().updateUser(map: map);

    if (isSent) {
      await FirestoreService()
          .loadUserData(userUid: AuthenticationService().getUser()!.uid);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.id, ModalRoute.withName(HomePage.id));
    }
  }
}
