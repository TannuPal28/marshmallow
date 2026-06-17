import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/bloc/product_provider.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    final cartItems = productProvider.cartItems;

    final summary = productProvider.cartModel?.results.summary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Order Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            separatorBuilder: (_, __) =>
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(),
            ),
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(12),
                      child: Image.network(
                        item.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          item.title,
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: item.attributes.map((attribute) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                attribute.value,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [

                            Container(
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration:
                              BoxDecoration(
                                color: Colors
                                    .grey.shade100,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  20,
                                ),
                              ),
                              child:  Text(
                                "Qty ${item.quantity}",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            const Spacer(),

                             Text(
                              "₹${item.price}",
                              style: TextStyle(
                                fontWeight:
                                FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 25),

          const Divider(),

          const SizedBox(height: 20),

          _priceRow(
            title: "Subtotal",
            value: "₹${(summary?.subtotal ?? 0).toStringAsFixed(2)}",
          ),

          const SizedBox(height: 12),

          _priceRow(
            title: "Delivery",
            value: "FREE",
            valueColor: Colors.green,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Divider(),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter coupon code",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff737b84),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Divider(
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹${(summary?.subtotal ?? 0).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xffb0083a),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Text(
                  "Secure SSL Encryption",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height:5),

          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xffb0083a),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.security,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Text(
                  "100% Payment Protection",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),


    );

  }

  Widget _priceRow({
    required String title,
    required String value,
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor,
            fontWeight: isBold
                ? FontWeight.w700
                : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}