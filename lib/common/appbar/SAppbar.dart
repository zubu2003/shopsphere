import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/utils/helper/device_utility.dart';

import '../../utils/constant/colors.dart';
import '../../utils/constant/size.dart';
import '../../utils/helper/helper_functions.dart';

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SAppBar(
      {super.key, this.title, this.showLeading=false, this.actions, this.leadingIcon, this.leadingPressed});

  final Widget? title;
  final bool showLeading;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final VoidCallback? leadingPressed;

  @override
  Widget build(BuildContext context) {

    final dark=SHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSize.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        //leading
        leading: showLeading ? IconButton(
            onPressed: Get.back,
            icon: Icon(
              Iconsax.arrow_left, color: dark ? SColors.white : SColors.dark,))
            : leadingIcon != null ? IconButton(
            onPressed: leadingPressed, icon: Icon(leadingIcon))
            : null,

        //title
        title: title,
        //action
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight());

}
