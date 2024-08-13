import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Utils/toast_snack_bar.dart';
import '../widgets/query_stream_builder.dart';

typedef ItemBuilder<T> = String Function(T item);
typedef OnChangedCallback<T> = void Function(T item, String id);

class AppDropDownBtn<T> extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>> stream;
  final ItemBuilder<T> itemBuilder;
  final OnChangedCallback<T> onChanged;
  final String hintText;
  final String selectedItemId;

  AppDropDownBtn({
    super.key,
    required this.stream,
    required this.itemBuilder,
    required this.onChanged,
    required this.hintText,
    required this.selectedItemId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return QueryStreamBuilder(
      stream: stream,
      builder: (context, documents) {
        List<DropdownMenuItem<String>> items = [];
        Set<String> itemIds = {}; // Track unique IDs

        if (documents != null) {
          for (var doc in documents) {
            final T model = doc.data() as T;
            final String itemName = itemBuilder(model);
            final String itemId = doc.id; // Use document ID as the unique value

            if (!itemIds.contains(itemId)) {
              itemIds.add(itemId); // Add to the set to ensure uniqueness
              items.add(
                DropdownMenuItem<String>(
                  value: itemId,
                  child: Column(
                    children: [
                      Text(
                        itemName,
                        style: TextStyle(color: theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              AppSnackBar.error('Duplicate item ID detected: $itemId');
              if (kDebugMode) {
                print('Duplicate item ID detected: $itemId');
              }
            }
          }
        }

        // Check if selectedItemId is in the list of item IDs
        final String? currentValue =
            items.any((item) => item.value == selectedItemId)
                ? selectedItemId
                : null;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(color: theme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton<String>(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            borderRadius: BorderRadius.circular(40),
            dropdownColor: theme.secondaryHeaderColor,
            itemHeight: null,
            isExpanded: true,
            underline: const SizedBox(),
            hint: Text(
              hintText,
              style: TextStyle(color: theme.hintColor),
            ),
            value: currentValue,
            items: items,
            onChanged: (String? itemId) {
              if (itemId != null) {
                final selectedItem = documents!
                    .firstWhere((doc) => doc.id == itemId)
                    .data() as T;
                onChanged(selectedItem, itemId);
              }
            },
          ),
        );
      },
      loadingWidget: const Center(child: CircularProgressIndicator()),
      emptyWidget: Center(
          child: Text('No items available', style: theme.textTheme.bodyMedium)),
      errorWidget: Center(
          child: Text(
        'Something went wrong',
        style: theme.textTheme.bodyMedium,
      )),
    );
  }
}
