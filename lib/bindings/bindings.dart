import 'package:get/get.dart';
import 'package:shopsphere/features/shop/controllers/product/variation_controller.dart';
import 'package:shopsphere/utils/helper/network_manager.dart';

class SBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }


}