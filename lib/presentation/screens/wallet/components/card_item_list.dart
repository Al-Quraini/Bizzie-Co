import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/presentation/screens/home/profile_page.dart';
import 'package:bizzie_co/presentation/widgets/custom_dialog.dart';
import 'package:bizzie_co/presentation/widgets/sheet_list_item.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItemList extends StatelessWidget {
  const CardItemList({
    Key? key,
    required this.connection,
  }) : super(key: key);

  final Connection connection;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //width of screen

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0)
          .copyWith(top: 10, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFEFF0F0),
          // border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            clipBehavior: Clip.antiAlias,
            child: connection.userImagePath != null
                ? Image.network(
                    connection.userImage!,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    placeholderPath,
                    fit: BoxFit.contain,
                  ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.fromLTRB(width / 12, 5, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${connection.userFirstName} ${connection.userLastName} ',
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(connection.industry ?? 'industry',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  Text('Chewy.com',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
          ),
          // const CardItem()
          IconButton(
            splashColor: (Colors.transparent),
            highlightColor: (Colors.transparent),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            focusColor: Colors.transparent,
            onPressed: () {
              showBottomSheet(context: context);
            },
            icon: Icon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.grey[500],
              size: 15,
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet({required BuildContext context}) {
    final rootNavigatorContext =
        Navigator.of(context, rootNavigator: true).context;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: rootNavigatorContext,
        isScrollControlled: true,
        builder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    // height: MediaQuery.of(context).size.height * 0.3,
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
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
                          title: 'Remove Connection',
                          color: Colors.red,
                          onPress: () async {
                            await FirestoreService()
                                .deleteConnection(connection: connection);
                            Navigator.pop(rootNavigatorContext);

                            // showReportBottomSheet(rootNavigatorContext);
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
                            Navigator.pop(rootNavigatorContext);

                            final user = await FirestoreService()
                                .loadUserData(userUid: connection.userUid);
                            final card = await FirestoreService().getCardData(
                                userUid: user!.uid, cardUid: user.primaryCard!);
                            final cards = await FirestoreService()
                                .getAllCards(userUid: user.uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProfilePage(
                                        user: user,
                                        card: card!,
                                        isMyProfile: false,
                                        cards: cards)));
                          },
                        ),

                        // TODO : work on muting connection
                        /*  const Divider(
                          height: 5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SheetItemList(
                          title: 'Mute',
                          onPress: () {
                            Navigator.pop(rootNavigatorContext);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const CustomDialog(
                                title: "Mute Jessica Jones?",
                                actionTitle: 'Mute',
                                color: Color(0xFF4BD37B),
                                description:
                                    'You will no longer see their posts. Bizzie won’t let them know you muted them.',
                              ),
                            );
                          },
                        ), */
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.fromLTRB(20, 0, 20,
                        MediaQuery.of(context).viewInsets.bottom + 20),
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
            ));
  }
}
