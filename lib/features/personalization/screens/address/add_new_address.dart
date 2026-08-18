import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopsphere/common/appbar/SAppbar.dart';
import 'package:shopsphere/common/styles/padding.dart';
import 'package:shopsphere/common/widgets/button/sElevatedbutton.dart';
import 'package:shopsphere/utils/constant/size.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showLeading: true,
        title: Text("Add New Address",style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child:Padding(
            padding:SPadding.screenPadding,
          child: Column(
            children: [
              //name
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: "Name"
                ),
              ),
              SizedBox(height: SSize.spaceBtwItems,),
              //phone number
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  labelText: "Phone Number"
                ),
              ),
              SizedBox(height: SSize.spaceBtwItems,),

              //street ,postal code
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: "Street"
                      ),
                    ),
                  ),
                  SizedBox(width: SSize.spaceBtwInputFields,),
                  //phone number
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: "City"
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SSize.spaceBtwItems,),

              //city state
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.buildings_2),
                          labelText: "City"
                      ),
                    ),
                  ),
                  SizedBox(width: SSize.spaceBtwInputFields,),
                  //phone number
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: "State"
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SSize.spaceBtwItems,),

              //country
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: "Country"
                ),
              ),
              SizedBox(height: SSize.spaceBtwItems,),
              
              //save button
              SElevatedButton(onPressed: (){}, child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
