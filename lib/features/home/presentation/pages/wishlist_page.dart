import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marshmallow/core/theme/app_colors.dart';
import 'package:marshmallow/core/widgets/custom_search_bar.dart';
import 'package:marshmallow/features/home/presentation/bloc/product_provider.dart';
import 'package:marshmallow/features/home/presentation/pages/home_page.dart';
import 'package:marshmallow/features/home/presentation/widgets/home_header.dart';
import 'package:marshmallow/features/productDetail/presentation/bloc/add_to_cart_provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool showMenu = false;
  String? removingProductId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final cartProvider = context.watch<AddToCartProvider>();
    final items = provider.wishlistData?.results.items ?? [];

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
              child: provider.wishlistData == null
                  ? const Center(child: CircularProgressIndicator())
                  : items.isEmpty
                  ? _emptyWishlist()
                  : ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "My Wishlist (${items.length} items)",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ...items.map(
                          (item) => _wishlistCard(
                            context,
                            item,
                            provider,
                            cartProvider,
                          ),
                        ),
                        const SizedBox(height: 20),

                        //Smmary
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Wishlist Summary",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 20),
                              _summaryRow("Total Items", "${items.length}"),

                              const SizedBox(height: 20),

                              _summaryRow("Items on Sale", "${items.length}"),

                              const SizedBox(height: 20),

                              _summaryRow(
                                "Estimated Total",
                                "₹${items.fold<double>(0, (sum, e) => sum + e.price.toDouble()).toStringAsFixed(0)}",
                              ),
                              const SizedBox(height: 30),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Wishlist Tips:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text("• Get notified when prices drop"),
                                    SizedBox(height: 8),
                                    Text("• Share your wishlist with friends"),
                                    SizedBox(height: 8),
                                    Text(
                                      "• Items stay saved until you remove them",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const HomePage()),
                                          (route) => false,
                                    );
                                  },
                                  child: const Text("Continue Shopping"),
                                ),
                              ),
                            ],
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

  Widget _wishlistCard(
    BuildContext context,
    dynamic item,
    ProductProvider provider,
    AddToCartProvider cartProvider,
  ) {
    final discount = item.mrp > 0
        ? (((item.mrp - item.price) / item.mrp) * 100).round()
        : 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.thumbnail,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "₹${item.price}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "₹${item.mrp}",
                          style: const TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "$discount% off",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Free delivery",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          const Divider(),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: cartProvider.addingProductId == item.productId
                    ? null
                    : () async {
                        final isAdded = await cartProvider.addToCart(
                          productId: item.productId,
                          quantity: 1,
                          variantId: item.variantId,
                        );
                        if (isAdded) {
                          //wishlist se remove
                          await provider.wishlistRemove(
                            productId: item.productId,
                            variantId: item.variantId ?? "",
                          );
                          // Wishlist refresh
                          await provider.fetchWishlist();
                        }
                      },
                child: cartProvider.addingProductId == item.productId
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart),
                          SizedBox(width: 6),
                          Text("Add to Cart"),
                        ],
                      ),
              ),

              OutlinedButton(
                onPressed: removingProductId == item.productId
                    ? null
                    : () async {
                        setState(() {
                          removingProductId = item.productId;
                        });

                        try {
                          await provider.wishlistRemove(
                            productId: item.productId,
                            variantId: item.variantId ?? "",
                          );

                          await provider.fetchWishlist();
                        } finally {
                          if (mounted) {
                            setState(() {
                              removingProductId = null;
                            });
                          }
                        }
                      },
                child: removingProductId == item.productId
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 6),
                          Text("Remove", style: TextStyle(color: Colors.red)),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        Text(value, style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _emptyWishlist() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            const Text("❤️", style: TextStyle(fontSize: 120)),

            const Text(
              "Your wishlist is empty",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Text(
              "Save items you love for later",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 50),

            SizedBox(
              width: 260,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
