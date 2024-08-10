import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mcquizadmin/Utils/tost_snackbar.dart';
import 'package:mcquizadmin/widgets/query_stream_builder.dart';

import '../res/app_theme.dart';

typedef ItemBuilder<T> = String Function(T item);
typedef OnChangedCallback<T> = void Function(T item, String id);


class AppDropDownBtn<T> extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>> stream;
  final ItemBuilder<T> itemBuilder;
  final OnChangedCallback<T> onChanged;
  final String hintText;
  final String selectedItemId;

  AppDropDownBtn({
    required this.stream,
    required this.itemBuilder,
    required this.onChanged,
    required this.hintText,
    required this.selectedItemId,
  });

  @override
  Widget build(BuildContext context) {
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
                  child: Text(itemName, overflow: TextOverflow.visible,softWrap: true,),
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
        final String? currentValue = items.any((item) => item.value == selectedItemId)
            ? selectedItemId
            : null;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.allports50,
            border: Border.all(color: AppTheme.allports900, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(40),
            dropdownColor: AppTheme.allports100,
            isExpanded: true,
            underline: const SizedBox(),
            hint: Text(
              hintText,
              style: const TextStyle(fontSize: 20),
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
      emptyWidget: const Center(child: Text('No items available', style: TextStyle(color: AppTheme.allports500),)),
      errorWidget: const Center(child: Text('Something went wrong', style: TextStyle(color: AppTheme.allports500),)),
    );
  }
}