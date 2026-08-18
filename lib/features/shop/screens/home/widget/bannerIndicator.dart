import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controllers/banner/banner_controller.dart';
import '../../../controllers/homeController.dart';

class BannerDotNavigation extends StatelessWidget {
  const BannerDotNavigation({
    super.key,
  });
  @override
  Widget build(BuildContext context) {

    final bannerController= Get.put(BannerController());


    return  Obx(
      ()=> SmoothPageIndicator(
        count: bannerController.banners.length,
        effect: ExpandingDotsEffect(dotHeight: 6),
        controller: PageController(initialPage: bannerController.currentIndex.value),
      ),
    );
  }
}