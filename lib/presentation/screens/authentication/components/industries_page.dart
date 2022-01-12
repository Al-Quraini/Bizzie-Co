import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndustriesPage extends StatelessWidget {
  static const String id = '/industries_page';
  const IndustriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
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
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const Spacer(),
                Text('Industries',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w500)),
                const Spacer(),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: industries.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, industries[index]);
                },
                child: Card(
                  //                           <-- Card widget
                  child: ListTile(
                    leading: const Icon(Icons.arrow_back_ios_outlined),
                    title: Text(industries[index]),
                  ),
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
