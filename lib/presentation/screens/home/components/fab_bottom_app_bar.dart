import 'package:bizzie_co/utils/constant.dart';

import 'package:flutter/material.dart';

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final ValueChanged<int> onTabSelected;

  const FABBottomAppBar(
      {Key? key, required this.items, required this.onTabSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    items.insert(items.length >> 1, _buildMiddleTabItem());

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primary,
            offset: Offset(10, 10), //(x,y)
            blurRadius: 20.0,
          ),
        ],
      ),
      child: BottomAppBar(
        // shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return const Expanded(
      child: SizedBox(),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? primary : Colors.grey;
    return Expanded(
      child: SizedBox(
        height: 65,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            highlightColor: Colors.transparent,
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: 25),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  item.text,
                  style: TextStyle(color: color, fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FABBottomAppBarItem {
  const FABBottomAppBarItem({required this.iconData, required this.text});
  final IconData iconData;
  final String text;
}
