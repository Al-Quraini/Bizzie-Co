import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? actionTitle, description;
  final Function()? onPress;
  final bool done;
  final String dismissTitle;

  const CustomDialog(
      {Key? key,
      required this.title,
      this.description,
      this.actionTitle,
      this.onPress,
      this.done = false,
      this.dismissTitle = 'Cancel'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (done)
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Icon(
                  FontAwesomeIcons.solidCheckCircle,
                  color: Color(0xFF4BD37B),
                  size: 30,
                ),
              ),
            SizedBox(
              width: width / 2,
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 10,
            ),
            if (description != null)
              SizedBox(
                width: width / 1.5,
                child: Text(description!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w400)),
              ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              height: 5,
              indent: 20,
              endIndent: 20,
            ),
            if (actionTitle != null)
              SheetItemList(
                title: actionTitle!,
                color: Colors.red,
                onPress: onPress,
              ),
            if (actionTitle != null)
              const Divider(
                height: 5,
                indent: 20,
                endIndent: 20,
              ),
            SheetItemList(
              title: dismissTitle,
              onPress: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
