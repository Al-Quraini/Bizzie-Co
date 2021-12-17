import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  final ItemType category;
  final ValueChanged<String> addToList;
  final ValueChanged<String> removeFromList;

  const FilterChipWidget({
    Key? key,
    required this.category,
    required this.addToList,
    required this.removeFromList,
  }) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      checkmarkColor: Colors.white70,
      // showCheckmark: false,
      // avatar: Icon(widget.category.icon),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      label: Row(
        mainAxisSize: MainAxisSize.min,

        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(widget.category.icon,
              color: _isSelected ? Colors.white : Colors.grey),
          const SizedBox(
            width: 10,
          ),
          Text(widget.category.category),
        ],
      ),
      labelStyle: TextStyle(
          color: _isSelected ? Colors.white : Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.normal),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: const Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
        if (_isSelected == true) {
          widget.addToList(widget.category.category);
        } else if (_isSelected == false) {
          widget.removeFromList(widget.category.category);
        }
      },
      selectedColor: primary,
    );
  }
}

class ItemType {
  final String category;
  final IconData icon;

  const ItemType({
    required this.category,
    required this.icon,
  });
}
