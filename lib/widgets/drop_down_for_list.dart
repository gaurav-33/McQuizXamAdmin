import 'package:flutter/material.dart';
import '../res/app_theme.dart';

class DropDownForList<T> extends StatelessWidget {
  final List<T> items;
  final String hint;
  final ValueChanged<T?> onChanged;
  final T? value;
  final String? selectedItemId;

  const DropDownForList({
    Key? key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.value,
    this.selectedItemId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Find the current value based on selectedItemId, or use null if not found
    T? currentValue;
    if (selectedItemId != null) {
      try {
        currentValue = items.firstWhere(
          (item) => item.toString() == selectedItemId,
        );
      } catch (e) {
        currentValue = null; // No matching item found
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<T>(
        borderRadius: BorderRadius.circular(40),
        dropdownColor: theme.secondaryHeaderColor,
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(
          hint,
          style: TextStyle(color: theme.hintColor),
        ),
        value: value ?? currentValue, // Use provided value or the found value
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(
              value.toString(),
              style: TextStyle(color: theme.primaryColor),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
