import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {Key? key,
      required this.controller,
      this.inputType = TextInputType.text,
      this.function,
      required this.focusNode,
      required this.hint,
      this.inputFormatter,
      this.fieldError = false})
      : super(key: key);

  final TextEditingController controller;
  final Function()? function;
  final FocusNode focusNode;
  final String hint;
  final TextInputType inputType;
  final bool fieldError;
  final MaskTextInputFormatter? inputFormatter;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width; //width of screen
    return Container(
        alignment: Alignment.center,
        width: width * .805,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width: 1,
              color: fieldError
                  ? Colors.red
                  : (focusNode.hasFocus ? primary : Colors.transparent)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
            ),
          ],
        ),
        child: TextFormField(
          inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
          keyboardType: inputType,
          controller: controller,
          cursorColor: primary,
          textAlign: TextAlign.start,
          onTap: function,
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter this field";
            }
            return null;
          },
          style: GoogleFonts.quicksand(
            color: focusNode.hasFocus ? primary : Colors.black,
            decoration: TextDecoration.none,
          ),
          focusNode: focusNode,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              border: InputBorder.none,
              hintText: hint,
              hintStyle:
                  TextStyle(color: Colors.grey[500], fontFamily: 'Quicksand')),
        ));
  }
}
