import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/app_theme.dart';

class RectButton extends StatelessWidget {
  const RectButton(
      {super.key,
      required this.name,
      this.icon,
      this.ontap,
      this.height,
      this.width});

  final String name;
  final IconData? icon;
  final VoidCallback? ontap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ?? () {},
      child: Container(
        height: height ?? Get.height * 0.15,
        width: width ?? Get.width,
        decoration: const BoxDecoration(
            color: AppTheme.allports800,
            borderRadius: BorderRadius.only(
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
                    size: Get.width * 0.1,
                    color: AppTheme.allports100,
                  )
                : const SizedBox(),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
