import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VisibilityPage extends StatefulWidget {
  const VisibilityPage({Key? key, required this.visibilityType})
      : super(key: key);

  final ActivityVisibility visibilityType;

  @override
  State<VisibilityPage> createState() => _VisibilityPageState();
}

class _VisibilityPageState extends State<VisibilityPage> {
  ActivityVisibility? _visibilityType;

  @override
  void initState() {
    super.initState();

    _visibilityType = widget.visibilityType;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 60,
                child: IconButton(
                  // padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop(_visibilityType);
                  },
                ),
              ),
              Text('Visibility',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 60,
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height / 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Radio<ActivityVisibility>(
                  fillColor: MaterialStateProperty.all(primary),
                  value: ActivityVisibility.anyone,
                  groupValue: _visibilityType,
                  onChanged: (ActivityVisibility? value) {
                    setState(() {
                      _visibilityType = value!;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('Anyone',
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        const Divider(
          indent: 15,
          endIndent: 15,
          color: Colors.grey,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Radio<ActivityVisibility>(
                  fillColor: MaterialStateProperty.all(primary),
                  value: ActivityVisibility.connections,
                  groupValue: _visibilityType,
                  onChanged: (ActivityVisibility? value) {
                    setState(() {
                      _visibilityType = value!;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('Connections',
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              // const Spacer(),
            ],
          ),
        ),
        const Divider(
          indent: 15,
          endIndent: 15,
          color: Colors.grey,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Radio<ActivityVisibility>(
                  fillColor: MaterialStateProperty.all(primary),
                  value: ActivityVisibility.nearbyUsers,
                  groupValue: _visibilityType,
                  onChanged: (ActivityVisibility? value) {
                    setState(() {
                      _visibilityType = value!;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Text('Nearby Users',
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              // const Spacer(),
            ],
          ),
        ),
      ],
    ));
  }
}
