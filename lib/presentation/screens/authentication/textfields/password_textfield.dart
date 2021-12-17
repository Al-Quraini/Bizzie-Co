import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField(
      {Key? key,
      required this.controller,
      required this.function,
      required this.focusNode,
      required this.hint,
      required this.toggleFunction,
      required this.obsecured})
      : super(key: key);

  final TextEditingController controller;
  final Function() function;
  final Function() toggleFunction;
  final FocusNode focusNode;
  final String hint;
  final bool obsecured;

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
              color: focusNode.hasFocus ? primary : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          onTap: function,
          validator: (value) {
            if (value!.isEmpty) {
              return hint;
            } else if (value.length < 6) {
              return "Password must be at least 6 characters";
            }
            return null;
          },
          cursorColor: primary,
          style: GoogleFonts.quicksand(
            color: focusNode.hasFocus ? primary : Colors.black,
            decoration: TextDecoration.none,
          ),
          focusNode: focusNode,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: focusNode.hasFocus ? primary : Colors.grey[500],
            ),
            suffixIcon: IconButton(
              onPressed: toggleFunction,
              icon: obsecured
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontFamily: ('Quicksand'),
            ),
          ),
          obscureText: obsecured,
        ));
  }
}
