import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shopsphere/bottom_navigation.dart';
import 'package:shopsphere/routes/routes.dart';

import '../features/authentication/screens/forget_pass/forget_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/edit_profile/edit_profile.dart';
import '../features/personalization/screens/profile.dart';
import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/order/order.dart';
import '../features/shop/screens/store/store.dart';
import '../features/shop/screens/wishlist/wishlist.dart';

class SAppRoutes {

  static final screen= [

    GetPage(name: SRoutes.home, page: () => const BottomNavigationMenu(),),
    GetPage(name: SRoutes.store, page: () => const StoreScreen(),),
    GetPage(name: SRoutes.wishlist, page: () => const WishlistScreen(),),
    GetPage(name: SRoutes.userProfile, page: () => const ProfileScreen(),),
    GetPage(name: SRoutes.order, page: () => const OrderScreen(),),
    GetPage(name: SRoutes.checkout, page: () => const CheckoutScreen(),),
    GetPage(name: SRoutes.cart, page: () => const CartScreen(),),
    GetPage(name: SRoutes.editProfile, page: () => const EditProfileScreen(),),
    GetPage(name: SRoutes.userAddress, page: () => const AddressScreen(),),
    GetPage(name: SRoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: SRoutes.verifyEmail, page: () => const VerifyEmailScreen(),),
    GetPage(name: SRoutes.signIn, page: () => const LoginScreen(),),
    GetPage(name: SRoutes.forgetPassword, page: () => const ForgetPassword(),),
    GetPage(name: SRoutes.onBoarding, page: () => const OnboardingScreen(),),

  ];

}