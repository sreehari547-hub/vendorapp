import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendorapp/providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget _buildBody(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final items = cartProvider.items;

    if (items.isEmpty) {
      return const Center(child: Text('Your cart is empty'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.product.name),
                  subtitle: Text(
                    '₹${item.product.price.toStringAsFixed(2)} x ${item.quantity}',
                  ),
                  trailing: SizedBox(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cartProvider.decrementQuantity(item.product.id);
                            });
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cartProvider.incrementQuantity(item.product.id);
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cartProvider.removeItem(item.product.id);
                            });
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: items.length,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total: ₹${cartProvider.cartTotal.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    cartProvider.clearCart();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Checkout complete!')),
                  );
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final body = _buildBody(context);

    if (widget.embedded) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: body,
    );
  }
}

