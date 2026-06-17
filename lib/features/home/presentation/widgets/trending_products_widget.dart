import 'package:flutter/material.dart';
import 'package:marshmallow/core/utils/utils.dart';
import 'package:marshmallow/features/productDetail/presentation/bloc/add_to_cart_provider.dart';
import 'package:marshmallow/features/productDetail/presentation/pages/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../bloc/product_provider.dart';

class TrendingProductsWidget extends StatefulWidget {
  final bool isFromProductDetail;
  final String? categoryId;
  final String? productId;

  const TrendingProductsWidget({
    super.key,
    this.isFromProductDetail = false,
    this.categoryId,
    this.productId,
  });

  @override
  State<TrendingProductsWidget> createState() => _TrendingProductsWidgetState();
}

class _TrendingProductsWidgetState extends State<TrendingProductsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();


      // SIMILAR PRODUCTS
      if (widget.isFromProductDetail) {
        provider.fetchSimilarProducts(
          categoryId: widget.categoryId ?? "",
          productId: widget.productId ?? "",
        );
      } else {
        // TRENDING PRODUCTS
        provider.fetchProducts();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // ONLY TRENDING HAS PAGINATION
        if (!widget.isFromProductDetail) {
          context.read<ProductProvider>().fetchProducts(isLoadMore: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    final List<dynamic> items = widget.isFromProductDetail
        ? provider.similarProducts
        : provider.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          child: Center(
            child: Text(
              widget.isFromProductDetail
                  ? "Similar Products"
                  : "Trending Products",

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),

        SizedBox(
          height: 320,

          child: provider.isLoading && items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : items.isEmpty
              ? const Center(child: Text("No Products Found"))
              : ListView.builder(
                  controller: _scrollController,

                  scrollDirection: Axis.horizontal,

                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  itemCount: widget.isFromProductDetail
                      ? items.length
                      : provider.hasMore
                      ? items.length + 1
                      : items.length,

                  itemBuilder: (context, index) {
                    // PAGINATION LOADER
                    if (!widget.isFromProductDetail && index == items.length) {
                      return const Padding(
                        padding: EdgeInsets.all(20),

                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final product = items[index];
                    final cartItem = provider.getCartItem(product.id);
                    final isFav = provider.isWishlisted(product.id);

                    final addToCartProvider =
                    context.watch<AddToCartProvider>();

                    final isUpdating =
                        addToCartProvider.updatingCartId == cartItem?.id;

                    // IMAGE
                    String image = "";

                    if (product.variantImage != null &&
                        product.variantImage.isNotEmpty &&
                        product.variantImage.first != null) {
                      image = product.variantImage.first;
                    } else if (product.images.isNotEmpty) {
                      image = product.images.first;
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(productId: product.id),
                          ),
                        );
                      },

                      child: Card(
                        elevation: 2,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        child: Container(
                          width: 180,

                          padding: const EdgeInsets.all(8),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              // ================= IMAGE =================
                              Stack(
                                children: [
                                  Container(
                                    height: 115,

                                    width: double.infinity,

                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],

                                      borderRadius: BorderRadius.circular(6),
                                    ),

                                    child: Image.network(
                                      image,

                                      fit: BoxFit.contain,

                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.broken_image,

                                              color: Colors.grey,
                                            );
                                          },
                                    ),
                                  ),

                                  Positioned(
                                    top: 8,
                                    right: 8,

                                    child: Container(
                                      padding: const EdgeInsets.all(4),

                                      decoration: const BoxDecoration(
                                        color: Colors.white,

                                        shape: BoxShape.circle,

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,

                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),

                                      child: GestureDetector(
                                        onTap: () async {
                                          final isLoggedIn =
                                              await Utils.checkLogin(context);

                                          if (!isLoggedIn) {
                                            return;
                                          }

                                          // wishlist api
                                          await context.read<ProductProvider>().toggleWishlistAPI(
                                            productId: product.id,
                                            variantId: product.firstVariantId ?? "",
                                          );

                                        },

                                        child: Icon(
                                          isFav ? Icons.favorite : Icons.favorite_border,
                                          color: isFav ? Colors.red : Colors.grey,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // ================= TITLE =================
                              Text(
                                product.title,

                                maxLines: 1,

                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  fontSize: 13,

                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // ================= RATING =================
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,

                                      vertical: 2,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Colors.green[700],

                                      borderRadius: BorderRadius.circular(4),
                                    ),

                                    child: Row(
                                      children: [
                                        Text(
                                          '${product.rating.rating}',

                                          style: const TextStyle(
                                            color: Colors.white,

                                            fontSize: 11,

                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(width: 2),

                                        const Icon(
                                          Icons.star,

                                          color: Colors.white,

                                          size: 10,
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    '(${product.rating.totalReviews})',

                                    style: const TextStyle(
                                      color: Colors.grey,

                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                "No description available",

                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // ================= PRICE =================
                              Row(
                                children: [
                                  Text(
                                    '₹${product.price}',

                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,

                                      fontSize: 14,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    '₹${product.mrp}',

                                    style: const TextStyle(
                                      color: Colors.grey,

                                      fontSize: 11,

                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    '${product.discountPercent}% off',

                                    style: const TextStyle(
                                      color: Colors.green,

                                      fontSize: 11,

                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                'Free delivery',

                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // ================= BUTTON =================
                              cartItem == null
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 32,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final isLoggedIn =
                                              await Utils.checkLogin(context);

                                          if (!isLoggedIn) return;

                                          final success = await context
                                              .read<AddToCartProvider>()
                                              .addToCart(
                                                productId: product.id,
                                                quantity: 1,
                                                variantId:
                                                    product.firstVariantId,
                                              );

                                          if (success) {
                                            provider.markCartDirty();

                                            await provider.loadCartIfNeeded(
                                              forceRefresh: true,
                                            );

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text("Added to cart"),
                                              ),
                                            );
                                          }
                                        },

                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF9E1B42,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "ADD TO CART",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF9E1B42),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                /*if (cartItem.quantity <= 1) {
                                                  return;
                                                }*/
                                                await context
                                                    .read<AddToCartProvider>()
                                                    .updateCart(
                                                      cartItemId: cartItem.id,
                                                      quantity:
                                                          cartItem.quantity - 1,
                                                    );
                                                provider.markCartDirty();

                                                await provider.loadCartIfNeeded(
                                                  forceRefresh: true,
                                                );
                                              },
                                              child: const Center(
                                                child: Icon(Icons.remove),
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            child: Center(
                                              child: isUpdating
                                                  ? const SizedBox(
                                                height: 18,
                                                width: 18,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              )
                                                  : Text(
                                                cartItem.quantity.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),


                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                await context
                                                    .read<AddToCartProvider>()
                                                    .updateCart(
                                                      cartItemId: cartItem.id,
                                                      quantity:
                                                          cartItem.quantity + 1,
                                                    );

                                                provider.markCartDirty();

                                                await provider.loadCartIfNeeded(
                                                  forceRefresh: true,
                                                );
                                              },
                                              child: const Center(
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
