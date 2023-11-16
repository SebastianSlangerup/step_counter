import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.myList,
    required this.currentSelection,
  });

  final List<String> myList;
  final String currentSelection;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String selection = "";

  void saveSelection(String selection) async {
    final prefs = await SharedPreferences.getInstance();
    if (! context.mounted) return;

    prefs.setString('selection', selection);
    setState(() {
      selection = widget.currentSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    selection = widget.currentSelection;

    return DropdownMenu<String>(
      initialSelection: selection,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        saveSelection(value ?? widget.myList.first);
      },
      dropdownMenuEntries:
        widget.myList.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
    );
  }
}
