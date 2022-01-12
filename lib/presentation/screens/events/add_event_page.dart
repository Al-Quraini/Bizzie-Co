import 'dart:developer';
import 'dart:io';
import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/components/industries_page.dart';
import 'package:bizzie_co/presentation/widgets/array_info_fields.dart';
import 'package:bizzie_co/presentation/widgets/date_info_fields.dart';
import 'package:bizzie_co/presentation/widgets/info_fields.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:bizzie_co/utils/extension.dart';
import 'package:uuid/uuid.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  File? selectedPhoto;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? formattedDate;

  // validate fields
  bool photoValidated = true;
  bool nameValidated = true;
  bool locationValidated = true;
  bool addressValidated = true;
  bool dateValidated = true;
  bool timeValidated = true;
  bool durationValidated = true;
  bool priceValidated = true;
  bool maxValidated = true;
  bool industriesValidated = true;
  bool detailsValidated = true;

  List<String> industries = [];
  final TextEditingController eventNameController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController durationController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController maxController = TextEditingController();

  final TextEditingController industriesController = TextEditingController();

  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: width,
                  height: width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFDFDF),
                    image: selectedPhoto != null
                        ? DecorationImage(
                            image: FileImage(selectedPhoto!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, width * 0.08),
                        // color: primary,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            // secondary,
                            primary,
                            Color(0x00000fff),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.9],
                        )),
                        child: SafeArea(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                                child: IconButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                              ),
                              const Spacer(),
                              Text('Create Event',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              const SizedBox(
                                width: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (selectedPhoto == null)
                        const Icon(
                          FontAwesomeIcons.image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      if (selectedPhoto == null)
                        const SizedBox(
                          height: 5,
                        ),
                      if (selectedPhoto == null)
                        Text('Create Event',
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w300)),
                      const Spacer(),
                      Container(
                        width: width,
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 25),
                        // color: primary,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            // secondary,
                            Color(0xaa6535CB),
                            Color(0x00000fff),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.0, 0.9],
                        )),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: eventNameController,
                              onTap: () => setState(() {
                                nameValidated = true;
                              }),
                              // onChanged: (value) => setState(() {}),

                              maxLines: null,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                hintText: nameValidated
                                    ? 'Event Name'
                                    : 'Enter Event Name here',
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                isDense: true,
                                hintStyle: GoogleFonts.poppins(
                                    color: nameValidated
                                        ? Colors.white
                                        : Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300),
                                border: InputBorder.none,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    // alignment: Alignment.center,
                    height: 55,
                    width: 55,
                    // height: 30,
                    // width: 30,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: orangs),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        showBottomSheet();
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            // fields
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: InfoFields(
                errorMessage: 'Please enter the name of the event',
                isValidated: locationValidated,
                onTap: () => setState(() {
                  locationValidated = true;
                }),
                inputType: TextInputType.name,
                title: 'Loocation',
                hint: 'Loocation',
                controller: locationController,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: Column(
                children: [
                  InfoFields(
                    errorMessage: 'Please enter the address ',
                    isValidated: addressValidated,
                    onTap: () => setState(() {
                      addressValidated = true;
                    }),
                    inputType: TextInputType.streetAddress,
                    title: 'Address',
                    hint: 'Enter the address',
                    controller: addressController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider()),
                  DateInfoFields(
                      errorMessage: 'Please select date ',
                      isValidated: dateValidated,
                      title: 'Date',
                      hint: formattedDate ?? 'Select a date. press the icon',
                      selectedDate: selectedDate,
                      onToggleCallback: (date) {
                        if (date is DateTime) {
                          setState(() {
                            selectedDate = date;
                            String formatDate =
                                DateFormat('MM/dd/yyyy').format(date);
                            formattedDate = formatDate;
                            dateValidated = true;
                          });
                        }
                      }),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider()),
                  DateInfoFields(
                    errorMessage: 'Please select a time ',
                    isValidated: timeValidated,
                    title: 'Time',
                    isDate: false,
                    hint: selectedTime != null
                        ? '${selectedTime?.hour.toString().padLeft(2, '0')}:${selectedTime?.minute.toString().padLeft(2, '0')}'
                        : 'Enter the time. press the icon ',
                    onToggleCallback: (time) {
                      if (time is TimeOfDay) {
                        setState(() {
                          selectedTime = time;
                          timeValidated = true;
                        });
                      }
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider()),
                  InfoFields(
                    errorMessage: 'Please enter the duration ',
                    isValidated: durationValidated,
                    onTap: () => setState(() {
                      durationValidated = true;
                    }),
                    inputType: const TextInputType.numberWithOptions(),
                    title: '# of hours',
                    hint: 'Enter the duration of the event',
                    controller: durationController,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: Column(
                children: [
                  InfoFields(
                    errorMessage: 'Please enter the price',
                    isValidated: priceValidated,
                    onTap: () => setState(() {
                      priceValidated = true;
                    }),
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    title: 'Price per Ticket\$',
                    hint: 'Enter the price ',
                    controller: priceController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider()),
                  InfoFields(
                    errorMessage: 'Please enter max RSVP',
                    isValidated: maxValidated,
                    onTap: () => setState(() {
                      maxValidated = true;
                    }),
                    inputType: const TextInputType.numberWithOptions(),
                    title: 'Max Attendees',
                    hint: 'Enter the price ',
                    controller: maxController,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: ArrayInfoFields(
                errorMessage: 'At lease add one industry',
                isValidated: industriesValidated,
                industries: industries,
                removeCallback: (value) => setState(() {
                  industries.removeWhere((industry) => industry == value);
                }),
                addCallback: () async {
                  final industry = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const IndustriesPage()));
                  industriesValidated = true;

                  if (industry != null) {
                    industries.add(industry);
                    industries = industries.toSet().toList();

                    setState(() {});
                  }
                },
                title: 'Industries',
                hint: 'Add Industry',
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              width: double.infinity,
              child: InfoFields(
                errorMessage: 'Please enter the details',
                isValidated: detailsValidated,
                onTap: () => setState(() {
                  detailsValidated = true;
                }),
                inputType: TextInputType.text,
                title: 'Details',
                hint: 'Write more details about this event',
                controller: detailsController,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: tvBackgroundColor),
            ),
            const SizedBox(
              height: 15,
            ),
            if (!photoValidated)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text('Please select a photo',
                        style: GoogleFonts.quicksand(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.red)),
                  ],
                ),
              ),

            Container(
              width: 200,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5, color: Colors.grey, offset: Offset(-3, 6))
                ],
                gradient: authButtonGredient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: submitEvent,
                child: Text('Add Event',
                    style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
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

  Future submitEvent() async {
    String? eventName = eventNameController.text,
        location = locationController.text.trim(),
        address = addressController.text.trim(),
        detail = detailsController.text.trim();

    if (selectedPhoto == null) {
      setState(() {
        photoValidated = false;
      });
    }
    if (eventName.isEmpty) {
      setState(() {
        nameValidated = false;
      });
    }
    if (location.isEmpty) {
      setState(() {
        locationValidated = false;
      });
    }
    if (address.isEmpty) {
      setState(() {
        addressValidated = false;
      });
    }
    if (detail.isEmpty) {
      setState(() {
        detailsValidated = false;
      });
    }
    if (industries.isEmpty) {
      setState(() {
        industriesValidated = false;
      });
    }

    if (maxController.text.trim().isEmpty) {
      setState(() {
        maxValidated = false;
      });
    }

    if (durationController.text.trim().isEmpty) {
      setState(() {
        durationValidated = false;
      });
    }
    if (priceController.text.trim().isEmpty) {
      setState(() {
        priceValidated = false;
      });
    }

    if (selectedDate == null) {
      setState(() {
        dateValidated = false;
      });
    }
    if (selectedTime == null) {
      setState(() {
        timeValidated = false;
      });
    }

    if (selectedPhoto == null ||
        eventName.isEmpty ||
        location.isEmpty ||
        address.isEmpty ||
        detail.isEmpty ||
        industries.isEmpty ||
        maxController.text.trim().isEmpty ||
        durationController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      return;
    }
    int? max = int.parse(maxController.text.trim()),
        duration = int.parse(durationController.text.trim());

    double? price = double.parse(priceController.text.trim());

    DateTime dateOfEvent = selectedDate!
        .copyWith(hour: selectedTime!.hour, minute: selectedTime!.minute);

    final imagePath = await StorageService().uploadImage(selectedPhoto!,
        path: 'event/${DateTime.now().millisecondsSinceEpoch}');

    final event = Event(
        id: const Uuid().v4(),
        userUid: FirestoreService.currentUser!.uid,
        venue: location,
        title: eventName,
        time: dateOfEvent,
        timestamp: DateTime.now(),
        imagePath: imagePath!,
        price: price,
        max: max,
        duration: duration,
        details: detail,
        address: address,
        userImagePath: FirestoreService.currentUser!.imagePath,
        userFirstName: FirestoreService.currentUser!.firstName!,
        userLastName: FirestoreService.currentUser!.lastName!,
        industries: industries);

    await FirestoreService().addEvent(event: event);

    Navigator.pop(context);
  }

  void pickImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: imageSource);
    if (image == null) return;

    // log(image.path);
    setState(() {
      selectedPhoto = File(image.path);
      photoValidated = true;
    });
  }
}
