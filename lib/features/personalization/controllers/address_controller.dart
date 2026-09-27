import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopsphere/common/loaders/circular_loader.dart';
import 'package:shopsphere/utils/popups/snackbar_helpers.dart';

import '../../../common/texts/section_heading.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/helper/cloud_helper_functions.dart';
import '../../../utils/helper/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/address_model.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  /// Variables
  final _repository=Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress=AddressModel.empty().obs;


  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormkey= GlobalKey<FormState>();
  RxBool refreshData= false.obs;

  Future<void> addNewAddress()async{
    try{

      // start loading
      SFullScreenLoader.openLoadingDialog('Storing Address ... ');

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      if(!addressFormkey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }

      // Create Address Model
      AddressModel address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
        selectedAddress: true,
      );

      // If we are adding a new selected address, we must deselect the current one in the database
      if(selectedAddress.value.id.isNotEmpty){
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      /// add address to firebase
      String addressId= await _repository.addAddress(address);
      /// update id
      address.id=addressId;

      ///update selected address
      selectedAddress(address);

      ///stop loading
      SFullScreenLoader.stopLoading();

      //reset field
      resetFormFields();

      // Toggle refresh so that the FutureBuilder in AddressScreen rebuilds
      refreshData.toggle();

      ///go back
      Get.back();
      Get.back();

      /// show success snackbar
      SSnackBarHelpers.successSnackBar(title: "Congratulations",message: "Your address has been added.");
    }catch(e){
        SFullScreenLoader.stopLoading();
        SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }

  Future<List<AddressModel>> getAllAdresses()async {
    try{

      List<AddressModel> addresses=await _repository.fetchUserAddress();

      selectedAddress.value = addresses.firstWhere((address) => address.selectedAddress==true,orElse:()=> AddressModel.empty());
      return addresses;

    }catch(e){
      SFullScreenLoader.stopLoading();
      SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
      rethrow;
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();

    addressFormkey.currentState!.reset();
  }


  ///function to select address
  Future<void> selectAddress(AddressModel newSelectedAddress)async{
    try{

      //start loading
      Get.defaultDialog(
        title: "",
        onWillPop: ()async=>false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: SCircularLoader()
      );

      if(selectedAddress.value.id.isNotEmpty){
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress=true;
      selectedAddress.value=newSelectedAddress;

      //set selected address true in firebase
      await _repository.updateSelectedField(newSelectedAddress.id, true);

      //go back
      Get.back();

    }catch(e){
      Get.back();
      SSnackBarHelpers.errorSnackBar(title: "Error",message: e.toString());
    }
  }


  Future<void> selectNewAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SSize.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SSectionHeading(
                title: 'Select Address',
                actionButton: false,
              ),

              const SizedBox(
                height: SSize.spaceBtwItems,
              ),

              FutureBuilder(
                future: getAllAdresses(),
                builder: (context, snapshot) {

                  // Handle error, loading and empty states
                  final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,
                  );

                  if (widget != null) {
                    return widget;
                  }


                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,

                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      height: SSize.spaceBtwItems,
                    ),

                    itemBuilder: (context, index) {
                      final address = snapshot.data![index];

                      return SSingleAddress(
                        address: address,
                        onTap: () {
                          selectedAddress(address);
                          Get.back();
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }




}
