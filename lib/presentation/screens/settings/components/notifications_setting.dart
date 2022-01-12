import 'package:bizzie_co/presentation/screens/settings/components/setting_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  Widget? selectedWidget;
  bool isPausedAll = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen

    return selectedWidget ??
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(width / 8, 0, width / 12, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pause All',
                        style: GoogleFonts.poppins(
                            fontSize: 17, fontWeight: FontWeight.w300)),
                    CupertinoSwitch(
                        activeColor: primary,
                        value: isPausedAll,
                        onChanged: (value) {
                          setState(() {
                            isPausedAll = value;
                          });
                        })
                  ],
                )),
            SettingListItem(
              title: 'Post and Comments',
              onPress: () => setState(() {
                selectedWidget = const PostsAndComments();
              }),
            ),
            SettingListItem(
              title: 'Connections',
              onPress: () => setState(() {
                selectedWidget = const Connections();
              }),
            ),
          ],
        );
  }
}

class PostsAndComments extends StatefulWidget {
  const PostsAndComments({
    Key? key,
  }) : super(key: key);

  @override
  State<PostsAndComments> createState() => _PostsAndCommentsState();
}

class _PostsAndCommentsState extends State<PostsAndComments> {
  int pausePostNotification = 0;
  int pauseLikesNotification = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Posts, Likes, and Comments',
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text('Posts',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('Off',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<int>(
                fillColor: MaterialStateProperty.all(primary),
                value: 0,
                groupValue: pausePostNotification,
                onChanged: (value) {
                  setState(() {
                    pausePostNotification = value!;
                  });
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('From People I follow',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<int>(
                fillColor: MaterialStateProperty.all(primary),
                value: 1,
                groupValue: pausePostNotification,
                onChanged: (value) {
                  setState(() {
                    pausePostNotification = value!;
                  });
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('From Everyone',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<int>(
                fillColor: MaterialStateProperty.all(primary),
                value: 2,
                groupValue: pausePostNotification,
                onChanged: (value) {
                  setState(() {
                    pausePostNotification = value!;
                  });
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text('Likes',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('Off',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<int>(
                fillColor: MaterialStateProperty.all(primary),
                value: 0,
                groupValue: pauseLikesNotification,
                onChanged: (value) {
                  setState(() {
                    pauseLikesNotification = value!;
                  });
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('From People I follow',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<int>(
                fillColor: MaterialStateProperty.all(primary),
                value: 1,
                groupValue: pauseLikesNotification,
                onChanged: (value) {
                  setState(() {
                    pauseLikesNotification = value!;
                  });
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('From Everyone',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<int>(
                fillColor: MaterialStateProperty.all(primary),
                value: 2,
                groupValue: pauseLikesNotification,
                onChanged: (value) {
                  setState(() {
                    pauseLikesNotification = value!;
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Connections extends StatefulWidget {
  const Connections({
    Key? key,
  }) : super(key: key);

  @override
  State<Connections> createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connections',
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text('Connection Request',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('Off',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<bool>(
                fillColor: MaterialStateProperty.all(primary),
                value: false,
                groupValue: isOn,
                onChanged: (value) {
                  setState(() {
                    isOn = value!;
                  });
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Text('On',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  )),
              const Spacer(),
              Radio<bool>(
                fillColor: MaterialStateProperty.all(primary),
                value: true,
                groupValue: isOn,
                onChanged: (value) {
                  setState(() {
                    isOn = value!;
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
