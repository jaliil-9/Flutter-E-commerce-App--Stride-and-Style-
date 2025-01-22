import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/features/personalization/models/address_model.dart';
import 'package:stride_style_ecom/features/personalization/screens/addresses%20widgets/address_card.dart';
import 'package:stride_style_ecom/features/personalization/screens/adresses.dart';
import 'package:stride_style_ecom/features/shop/screens/shop%20widgets/common/section_heading.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/helpers/loaders.dart';
import 'package:stride_style_ecom/utils/helpers/network_manager.dart';

import '../../../data/repositories/addresses/address_repository.dart';
import '../../../utils/constants/style.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final addressRepo = Get.put(AddressRepository());
  final selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = true.obs;

  // Fetch all user addresses
  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepo.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());

      return addresses;
    } catch (e) {
      JBLoaders.errorSnackBar(
          title: 'Address not found!', message: e.toString());
      return [];
    }
  }

  // Update selected address field
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedField(selectedAddress.value.id, false);
      }

      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the selected field to true for the new selected address
      await addressRepo.updateSelectedField(selectedAddress.value.id, true);
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Error!', message: e.toString());
    }
  }

  // save user new address
  Future addNewAddress() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);
      final id = await addressRepo.addAddress(address);

      // Update selected address field
      address.id = id;
      await selectAddress(address);

      // Show success message
      JBLoaders.successSnackBar(
          title: 'Done!', message: 'Address saved succesfully');

      refreshData.toggle();
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: JBSizes.spaceBtwItems,
                  ),
                  const JBSectionHeading(
                    headingText: 'Select Shipping Address',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: JBSizes.spaceBtwSections,
                  ),
                  FutureBuilder(
                      future: allUserAddresses(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: JBStyles.burnishedGold));
                        }
                        if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text('No Address available!',
                                style: JBStyles.priceLight),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something went wrong!',
                                style: JBStyles.priceLight),
                          );
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => JBAddressCard(
                                  address: snapshot.data![index],
                                  onTap: () async {
                                    await selectAddress(snapshot.data![index]);
                                    Get.back();
                                  },
                                ));
                      }),
                  const SizedBox(height: JBSizes.defaultSpace * 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const AddNewAddress()),
                      style: JBStyles.primaryButtonStyle(context),
                      child: Text(
                        "Add new address",
                        style: JBStyles.buttonLight,
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
