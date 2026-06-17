import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marshmallow/features/checkout/presentattion/pages/checkout_page.dart';
import 'package:marshmallow/features/home/presentation/bloc/product_provider.dart';
import 'package:marshmallow/features/home/presentation/pages/home_page.dart';
import 'package:marshmallow/features/productDetail/presentation/bloc/add_to_cart_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../widgets/home_header.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool showMenu = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadCartIfNeeded(forceRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<AddToCartProvider>();

    final cartItems = productProvider.cartItems;
    final summary = productProvider.cartModel?.results.summary;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.primary,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  HomeHeader(
                    onMenuTap: () {
                      setState(() {
                        showMenu = !showMenu;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const CustomSearchBar(),
                ],
              ),
            ),
            Expanded(
              child: productProvider.cartModel == null
                  ? const Center(child: CircularProgressIndicator())
                  : cartItems.isEmpty
                  ? _emptyCart()
                  : Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(12),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  "${cartItems.length} Items in Cart",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),

                              ...cartItems.map(
                                (item) => Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: Image.network(
                                              item.thumbnail,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
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
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                const SizedBox(height: 10),
                                                Text(
                                                  "₹${item.price}",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                const SizedBox(height: 10),

                                                if (item.attributes.isNotEmpty)
                                                  Wrap(
                                                    spacing: 8,
                                                    children: item.attributes
                                                        .map(
                                                          (e) => Chip(
                                                            label: Text(
                                                              e.value,
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed:
                                                      cartProvider
                                                              .updatingCartId ==
                                                          item.id
                                                      ? null
                                                      : () async {
                                                          if (item.quantity >
                                                              1) {
                                                            await cartProvider
                                                                .updateCart(
                                                                  cartItemId:
                                                                      item.id,
                                                                  quantity:
                                                                      item.quantity -
                                                                      1,
                                                                );
                                                            await productProvider
                                                                .loadCartIfNeeded(
                                                                  forceRefresh:
                                                                      true,
                                                                );
                                                          }
                                                        },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                  ),
                                                ),
                                                cartProvider.updatingCartId ==
                                                        item.id
                                                    ? const SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                            ),
                                                      )
                                                    : Text(
                                                        "${item.quantity}",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                IconButton(
                                                  onPressed:
                                                      cartProvider
                                                              .updatingCartId ==
                                                          item.id
                                                      ? null
                                                      : () async {
                                                          await cartProvider
                                                              .updateCart(
                                                                cartItemId:
                                                                    item.id,
                                                                quantity:
                                                                    item.quantity +
                                                                    1,
                                                              );
                                                          await productProvider
                                                              .loadCartIfNeeded(
                                                                forceRefresh:
                                                                    true,
                                                              );
                                                        },
                                                  icon: const Icon(Icons.add),
                                                ),
                                              ],
                                            ),
                                          ),

                                          OutlinedButton(
                                            onPressed:
                                                cartProvider.removingCartId ==
                                                    item.id
                                                ? null
                                                : () async {
                                                    await cartProvider
                                                        .removeCart(
                                                          cartItemId: item.id,
                                                        );
                                                    await productProvider
                                                        .loadCartIfNeeded(
                                                          forceRefresh: true,
                                                        );
                                                  },
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                            child:
                                                cartProvider.removingCartId ==
                                                    item.id
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                : const Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Price details",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    _row("Items", "${summary?.items ?? 0}"),
                                    const SizedBox(height: 10),

                                    _row(
                                      "Subtotal",
                                      "₹${(summary?.subtotal ?? 0).toStringAsFixed(2)}",
                                    ),

                                    const SizedBox(height: 10),

                                    _row("Delivery", "FREE"),

                                    const Divider(),

                                    _row(
                                      "Total",
                                      "₹${(summary?.subtotal ?? 0).toStringAsFixed(2)}",
                                      isBold: true,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(color: Colors.white),
                          child: SafeArea(
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const CheckoutPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Proceed To Checkout  ₹${(summary?.subtotal ?? 0).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: Colors.grey,
            ),

            const SizedBox(height: 20),
            const Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            Text(
              "Looks like you haven't added anything to your cart yet",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 250,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
