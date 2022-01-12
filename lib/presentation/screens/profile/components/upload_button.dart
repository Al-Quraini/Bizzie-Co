import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({Key? key, this.onPress, required this.color})
      : super(key: key);

  final Function()? onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; //height of screen
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: 0.8 * width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.longArrowAltUp,
              color: Colors.black87,
            ),
            const SizedBox(
              width: 15,
            ),
            Text('Upload Photo or Video',
                style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87)),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
