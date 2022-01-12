import 'package:bizzie_co/presentation/screens/settings/components/setting_list_item.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SettingListItem(
          title: 'Data Policy',
        ),
        SettingListItem(
          title: 'Terms of Use',
        ),
        SettingListItem(
          title: 'Credits',
        )
      ],
    );
  }
}
