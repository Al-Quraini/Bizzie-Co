import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InfoFields extends StatelessWidget {
  final String title;
  final String hint;
  final bool isValidated;
  final String errorMessage;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function()? onTap;
  final MaskTextInputFormatter? inputFormatter;

  const InfoFields({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.inputType,
    this.inputFormatter,
    required this.errorMessage,
    required this.isValidated,
    this.onTap,
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
            child: TextFormField(
              inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
              controller: controller,
              // onChanged: (value) => setState(() {}),
              keyboardType: inputType,
              onTap: onTap,

              maxLines: null,
              style: GoogleFonts.poppins(fontSize: 12, height: 1.5),
              decoration: InputDecoration(
                hintText: isValidated ? hint : errorMessage,
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                isDense: true,
                hintStyle: isValidated
                    ? GoogleFonts.poppins(fontSize: 11, height: 1.5)
                    : GoogleFonts.poppins(
                        fontSize: 13, height: 1.5, color: Colors.red),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
