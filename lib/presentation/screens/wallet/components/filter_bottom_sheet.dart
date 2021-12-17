import 'package:bizzie_co/presentation/screens/wallet/components/tier_container.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable/expandable.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  SortType? _sortType = SortType.newest;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Sort ',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: primary,
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text('Newest Connections (default) ',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
                      const Spacer(),
                      Radio<SortType>(
                        fillColor: MaterialStateProperty.all(primary),
                        value: SortType.newest,
                        groupValue: _sortType,
                        onChanged: (SortType? value) {
                          setState(() {
                            _sortType = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text('Oldest Connections ',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
                      const Spacer(),
                      Radio<SortType>(
                        fillColor: MaterialStateProperty.all(primary),
                        value: SortType.oldest,
                        groupValue: _sortType,
                        onChanged: (SortType? value) {
                          setState(() {
                            _sortType = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text('A-Z',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
                      const Spacer(),
                      Radio<SortType>(
                        fillColor: MaterialStateProperty.all(primary),
                        value: SortType.aToZ,
                        groupValue: _sortType,
                        onChanged: (SortType? value) {
                          setState(() {
                            _sortType = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text('Z-A',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
                      const Spacer(),
                      Radio<SortType>(
                        fillColor: MaterialStateProperty.all(primary),
                        value: SortType.zToA,
                        groupValue: _sortType,
                        onChanged: (SortType? value) {
                          setState(() {
                            _sortType = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Filter ',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: primary,
                          fontWeight: FontWeight.w500)),
                ),
                const Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Colors.grey,
                ),
                ExpandableNotifier(
                  child: Column(
                    children: [
                      ScrollOnExpand(
                        child: ExpandablePanel(
                          theme: const ExpandableThemeData(
                              tapBodyToCollapse: false, tapBodyToExpand: true),
                          header: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text('Tiers ',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                TierContainer(
                                  level: 25,
                                  title: 'Newbee',
                                ),
                                TierContainer(
                                  level: 100,
                                  title: 'Workerbee',
                                ),
                                TierContainer(
                                  level: 500,
                                  title: 'Bumblebee',
                                ),
                                TierContainer(
                                  level: 2500,
                                  title: 'Socialbee',
                                ),
                                TierContainer(
                                  level: 5000,
                                  title: 'Queenbee',
                                ),
                              ],
                            ),
                          ),
                          collapsed: const SizedBox(),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 0),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme: const ExpandableThemeData(
                                    crossFadePoint: 0),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Colors.grey,
                ),
                ExpandableNotifier(
                  child: Column(
                    children: [
                      ScrollOnExpand(
                        child: ExpandablePanel(
                          theme: const ExpandableThemeData(
                              tapBodyToCollapse: false, tapBodyToExpand: true),
                          header: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text('Industry ',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text('Information Technology',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text('Hospital and Healthcare',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text('Real Estate',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text('Design',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text('Education',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                          collapsed: const SizedBox(),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 0),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme: const ExpandableThemeData(
                                    crossFadePoint: 0),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text('Sort and Filter ',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Apply ',
                    style: GoogleFonts.poppins(fontSize: 15, color: primary))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum SortType { newest, oldest, aToZ, zToA }
