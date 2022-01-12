import 'package:bizzie_co/presentation/screens/settings/components/setting_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatelessWidget {
  const Help({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Report a Problem',
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
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            // controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: 15,
            style: GoogleFonts.poppins(fontSize: 12, height: 1.5),
            decoration: InputDecoration(
                hintText:
                    'Please explain what happened or what is not working.',
                hintStyle: GoogleFonts.poppins(fontSize: 12, height: 1.5),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1))),
          ),
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
            child: Text('Send',
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
