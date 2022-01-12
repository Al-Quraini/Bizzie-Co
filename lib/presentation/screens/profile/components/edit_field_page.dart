import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditFieldPage extends StatelessWidget {
  static const String id = '/edit_field_page';
  EditFieldPage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  const Spacer(),
                  Text('About Me',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: 12,
                style: GoogleFonts.poppins(fontSize: 12, height: 1.5),
                decoration: InputDecoration(
                    hintText: 'Write about yourself....',
                    hintStyle: GoogleFonts.poppins(fontSize: 12, height: 1.5),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width / 1.2,
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
                onPressed: () {
                  submit(context);
                },
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
        ),
      ),
    );
  }

  void submit(BuildContext context) async {
    if (_controller.text.trim().isEmpty) return;

    final result = await FirestoreService()
        .updateUser(map: {'aboutMe': _controller.text.trim()});

    if (result) Navigator.pop(context, true);
  }
}
