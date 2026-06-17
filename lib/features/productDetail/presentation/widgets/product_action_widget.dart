import 'package:flutter/material.dart';

class ProductActionWidget extends StatelessWidget {
  final bool isUpdating;
  final bool isRemoving;
  final int quantity;

  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback? onRemove;
  final VoidCallback onGoToCart;
  final VoidCallback onContinueShopping;
  final bool showCartActions;
  final VoidCallback? onAddToCart;
  final bool isAdding;

  const ProductActionWidget({
    super.key,
    required this.isUpdating,
    required this.isRemoving,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
    required this.onRemove,
    required this.onGoToCart,
    required this.onContinueShopping,
    required this.showCartActions,
    this.onAddToCart, required this.isAdding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF9E1B32),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: isUpdating ? null : onMinus,
                        child: const Center(
                          child: Icon(Icons.remove),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: isUpdating
                            ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                            : Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: isUpdating ? null : onPlus,
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              flex: 2,
              child: SizedBox(
                height: 48,
                child: showCartActions
                    ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E1B32),
                  ),
                  onPressed: isRemoving ? null : onRemove,
                  child: isRemoving
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    "REMOVE",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9E1B32),
                  ),
                  onPressed: isAdding ? null : onAddToCart,
                  child: isAdding
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    "ADD TO CART",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        if (showCartActions) ...[
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9E1B32),
                    ),
                    onPressed: onGoToCart,
                    child: const Text(
                      "GO TO CART",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: onContinueShopping,
                    child: const Text(
                      "CONTINUE SHOPPING",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}