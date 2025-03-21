import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../Utils/toast_snack_bar.dart';

Future<FilePickerResult?> pickCsvFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.isNotEmpty) {
      return result;
    } else {
      // User canceled the picker
      return null;
    }
  } catch (e) {
    // Handle any errors here
    AppSnackBar.error("File: ${e.toString()}");
    if (kDebugMode) {
      print('Error while picking the file: $e');
    }
    return null;
  }
}

Future<List<List<dynamic>>> readCsvFile(String filePath) async {
  try {
    final file = File(filePath);
    final mData = await file.readAsString();
    return const CsvToListConverter().convert(mData);
  } catch (e) {
    AppSnackBar.error("File Reading: ${e.toString()}");
    if (kDebugMode) {
      print('Error reading CSV file: $e');
    }

    return [];
  }
}

// import 'dart:io';
// import 'package:csv/csv.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../Utils/toast_snack_bar.dart';
//
// Future<FilePickerResult?> pickCsvFile() async {
//   try {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['csv'],
//     );
//
//     if (result != null && result.files.isNotEmpty) {
//       return result;
//     } else {
//       // User canceled the picker
//       return null;
//     }
//   } catch (e) {
//     // Handle any errors here
//     AppSnackBar.error("File: ${e.toString()}");
//     if (kDebugMode) {
//       print('Error while picking the file: $e');
//     }
//     return null;
//   }
// }
//
// Future<List<List<dynamic>>> readCsvFile(String filePath) async {
//   try {
//     // Check for necessary permissions
//     if (await _requestStoragePermission()) {
//       final file = File(filePath);
//       final mData = await file.readAsString();
//       return const CsvToListConverter().convert(mData);
//     } else {
//       AppSnackBar.error("Storage permission not granted.");
//       return [];
//     }
//   } catch (e) {
//     AppSnackBar.error("File Reading: ${e.toString()}");
//     if (kDebugMode) {
//       print('Error reading CSV file: $e');
//     }
//
//     return [];
//   }
// }
//
// Future<bool> _requestStoragePermission() async {
//   if (await Permission.storage.request().isGranted) {
//     return true;
//   } else {
//     // Permission denied
//     return false;
//   }
// }
