import 'package:bizzie_co/data/models/user/experience.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/authentication/textfields/reusable_textfield.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditExperience extends StatefulWidget {
  const EditExperience({Key? key}) : super(key: key);

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  // controllers
  final TextEditingController _schoolController = TextEditingController();

  final TextEditingController _professionController = TextEditingController();

  final TextEditingController _fieldController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

  // focus Nodes
  final FocusNode _schoolFocusNode = FocusNode();

  final FocusNode _professionFocusNode = FocusNode();

  final FocusNode _fieldFocusNode = FocusNode();

  final FocusNode _descriptionFocusNode = FocusNode();

  void _requestSchoolFocusNodeFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_schoolFocusNode);
    });
  }

  void _requestDegreeFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_professionFocusNode);
    });
  }

  void _requestFieldFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_fieldFocusNode);
    });
  }

  void _requestDescriptionFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_descriptionFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  const Spacer(),
                  Text('Experience',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ReusableTextField(
                controller: _schoolController,
                focusNode: _schoolFocusNode,
                hint: 'Institution.. e.i Microsoft'),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
                controller: _professionController,
                focusNode: _professionFocusNode,
                hint: 'Profession.. e.i Realtor'),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
                focusNode: _fieldFocusNode,
                controller: _fieldController,
                hint: 'field.. e.i Advertising'),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                final pickedDate = await pickDate(context, true);
                setState(() {
                  if (pickedDate != null) {
                    pickedStartDate = pickedDate;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                width: width * .805,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1, color: Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200]!,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pickedStartDate?.year.toString() ?? 'Pick start date...',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                    const Icon(Icons.calendar_today_rounded)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                final pickedDate = await pickDate(context, false);
                setState(() {
                  if (pickedDate != null) {
                    pickedEndDate = pickedDate;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                alignment: Alignment.center,
                width: width * .805,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1, color: Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200]!,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pickedEndDate?.year.toString() ?? 'Pick end date...',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                    const Icon(Icons.calendar_today_rounded)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ReusableTextField(
                maxLines: 8,
                focusNode: _descriptionFocusNode,
                controller: _descriptionController,
                hint: 'Write about your experience...'),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
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
                onPressed: () {
                  submit(context);
                },
                child: Text('Save',
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

  void submit(BuildContext context) async {
    final Experience experience = Experience(
        institution: _schoolController.text.trim(),
        profession: _professionController.text.trim(),
        field: _fieldController.text.trim(),
        description: _descriptionController.text,
        startDate: pickedStartDate,
        endDate: pickedEndDate);

    final Map<String, dynamic> map = {'experience': experience.toMap()};

    final success = await FirestoreService().updateUser(map: map);

    if (success) Navigator.pop(context, true);
  }

  Future<DateTime?> pickDate(BuildContext context, bool isInitial) async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: isInitial
          ? DateTime(DateTime.now().year - 30)
          : pickedStartDate ?? DateTime(DateTime.now().year - 30),
      lastDate: DateTime.now(),
    );
  }
}
