import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCardBox extends StatelessWidget {
  const ListCardBox(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.detail,
      required this.deleteFunc,
      required this.editFunc,
      this.onCardTap});

  final String title;
  final String subtitle;
  final String detail;
  final VoidCallback deleteFunc;
  final VoidCallback editFunc;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: Get.height * 0.15,
            width: Get.width,
            decoration: BoxDecoration(
                color: theme.highlightColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.6,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(subtitle, style: theme.textTheme.bodyMedium),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        detail,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: deleteFunc,
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: theme.buttonTheme.colorScheme?.error,
                            )),
                        InkWell(
                            onTap: editFunc,
                            child: Icon(
                              Icons.edit_rounded,
                              color: theme.primaryColor,
                            )),
                        onCardTap != null
                            ? InkWell(
                                onTap: onCardTap ?? () {},
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: theme.primaryColor,
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
