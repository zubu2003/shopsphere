import 'package:get/get.dart';
import 'package:shopsphere/features/shop/controllers/product/variation_controller.dart';
import 'package:shopsphere/utils/helper/network_manager.dart';

import '../features/shop/controllers/checkout/checkout_controller.dart';

class SBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());


  }


}