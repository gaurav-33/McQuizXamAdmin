import 'package:flutter/material.dart';

class CustomDialogForm extends StatelessWidget {
  final TextEditingController? idController;
  final TextEditingController? nameController;
  final TextEditingController? dynamicFieldController; // Renamed controller
  final TextEditingController? statusController;
  final TextEditingController? descriptionController;
  final TextEditingController? imageUrlController;
  final String title;
  final String? dynamicHint; // Dynamic hint for the renamed controller
  final VoidCallback? onSave;
  final VoidCallback? onCancel;
  final String? idHint;
  final String? nameHint;
  final String? statusHint;
  final String? descriptionHint;
  final String? imageUrlHint;
  final bool isDismissible;

  const CustomDialogForm({
    Key? key,
    this.idController,
    this.nameController,
    this.dynamicFieldController,
    this.statusController,
    this.descriptionController,
    this.imageUrlController,
    required this.title,
    this.dynamicHint,
    this.onSave,
    this.onCancel,
    this.idHint,
    this.nameHint,
    this.statusHint,
    this.descriptionHint,
    this.imageUrlHint,
    this.isDismissible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 15),
            if (idController != null)
              _buildTextField(idController!, idHint ?? "Id (topic_1)"),
            const SizedBox(height: 10),
            if (nameController != null)
              _buildTextField(nameController!, nameHint ?? "Name"),
            const SizedBox(height: 10),
            if (dynamicFieldController != null)
              _buildTextField(
                  dynamicFieldController!, dynamicHint ?? "Dynamic Field"),
            const SizedBox(height: 10),
            if (statusController != null)
              _buildTextField(
                  statusController!, statusHint ?? "active/inactive"),
            const SizedBox(height: 10),
            if (descriptionController != null)
              _buildTextField(
                  descriptionController!, descriptionHint ?? "Description"),
            const SizedBox(height: 10),
            if (imageUrlController != null)
              _buildTextField(imageUrlController!, imageUrlHint ?? "ImageUrl"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  // textColor: theme.focusColor,
                  color: theme.primaryColor,
                  onPressed: onCancel,
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  // textColor: theme.focusColor,
                  color: theme.primaryColor,
                  onPressed: onSave,
                  child: const Text("Done"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
