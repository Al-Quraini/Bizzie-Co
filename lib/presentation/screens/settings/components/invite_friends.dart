import 'package:bizzie_co/presentation/screens/settings/components/setting_list_item.dart';
import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SettingListItem(
          title: 'Invite Friends By SMS',
        ),
        SettingListItem(
          title: 'Invite Friends By...',
        ),
      ],
    );
  }
}
