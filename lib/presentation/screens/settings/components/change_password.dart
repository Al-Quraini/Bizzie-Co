import 'package:bizzie_co/presentation/screens/authentication/textfields/reusable_textfield.dart';
import 'package:bizzie_co/presentation/screens/settings/components/setting_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();

  // focus nodes
  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode newPasswordConfirmFocusNode = FocusNode();

  void _requestOldPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(currentPasswordFocusNode);
    });
  }

  void _requestPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(newPasswordFocusNode);
    });
  }

  void _requestConfirmPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(newPasswordConfirmFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Change Password',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
        const Divider(
          thickness: 1,
          indent: 20,
          endIndent: 20,
          height: 25,
        ),
        const SizedBox(
          height: 35,
        ),
        ReusableTextField(
            controller: currentPasswordController,
            focusNode: currentPasswordFocusNode,
            function: _requestOldPasswordFocus,
            hint: 'Current Password'),
        const SizedBox(
          height: 20,
        ),
        ReusableTextField(
            function: _requestPasswordFocus,
            controller: newPasswordController,
            focusNode: newPasswordFocusNode,
            hint: 'New Password'),
        const SizedBox(
          height: 20,
        ),
        ReusableTextField(
            function: _requestConfirmPasswordFocus,
            controller: newPasswordConfirmController,
            focusNode: newPasswordConfirmFocusNode,
            hint: 'Confirm New Password'),
        const SizedBox(
          height: 30,
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
            onPressed: () {},
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
        )
      ],
    );
  }
}
