import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopsphere/data/repositories/authentication_repository.dart';
import 'package:shopsphere/features/shop/controllers/product/variation_controller.dart';
import 'package:shopsphere/utils/constant/enums.dart';
import 'package:shopsphere/utils/constant/keys.dart';

import '../../../../utils/popups/snackbar_helpers.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';
import '../../models/product_variation_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  ///variables
  final _storage = GetStorage(
      AuthenticationRepository.instance.currentUser!.uid);
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  final variationController = VariationController.instance;


  @override
  void onInit() {
    loadCartItems();
    super.onInit();
  }

  void loadCartItems(){
    List<dynamic>? storedCartItems = _storage.read(SKeys.cartItemsKey);

    if (storedCartItems != null) {
      cartItems.assignAll(
        storedCartItems.map(
              (item) => CartItemModel.fromJson(
            item as Map<String, dynamic>,
          ),
        ),
      );
      updateCartTotals();
    }

  }

  /// Add Items in the cart
  void addToCart(ProductModel product) {
    // Check quantity of the product
    if (productQuantityInCart < 1) {
      SSnackBarHelpers.customToast(message: 'Select Quantity');
      return;
    }
    //check variation
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      SSnackBarHelpers.customToast(message: 'Select Variation');
    }

    //out of stock status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        SSnackBarHelpers.warningSnackBar(
          title: 'Out Of Stock',
          message: 'This product is out of stock',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        SSnackBarHelpers.warningSnackBar(
          title: 'Out Of Stock',
          message: 'This product is out of stock',
        );
        return;
      }
    }

    // Convert the ProductModel to CartItemModel with given quantity
    CartItemModel selectedCartItems = convertToCartItem(
        product, productQuantityInCart.value);

    //check if already exist in cart
    int index = cartItems.indexWhere((item) =>
    item.productId == selectedCartItems.productId &&
        selectedCartItems.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity = productQuantityInCart.value;
    } else {
      cartItems.add(selectedCartItems);
    }



    //update
    updateCart();
    //show snackbar
    SSnackBarHelpers.customToast(
        message: "Your product has been added to the cart");
  } //add to  cart end

  /// add one item to cart
  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  ///remove one from cart
  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity==1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();

        SSnackBarHelpers.customToast(
          message: 'Product removed from the cart',
        );

        Get.back();
      },
      onCancel: () {},
    );
  }


  /// Get Total Quantity of same specific product
  int getProductQuantityInCart(String productId) {
    final itemQuantity = cartItems
        .where((cartItem) => cartItem.productId == productId)
        .fold(
      0,
          (previousValue, cartItem) => previousValue + cartItem.quantity,
    );

    return itemQuantity;
  }


  ///get variation's quantity of the specific product
  int getVariationQuantityInCart(String productId, String variationId) {
    CartItemModel cartItemModel = cartItems.firstWhere(
          (item) =>
      item.productId == productId &&
          item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return cartItemModel.quantity;
  }


  /// Convert the ProductModel to CartItemModel with given quantity
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    // Reset variation in case of single product type
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    ProductVariationModel variation = variationController.selectedVariation
        .value;

    bool isVariation = variation.id.isNotEmpty;

    String image = isVariation ? variation.image : product.thumbnail;

    double price = isVariation
        ? (variation.salePrice > 0.0 ? variation.salePrice : variation.price)
        : (product.salePrice > 0.0 ? product.salePrice : product.price);

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      title: product.title,
      brandName: product.brand != null ? product.brand!.name : '',
      image: image,
      price: price,
      selectedVariation: isVariation ? variation.attributeValues : null,
      variationId: isVariation ? variation.id : '',
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  //save cart item to local storage
  void saveCartItems() {
    List<Map<String, dynamic>> cartItemsList = cartItems.map((item) =>
        item.toJson()).toList();

    _storage.write(SKeys.cartItemsKey, cartItemsList);
  }

  //update the total price and no of items in the cart
  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (final item in cartItems) {
      calculateTotalPrice += item.price * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculateNoOfItems;
  }

  void clearCart(){
    productQuantityInCart.value=0;
    cartItems.clear();
    updateCart();
  }

  /// Initialize already added items count in the cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      String variationId = variationController.selectedVariation.value.id;

      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }




}









