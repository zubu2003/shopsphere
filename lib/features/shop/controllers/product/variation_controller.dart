import 'package:get/get.dart';
import 'package:shopsphere/features/shop/controllers/product/image_controller.dart';
import 'package:shopsphere/features/shop/models/product_variation_model.dart';

import '../../models/product_model.dart';
import '../cart/cart_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;
  RxString variationStockStatus=''.obs;

  ///select attributes and variation
  void onAttributeSelected(ProductModel product,String attributeName,String attributeValue,) {
    Map<String, dynamic> selectedAttributes =
    Map<String, dynamic>.from(this.selectedAttributes);

    selectedAttributes[attributeName] = attributeValue;

    this.selectedAttributes[attributeName] = attributeValue;

    ///get selected variable
    ProductVariationModel selectedVariation= product.productVariations!.firstWhere((variation)=> isSameAttributeValues(variation.attributeValues, selectedAttributes),orElse: ()=>ProductVariationModel.empty() );

    ///show selected variation image
    if(selectedVariation.image.isNotEmpty){
      ImageController.instance.selectedProductImage.value=selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;

      cartController.productQuantityInCart.value =
          cartController.getVariationQuantityInCart(
            product.id,
            selectedVariation.id,
          );
    }


    /// Assign selected variation to Rx var
    this.selectedVariation(selectedVariation);
    getProductVariationStockStatus();


  }

  bool isSameAttributeValues(Map<String, dynamic> variationAttributes,Map<String, dynamic> selectedAttributes, ) {
    // If selectedAttributes contains 3 attributes
    // and current variation contains 2, return false
    if (variationAttributes.length != selectedAttributes.length) {
      return false;
    }

    // If any attribute value is different, return false
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) {
        return false;
      }
    }

    return true;
  }

  ///get product variation price
  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
        ? selectedVariation.value.salePrice
        : selectedVariation.value.price)
        .toStringAsFixed(0);
  }

  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    // Pass the variation to check which attributes are available and stock is not 0
    final availableAttributesValues = variations
        .where((variation) =>
    variation.attributeValues[attributeName]!.isNotEmpty &&
        variation.attributeValues[attributeName] != null &&
        variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableAttributesValues;
  }

  ///check product variation status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
    selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  //reset selected Attributes when switching products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    selectedVariation.value=ProductVariationModel.empty();
    variationStockStatus.value='';
  }

}