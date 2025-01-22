import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stride_style_ecom/commons/app_bar.dart';
import 'package:stride_style_ecom/features/shop/controllers/order_controller.dart';
import 'package:stride_style_ecom/utils/constants/sizes.dart';
import 'package:stride_style_ecom/utils/constants/style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: JBStyles.cream,

        // AppBar
        appBar: JBAppBar(
          title: "Orders",
          showBackArrow: true,
        ),

        // List of Orders
        body: Padding(
          padding: EdgeInsets.all(JBSizes.defaultSpace),
          child: JBOrderStatusList(),
        ));
  }
}

class JBOrderStatusList extends StatelessWidget {
  const JBOrderStatusList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return FutureBuilder(
        future: controller.getchUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator(color: JBStyles.burnishedGold));
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text('No orders available!', style: JBStyles.priceLight),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error loading orders', style: JBStyles.priceLight),
                  if (snapshot.error != null)
                    Text(
                      snapshot.error.toString(),
                      style: JBStyles.bodyLight,
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text('No orders available!', style: JBStyles.priceLight),
            );
          }

          final orders = snapshot.data!;

          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, index) => const SizedBox(
                    height: JBSizes.spaceBtwItems / 2,
                  ),
              itemBuilder: (_, index) {
                final order = orders[index];
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(bottom: JBSizes.spaceBtwItems),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: JBStyles.whiteCream,
                      border: Border.all(
                          color: JBStyles.burnishedGold.withOpacity(0.4))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          // Shipping Icon
                          const Icon(Icons.local_shipping),
                          const SizedBox(
                            width: JBSizes.spaceBtwItems,
                          ),

                          // Status & Date
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.orderStatusText,
                                  style: JBStyles.priceLight
                                      .apply(color: JBStyles.deepNavy)),
                              Text(order.formattedOrderDate,
                                  style: JBStyles.bodyLight),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: JBSizes.spaceBtwItems,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                // Tag Icon
                                const Icon(Icons.tag),
                                const SizedBox(
                                  width: JBSizes.spaceBtwItems,
                                ),

                                // Order Tag
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Order', style: JBStyles.priceLight),
                                      Text(order.id, style: JBStyles.bodyLight),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                // Tag Icon
                                const Icon(Icons.calendar_month),
                                const SizedBox(
                                  width: JBSizes.spaceBtwItems,
                                ),

                                // Order Tag
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Shipping Date',
                                          style: JBStyles.priceLight),
                                      Text(order.formattedDelivery,
                                          style: JBStyles.bodyLight),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }
}
