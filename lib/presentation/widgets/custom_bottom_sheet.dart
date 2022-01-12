import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            // height: MediaQuery.of(context).size.height * 0.3,
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 1,
                  width: 80,
                  color: primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                SheetItemList(
                  title: 'Report User',
                  color: Colors.red,
                  onPress: () {
                    Navigator.pop(context);

                    // showReportBottomSheet(context);
                  },
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                SheetItemList(
                  title: 'View Profile',
                  onPress: () async {
                    Navigator.pop(context);
                    // final card = await FirestoreService().getCardData(
                    //     userUid: user.uid, cardUid: user.primaryCard!);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) =>
                    //             ProfilePage(user: user, card: card!)));
                  },
                ),
                const Divider(
                  height: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                SheetItemList(
                  title: 'Mute',
                  onPress: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const CustomDialog(
                        title: "Mute Jessica Jones?",
                        actionTitle: 'Mute',
                        color: Color(0xFF4BD37B),
                        description:
                            'You will no longer see their posts. Bizzie won’t let them know you muted them.',
                      ),
                    );
                  },
                ),
              ],
            )),
        Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.fromLTRB(
                20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(5),
            child: SheetItemList(
              title: 'Cancel',
              onPress: () {
                Navigator.pop(context);
              },
            )),
      ],
    );
  }
}
