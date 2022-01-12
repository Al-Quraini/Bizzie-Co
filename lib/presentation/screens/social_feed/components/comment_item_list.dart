import 'package:bizzie_co/data/models/comment.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentItemList extends StatelessWidget {
  const CommentItemList({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35,
            width: 35,
            clipBehavior: Clip.antiAlias,
            child: comment.userImagePath != null
                ? Image.network(
                    comment.userImage!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(placeholderPath),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              '${comment.userFirstName} ${comment.userLastName}\t\t\t',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                      TextSpan(
                        text: comment.text,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.black87,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              comment.timestamp.toTimeAgo(),
              style: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
