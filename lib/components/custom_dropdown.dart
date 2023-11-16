import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.mylist,
  });

  final List<String> mylist;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String currentSelection = "";

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.mylist.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          currentSelection = value!;
        });
      },
      dropdownMenuEntries: widget.mylist.map<DropdownMenuEntry<String>>((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList(),
    );
  }
}
