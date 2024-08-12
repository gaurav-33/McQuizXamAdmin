import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcquizadmin/res/theme_data.dart';
import '../res/app_theme.dart';

class RectButton extends StatelessWidget {
  const RectButton(
      {super.key,
      required this.name,
      this.icon,
      this.ontap,
      this.height,
      this.width,
      this.iconSize});

  final String name;
  final IconData? icon;
  final VoidCallback? ontap;
  final double? height;
  final double? width;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: ontap ?? () {},
      child: Container(
        height: height ?? Get.height * 0.15,
        width: width ?? Get.width,
        decoration: BoxDecoration(
            color: theme.focusColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    size: iconSize ?? Get.width * 0.1,
                    color: theme.primaryColor,
                  )
                : const SizedBox(),
            Text(
              name,
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
