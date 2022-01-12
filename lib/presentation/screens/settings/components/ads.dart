import 'package:bizzie_co/presentation/screens/settings/components/setting_list_item.dart';
import 'package:flutter/material.dart';

class Ads extends StatelessWidget {
  const Ads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SettingListItem(
          title: 'My Ads',
        ),
        SettingListItem(
          title: 'Ad History',
        ),
        SettingListItem(
          title: 'Place Ad',
        )
      ],
    );
  }
}
