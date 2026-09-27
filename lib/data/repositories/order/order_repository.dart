import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopsphere/features/shop/models/order_model.dart';
import 'package:shopsphere/utils/constant/keys.dart';

import '../authentication_repository.dart';

class OrderRepository extends GetxController{

  static OrderRepository get instance => Get.find();

  ///Variables
  final _db=FirebaseFirestore.instance;


  ///save order to firestore
  Future<void> saveOrder(OrderModel order)async{
    try{
      await _db.collection(SKeys.userCollection).doc(order.userId).collection(SKeys.orderCollection).add(order.toJson());
    }catch(e){
      throw "Something went wrong";
    }
  }

  ///fetch user order list
  Future<List<OrderModel>> fetchUserOrders()async{
    try{
      final userId=AuthenticationRepository.instance.currentUser!.uid;

      if(userId.isEmpty)throw "Unable to find user information";

      final query=await _db.collection(SKeys.userCollection).doc(userId).collection(SKeys.orderCollection).get();

      if(query.docs.isNotEmpty){
        List<OrderModel> orders=query.docs.map((doc)=>OrderModel.fromSnapshot(doc)).toList();
        return orders;
      }else{
        return [];
      }


    }catch(e){
      throw "Something went wrong while fetching orders";
    }
  }

}