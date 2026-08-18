import 'package:flutter/material.dart';
import '../../utils/constant/colors.dart';
import '../../utils/helper/device_utility.dart';
import '../../utils/helper/helper_functions.dart';

class STabBar extends StatelessWidget implements PreferredSizeWidget {
  const STabBar({
    super.key, required this.tabs,
  });

  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    final dark=SHelperFunctions.isDarkMode(context);
    return Material(
      color: dark?SColors.black :SColors.white,
      child: TabBar(
        isScrollable: true,
        labelColor: dark? SColors.white : SColors.primary,
        unselectedLabelColor: SColors.darkerGrey,
        indicatorColor: SColors.primary,
        tabs: tabs,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight());
}