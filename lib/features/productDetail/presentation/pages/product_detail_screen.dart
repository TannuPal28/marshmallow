import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/features/productDetail/data/models/product_detail_model.dart';
import 'package:marshmallow/features/productDetail/presentation/bloc/add_to_cart_provider.dart';
import 'package:marshmallow/features/productDetail/presentation/bloc/product_detail_provider.dart';
import 'package:marshmallow/features/productDetail/presentation/widgets/build_color_button.dart';
import 'package:marshmallow/features/productDetail/presentation/widgets/build_thumbnail_widget.dart';
import 'package:marshmallow/features/productDetail/presentation/widgets/tab_reviews_widget.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/widgets/auth_header_widget.dart';
import '../../../home/presentation/widgets/trending_products_widget.dart';
import '../widgets/tab_description_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _activeTabIndex = 0;
  int _quantity = 1;
  bool showMenu = false;
  int _selectedThumbnailIndex = 0;

  final String _cloudinaryBaseUrl =
      "https://res.cloudinary.com/dqazwakn9/image/upload/v1767765160/";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailProvider>().fetchProduct(widget.productId);
    });
  }

  String _getImageUrl(String path) {
    if (path.isEmpty) return "https://via.placeholder.com/600x400.png";
    if (path.startsWith("http://") || path.startsWith("https://")) {
      return path;
    }
    return "$_cloudinaryBaseUrl$path";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductDetailProvider>();

    if (provider.status == ProductStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF9E1B32)),
        ),
      );
    }

    // सुरक्षा चेक: अगर स्टेटस loaded है पर प्रोडक्ट डेटा नहीं है या एरर आया है
    if (provider.status == ProductStatus.error || provider.product == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                provider.product == null
                    ? "ডेटा मॉडल पार्स नहीं हो पाया (Null Product)"
                    : provider.errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => provider.fetchProduct(widget.productId),
                child: const Text('Retry Fetching'),
              ),
            ],
          ),
        ),
      );
    }

    final product = provider.product!;
    final selectedVariant = provider.selectedVariant;

    // डेटा को सुरक्षित फ़ॉलबैक वैल्यू देना
    final double displayPrice = selectedVariant?.price ?? product.price ?? 0.0;
    final double displayMrp = selectedVariant?.mrp ?? product.mrp ?? 0.0;
    final int displayDiscount =
        selectedVariant?.discountPercent ?? product.discountPercent;

    String mainDisplayImage = "";
    if (selectedVariant != null && selectedVariant.images.isNotEmpty) {
      if (_selectedThumbnailIndex < selectedVariant.images.length) {
        mainDisplayImage = _getImageUrl(
          selectedVariant.images[_selectedThumbnailIndex],
        );
      } else {
        mainDisplayImage = _getImageUrl(selectedVariant.images[0]);
      }
    } else if (product.images.isNotEmpty) {
      mainDisplayImage = _getImageUrl(product.images[0]);
    } else {
      mainDisplayImage = "https://via.placeholder.com/600x400.png";
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeaderWidget(
                showMenu: showMenu,
                onMenuTap: () => setState(() => showMenu = !showMenu),
                isLoggedIn: false,
                userName: "",
                userEmail: "",
                onLogoutTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Home  /  Products  / ${product.title.isNotEmpty ? product.title : "Product Detail"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),

              // इमेज कंटेनर
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.network(
                    mainDisplayImage,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // थंबनेल्स लिस्ट
              if (selectedVariant != null && selectedVariant.images.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: selectedVariant.images.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String imageUrl = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedThumbnailIndex = idx),
                        child: BuildThumbnailWidget(
                          url: _getImageUrl(imageUrl),
                          isSelected: _selectedThumbnailIndex == idx,
                        ),
                      ),
                    );
                  }).toList(),
                ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title.isNotEmpty
                          ? product.title
                          : 'No Title Available',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${selectedVariant?.rating.rating ?? product.rating.rating} ★   ${selectedVariant?.rating.totalReviews ?? product.rating.totalReviews} Ratings & Reviews',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // प्राइसिंग रो
                    Row(
                      children: [
                        Text(
                          '₹${displayPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (displayMrp > 0)
                          Text(
                            '₹${displayMrp.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                            ),
                          ),
                        const SizedBox(width: 8),
                        if (displayDiscount > 0)
                          Text(
                            '$displayDiscount% off',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // कलर्स रैप विजेट
              if (product.variants.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Color:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        children: product.variants.map((variant) {
                          final colorAttr = variant.attributes.firstWhere(
                            (attr) => attr.name.toLowerCase() == 'color',
                            orElse: () => VariantAttributeModel(
                              attributeId: '',
                              value: 'Default',
                              name: 'color',
                            ),
                          );

                          bool isCurrentSelected =
                              selectedVariant?.id == variant.id;

                          return BuildColorButton(
                            text: colorAttr.value.toUpperCase(),
                            color: _parseHexColor(variant.colorHexCode),
                            isSelected: isCurrentSelected,
                            onTap: () {
                              setState(() => _selectedThumbnailIndex = 0);
                              provider.selectVariant(colorAttr.value);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

              // वेरिएंट डिटेल्स
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Variant Details:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _buildVariantDetailText(
                      'SKU:',
                      selectedVariant?.sku != null &&
                              selectedVariant!.sku.isNotEmpty
                          ? selectedVariant.sku
                          : 'N/A',
                    ),
                    _buildVariantDetailText(
                      'Stock:',
                      '${selectedVariant?.stock ?? product.stock} units',
                    ),
                    _buildVariantDetailText(
                      'Color Code:',
                      selectedVariant?.colorHexCode ?? 'N/A',
                    ),
                    _buildVariantDetailText(
                      'Material:',
                      selectedVariant?.material != null &&
                              selectedVariant!.material.isNotEmpty
                          ? selectedVariant.material
                          : product.material.isNotEmpty
                          ? product.material
                          : 'N/A',
                    ),
                  ],
                ),
              ),

              if (product.keyFeatures.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Key Features',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...product.keyFeatures.map(
                        (feature) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.brightness_1,
                                size: 6,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                feature,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPolicyRow(
                      'Delivery',
                      'SLA: ${selectedVariant?.procurementSLA ?? product.procurementSLA} Days',
                    ),
                    const Divider(height: 20),
                    _buildPolicyRow(
                      'Warranty',
                      product.warranty.duration.isNotEmpty
                          ? '${product.warranty.duration} Year (${product.warranty.type})'
                          : 'No Warranty',
                    ),
                    const Divider(height: 20),
                    _buildPolicyRow(
                      'Return Policy',
                      product.returnable
                          ? '${product.returnWindow} Days Return Policy'
                          : 'Non-Returnable',
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  (selectedVariant?.stock ?? product.stock) > 0
                      ? 'In Stock (Only ${selectedVariant?.stock ?? product.stock} left!)'
                      : 'Out of Stock',
                  style: TextStyle(
                    color: (selectedVariant?.stock ?? product.stock) > 0
                        ? Colors.green
                        : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 129,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            onPressed: () {
                              if (_quantity > 1) setState(() => _quantity--);
                            },
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: () {
                              num maxStock =
                                  selectedVariant?.stock ?? product.stock;
                              if (_quantity < maxStock)
                                setState(() => _quantity++);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9E1B32),
                        minimumSize: const Size(double.infinity, 48),
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: (selectedVariant?.stock ?? product.stock) > 0
                          ? () async {
                              final success = await context
                                  .read<AddToCartProvider>()
                                  .addToCart(
                                    productId: product.id,
                                    quantity: _quantity,
                                    variantId: selectedVariant?.id,
                                  );
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Added to cart"),
                                  ),
                                );
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to add cart"),
                                  ),
                                );
                              }
                            }
                          : null,
                      child: const Text(
                        'ADD TO CART',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9E1B32),
                        minimumSize: const Size(double.infinity, 48),
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: (selectedVariant?.stock ?? product.stock) > 0
                          ? () {}
                          : null,
                      child: const Text(
                        'BUY NOW',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  _buildTabHeaderItem('Description', 0),
                  _buildTabHeaderItem('Specifications', 1),
                  _buildTabHeaderItem('Reviews (${product.reviews.length})', 2),
                ],
              ),
              _buildActiveTabWidget(product),

              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Products you may like',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              TrendingProductsWidget(
                isFromProductDetail: true,
                categoryId: product.categoryId,
                productId: product.id,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Color _parseHexColor(String hexCode) {
    try {
      if (hexCode.isEmpty) return Colors.grey;
      final cleanHex = hexCode.replaceAll('#', '');
      return Color(int.parse('FF$cleanHex', radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }

  Widget _buildVariantDetailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$title ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildTabHeaderItem(String title, int index) {
    bool isSelected = _activeTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _activeTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[200]!),
              bottom: BorderSide(
                color: isSelected ? const Color(0xFF9E1B32) : Colors.grey[200]!,
                width: isSelected ? 3 : 1,
              ),
              left: BorderSide(color: Colors.grey[200]!),
              right: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: isSelected ? const Color(0xFF9E1B32) : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabWidget(ProductDetailModel product) {
    switch (_activeTabIndex) {
      case 0:
        return TabDescriptionWidget(
          title: 'Product Description',
          description: product.description.isNotEmpty
              ? product.description
              : "No description available.",
          keyFeatures: product.keyFeatures,
        );
      case 1:
        return TabDescriptionWidget(
          title: 'Specifications',
          description: product.shortDescription.isNotEmpty
              ? product.shortDescription
              : "No specifications available for this product.",
          keyFeatures: const [],
        );
      case 2:
        return const TabReviewsWidget();
      default:
        return const SizedBox.shrink();
    }
  }
}
