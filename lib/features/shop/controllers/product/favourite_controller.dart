import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/data/repositories/product/product_repository.dart';
import 'package:shopsphere/features/shop/models/product_model.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

class FavouriteController extends GetxController {
  static FavouriteController instance = Get.find();

  /// Variables
  RxMap<String, bool> favourites = <String, bool>{}.obs;
  final _storage=GetStorage(AuthenticationRepository.instance.currentUser!.uid);


  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }
  Future<void> initFavourites() async {
    String encodedFav=_storage.read('favourites');
    Map<String,dynamic> storedFavourites=jsonDecode(encodedFav) as Map<String,dynamic>;

    favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));

  }

  //funct to add or remove fav product
  void toggleFavouriteProduct(String productId) {
    if (favourites.containsKey(productId)) {
      favourites.remove(productId);
      saveFavtoStorage();
      SSnackBarHelpers.customToast(message: "Product has been removed to the Wishlist");
    } else {
      favourites[productId] = true;
      saveFavtoStorage();
      SSnackBarHelpers.customToast(message: "Product has been added to the Wishlist");
    }
  }

  void saveFavtoStorage(){
    String encodeFavourites=jsonEncode(favourites);
    _storage.write('favourites', encodeFavourites);
  }

  bool isFavourite(String productId){
    return favourites[productId] ?? false;
  }

  Future<List<ProductModel>> getFavouriteProducts()async{
    final productIds= favourites.keys.toList();
    return await ProductRepository.instance.getFavouriteProducts(productIds);
  }




}