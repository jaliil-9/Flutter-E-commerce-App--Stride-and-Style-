import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/personalization/controllers/address_controller.dart';
import 'package:stride_style_ecom/features/personalization/screens/addresses%20widgets/address_card.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      backgroundColor: JBStyles.cream,

      // Add New Adress Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddress()),
        backgroundColor: JBStyles.deepNavy,
        child: const Icon(
          Icons.add,
          color: JBStyles.whiteCream,
        ),
      ),

      // AppBar
      appBar: const JBAppBar(
        title: "Addresses",
        showBackArrow: true,
      ),

      // Addresses
      body: Padding(
        padding: const EdgeInsets.all(JBSizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.allUserAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: JBStyles.burnishedGold));
                }
                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return Center(
                    child:
                        Text('No data available!', style: JBStyles.priceLight),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong!',
                        style: JBStyles.priceLight),
                  );
                }
                final addresses = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => JBAddressCard(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index])),
                );
              }),
        ),
      ),
    );
  }
}

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      backgroundColor: JBStyles.cream,

      // AppBar
      appBar: const JBAppBar(
        title: "Add new Address",
        showBackArrow: true,
      ),

      // Address Form
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JBSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                // Name Textfield
                TextFormField(
                  controller: controller.name,
                  decoration: JBStyles.inputDecoration(context,
                      prefixIcon: const Icon(Icons.person), labelText: 'Name'),
                ),
                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Phone number Textfield
                TextFormField(
                  controller: controller.phoneNumber,
                  decoration: JBStyles.inputDecoration(context,
                      prefixIcon: const Icon(Icons.local_phone),
                      labelText: 'Phone number'),
                ),
                const SizedBox(height: JBSizes.spaceBtwInputFields),

                // Address Textfield
                Row(
                  children: [
                    // Street Textfield
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        decoration: JBStyles.inputDecoration(context,
                            prefixIcon: const Icon(Icons.home),
                            labelText: 'Street'),
                      ),
                    ),
                    const SizedBox(width: JBSizes.spaceBtwInputFields),

                    // Postal Code Textfield
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        decoration: JBStyles.inputDecoration(context,
                            prefixIcon: const Icon(Icons.numbers),
                            labelText: 'Postal code'),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: JBSizes.spaceBtwInputFields),
                Row(
                  children: [
                    // City Textfield
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        decoration: JBStyles.inputDecoration(context,
                            prefixIcon: const Icon(Icons.location_city),
                            labelText: 'City'),
                      ),
                    ),
                    const SizedBox(width: JBSizes.spaceBtwInputFields),

                    // State Textfield
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        decoration: JBStyles.inputDecoration(context,
                            prefixIcon: const Icon(Icons.location_on),
                            labelText: 'State'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: JBSizes.spaceBtwInputFields,
                ),

                TextFormField(
                  controller: controller.country,
                  decoration: JBStyles.inputDecoration(context,
                      prefixIcon: const Icon(Icons.map), labelText: 'Country'),
                ),
                const SizedBox(
                  height: JBSizes.spaceBtwSections,
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    style: JBStyles.primaryButtonStyle(context),
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
