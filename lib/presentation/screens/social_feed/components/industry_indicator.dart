import 'package:bizzie_co/data/models/industry.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class IdustryIndicator extends StatefulWidget {
  const IdustryIndicator(
      {Key? key,
      required this.value,
      required this.industry,
      required this.index})
      : super(key: key);

  final double value;
  final Industry industry;
  final int index;

  @override
  State<IdustryIndicator> createState() => _IdustryIndicatorState();
}

class _IdustryIndicatorState extends State<IdustryIndicator> {
  late Color color;

  @override
  void initState() {
    super.initState();

    if (widget.index == 1) {
      color = gold;
    } else if (widget.index == 2) {
      color = silver;
    } else if (widget.index == 3) {
      color = bronze;
    } else {
      color = primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        GestureDetector(
          onTap: () => showDetailBottomSheet(context),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.industry.industryId.toUpperCase(),
              style: GoogleFonts.quicksand(
                  color: activeIndicator,
                  fontWeight: FontWeight.w900,
                  fontSize: 10),
            ),
            width: (width * (widget.value / 100)) - (width / 6),
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: industryIndicator),
          ),
        ),
      ],
    );
  }

  void showDetailBottomSheet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final rootNavigatorContext =
        Navigator.of(context, rootNavigator: true).context;

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: rootNavigatorContext,
        isScrollControlled: true,
        builder: (_) => Container(
            height: MediaQuery.of(rootNavigatorContext).size.height * 0.8,
            padding: EdgeInsets.only(
                top: 15,
                bottom: MediaQuery.of(rootNavigatorContext).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: 100,
                        color: primary,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Icon(
                              FontAwesomeIcons.tv,
                              size: width * 0.1,
                              color: Colors.white,
                            ),
                            clipBehavior: Clip.hardEdge,
                            height: width * 0.25,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF6736CE), width: 3),
                              color: activeIndicator,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.industry.industryId.toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: activeIndicator,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.055),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 10, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.medal,
                          color: color,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Ranked #${widget.index} on Bizzie Top Industries',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${widget.industry.numOfUsers} users on Bizzie Co',
                              style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // About
                  Padding(
                    padding: EdgeInsets.fromLTRB(width / 10, 10, width / 4, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('About',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(width / 10, 10, width / 10, 20),
                    child: Text(
                        widget.industry.description ??
                            'No Information Provided',
                        style: GoogleFonts.poppins(
                            fontSize: 11, fontWeight: FontWeight.normal)),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(width / 10, 20, width / 4, 20),
                    child: Text('Top Users in ${widget.industry.industryId}',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            )));
  }
}
