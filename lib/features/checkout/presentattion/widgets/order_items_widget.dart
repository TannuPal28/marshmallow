import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marshmallow/features/home/presentation/bloc/product_provider.dart';

class OrderItemsWidget extends StatelessWidget {
  const OrderItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider= context.watch<ProductProvider>();
    final cartItems= productProvider.cartItems;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Items",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const Divider(height: 30),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final item = cartItems[index];

              final totalPrice = item.price * item.quantity;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                      const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        item.thumbnail,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const SizedBox(
                          height: 220,
                          child: Center(
                            child: Icon(Icons.image),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text( item.title,
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 18,
                          ),),

                        const SizedBox(height: 10,),
                        if (item.attributes.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: item.attributes.map((attribute) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffe7e9ff),
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Text(
                                  attribute.value,
                                ),
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 12),
                        Text(
                          "Qty: ${item.quantity} × ₹${item.price.toStringAsFixed(2)}",
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "₹${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),)
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemCount: 2,
          ),

        ],
      ),
    );
  }
}
