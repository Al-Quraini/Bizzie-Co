import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateInfoFields extends StatelessWidget {
  final String title;
  final String hint;
  final bool isValidated;
  final String errorMessage;

  final bool isDate;
  final DateTime? selectedDate;
  final ValueChanged onToggleCallback;
  const DateInfoFields({
    Key? key,
    required this.title,
    required this.hint,
    required this.onToggleCallback,
    this.selectedDate,
    this.isDate = true,
    required this.isValidated,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
              flex: 6,
              child: Row(
                children: [
                  Text(
                    isValidated ? hint : errorMessage,
                    style: isValidated
                        ? GoogleFonts.poppins(fontSize: 11, height: 1.5)
                        : GoogleFonts.poppins(
                            fontSize: 13, height: 1.5, color: Colors.red),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                          primary: primary),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Icon(
                          isDate
                              ? Icons.calendar_today
                              : Icons.watch_later_outlined,
                          color: Colors.white70,
                        ),
                      ),
                      onPressed: () async {
                        Object? pickedDate;
                        if (isDate) {
                          pickedDate = await pickDate(context);
                        } else {
                          pickedDate = await pickTime(context);
                        }
                        onToggleCallback(pickedDate);
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    return await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
  }
}
