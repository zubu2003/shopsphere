import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/bottom_navigation.dart';
import 'package:shopsphere/common/screen/succes_screen.dart';
import 'package:shopsphere/data/repositories/order/order_repository.dart';
import 'package:shopsphere/features/shop/controllers/cart/cart_controller.dart';
import 'package:shopsphere/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:shopsphere/utils/constant/image_string.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constant/enums.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {

  static OrderController get instance => Get.find();


  ///Variables
  final cartController=CartController.instance;
  final checkoutController=CheckoutController.instance;
  final addressController=Get.put(AddressController());

  final _repository=Get.put(OrderRepository());

  Future<void> processOrder(double totalAmount) async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog('Processing your order...',);

      // Check user existence
      final user = AuthenticationRepository.instance.currentUser;

      if (user == null) {
        SFullScreenLoader.stopLoading();
        return;
      }

      final userId = user.uid;

      if (userId.isEmpty) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Create Order Model
      final OrderModel order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.pending,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        userId: userId,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now().add(Duration(days: 3)),
      );

      //upload to firestore
      await _repository.saveOrder(order);

      //clear cart
      cartController.clearCart();

      //show success message
      Get.to(()=> SuccessScreen(
          title: "Payment Success",
          subtitle: "Your item will be delivered soon",
          image: SImages.successfulPaymentIcon,
          onTap: ()=> Get.offAll(()=> BottomNavigationMenu())
      )
      );
    } catch (e) {
      // Stop loading
      SFullScreenLoader.stopLoading();

      // Show error
      SSnackBarHelpers.errorSnackBar(
        title: 'Order failed',
        message: e.toString(),
      );
    }
  }

  //fetch user order list
  Future<List<OrderModel>> fetchUserOrders()async{
    try{
      final orders= _repository.fetchUserOrders();
      return orders;


    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
      return [];
    }
  }



}










