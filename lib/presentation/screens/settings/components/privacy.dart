import 'package:bizzie_co/presentation/screens/settings/components/setting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Privacy extends StatefulWidget {
  const Privacy({
    Key? key,
  }) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  Widget? selectedWidget;

  @override
  Widget build(BuildContext context) {
    return selectedWidget ??
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingListItem(
              title: 'Comments',
              onPress: () => setState(() {
                selectedWidget = const Comments();
              }),
            ),
            // SettingListItem(
            //   title: 'Mentions',
            //   onPress: () => setState(() {
            //     selectedWidget = const Mentions();
            //   }),
            // ),
            SettingListItem(
              title: 'Muted Accounts',
              onPress: () => setState(() {
                selectedWidget = const MutedAccounts();
              }),
            ),
          ],
        );
  }
}

/* -------------------------------------------------------------------------- */
/*                                  Comments                                  */
/* -------------------------------------------------------------------------- */
class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Comment Controls',
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
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Row(
            children: [
              Text('Controlls',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Row(
            children: [
              Text('Block Comments From',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Text('0 People',
                  style:
                      GoogleFonts.poppins(fontSize: 11, color: Colors.black54)),
              const SizedBox(
                width: 5,
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 12, color: Colors.black54)
            ],
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                  Mentions                                  */
/* -------------------------------------------------------------------------- */
class Mentions extends StatelessWidget {
  const Mentions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mentions',
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
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                               Muted Accounts                               */
/* -------------------------------------------------------------------------- */
class MutedAccounts extends StatelessWidget {
  const MutedAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Muted Accounts',
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
      ],
    );
  }
}
