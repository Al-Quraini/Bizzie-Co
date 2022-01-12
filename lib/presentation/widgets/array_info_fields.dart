import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArrayInfoFields extends StatelessWidget {
  final String title;
  final String hint;
  final List<String> industries;
  final bool isValidated;
  final String errorMessage;
  final Function() addCallback;
  final Function(String) removeCallback;
  const ArrayInfoFields({
    Key? key,
    required this.title,
    required this.hint,
    required this.addCallback,
    required this.removeCallback,
    required this.industries,
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        isValidated ? hint : errorMessage,
                        style: isValidated
                            ? GoogleFonts.poppins(fontSize: 11, height: 1.5)
                            : GoogleFonts.poppins(
                                fontSize: 13, height: 1.5, color: Colors.red),
                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: primary,
                        ),
                        onPressed: () async {
                          addCallback();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      shrinkWrap: true,
                      itemCount: industries.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(
                              industries[index],
                              style: const TextStyle(
                                  color: primary, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: primary,
                              ),
                              onPressed: () {
                                removeCallback(industries[index]);
                              },
                            )
                          ],
                        );
                      })
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
