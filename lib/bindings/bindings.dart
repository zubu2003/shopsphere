import 'package:get/get.dart';
import 'package:shopsphere/utils/helper/network_manager.dart';

class SBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }


}