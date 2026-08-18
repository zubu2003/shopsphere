import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController{

  static Homecontroller get instance => Get.find();

  //var
  final carouselController = CarouselSliderController();
  RxInt currentIndex=0.obs;

  void onPageChanged(int index){
    currentIndex.value=index;
  }

}