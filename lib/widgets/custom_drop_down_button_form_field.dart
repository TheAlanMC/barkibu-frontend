import 'package:barkibu/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  final List<String> list;
  final int? initialValue;
  final String label;
  final Function? onChanged;
  const CustomDropDownButtonFormField({
    Key? key,
    required this.list,
    required this.label,
    this.onChanged,
    this.initialValue = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
      isExpanded: true,
      value: initialValue,
      items: list
          .map((e) => DropdownMenuItem(
                value: list.indexOf(e) + initialValue!,
                child: Text(e),
              ))
          .toList(),
      onChanged: (int? value) => onChanged!(value),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 22, color: AppTheme.secondary),
      ),
    );
  }
}
