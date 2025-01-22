import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/data/repositories/payment%20methods/payment_method_repository.dart';
import 'package:stride_style_ecom/features/personalization/models/payment_method_model.dart';
import 'package:stride_style_ecom/features/personalization/screens/payment/payment_method_card.dart';
import 'package:stride_style_ecom/features/personalization/screens/payment_method_screen.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/style.dart';
import '../../../utils/helpers/loaders.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../shop/screens/shop widgets/common/section_heading.dart';

class PaymentMethodController extends GetxController {
  static PaymentMethodController get instance => Get.find();

  final cardHolderName = TextEditingController();
  final cardNumber = TextEditingController();
  final expiryDate = TextEditingController();
  final securityCode = TextEditingController();
  GlobalKey<FormState> paymentMethodFormKey = GlobalKey<FormState>();

  final paymentRepo = Get.put(PaymentMethodRepository());
  final selectedPaymentMethod = PaymentMethodModel.empty().obs;
  RxBool refreshData = true.obs;

  // Fetch all user methods
  Future<List<PaymentMethodModel>> allUserMethods() async {
    try {
      final addresses = await paymentRepo.fetchUserPaymentMethods();
      selectedPaymentMethod.value = addresses.firstWhere(
          (element) => element.selectedPaymentMethod,
          orElse: () => PaymentMethodModel.empty());

      return addresses;
    } catch (e) {
      JBLoaders.errorSnackBar(
          title: 'Payment method not found!', message: e.toString());
      return [];
    }
  }

  // Update selected method field
  Future selectPaymentMethod(PaymentMethodModel newSelectedAddress) async {
    try {
      // Clear the selected field
      if (selectedPaymentMethod.value.id.isNotEmpty) {
        await paymentRepo.updateSelectedField(
            selectedPaymentMethod.value.id, false);
      }

      // Assign selected method
      newSelectedAddress.selectedPaymentMethod = true;
      selectedPaymentMethod.value = newSelectedAddress;

      // Set the selected field to true for the new selected method
      await paymentRepo.updateSelectedField(
          selectedPaymentMethod.value.id, true);
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Error!', message: e.toString());
    }
  }

  // save user new method
  Future addNewPaymentMethod() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      final method = PaymentMethodModel(
          id: '',
          cardHolderName: cardHolderName.text.trim(),
          cardNumber: cardNumber.text.trim(),
          expiryDate: expiryDate.text.trim(),
          securityCode: securityCode.text.trim(),
          selectedPaymentMethod: true);
      final id = await paymentRepo.addPaymentMethod(method);

      // Update selected method field
      method.id = id;
      await selectPaymentMethod(method);

      // Show success message
      JBLoaders.successSnackBar(
          title: 'Done!', message: 'Payment method saved succesfully');

      refreshData.toggle();
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      JBLoaders.errorSnackBar(title: 'Oops..', message: e.toString());
    }
  }

  Future<dynamic> selectNewMethodPopup(BuildContext context) {
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
                    headingText: 'Select Payment Method',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: JBSizes.spaceBtwSections,
                  ),
                  FutureBuilder(
                      future: allUserMethods(),
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
                            child: Text('No payment method available!',
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
                            itemBuilder: (_, index) => JBAPaymentMethodCard(
                                  method: snapshot.data![index],
                                  onTap: () async {
                                    await selectPaymentMethod(
                                        snapshot.data![index]);
                                    Get.back();
                                  },
                                ));
                      }),
                  const SizedBox(height: JBSizes.defaultSpace * 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          Get.to(() => const AddNewPaymentMethod()),
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
    cardHolderName.clear();
    cardNumber.clear();
    expiryDate.clear();
    securityCode.clear();
    paymentMethodFormKey.currentState?.reset();
  }
}
