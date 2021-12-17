import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField(
      {Key? key,
      required this.controller,
      required this.function,
      required this.focusNode})
      : super(key: key);

  final TextEditingController controller;
  final Function() function;
  final FocusNode focusNode;

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
          cursorColor: primary,
          onTap: function,
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter Email Address";
            } else if (!value.contains('@')) {
              return "Please enter a valid email address!";
            }
            return null;
          },
          style: GoogleFonts.quicksand(
            color: focusNode.hasFocus ? primary : Colors.black,
            decoration: TextDecoration.none,
          ),
          focusNode: focusNode,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: focusNode.hasFocus ? primary : Colors.grey[500],
              ),
              hintText: "Email Address",
              hintStyle:
                  TextStyle(color: Colors.grey[500], fontFamily: 'Quicksand')),
        ));
  }
}
