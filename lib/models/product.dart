class Product {
  final String id;
  final String name;
  final double price;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });
}

const List<Product> sampleProducts = [
  Product(
    id: 'p1',
    name: 'Organic Apples',
    price: 5.50,
    description: 'Freshly picked organic apples (1kg).',
  ),
  Product(
    id: 'p2',
    name: 'Arabica Coffee Beans',
    price: 12.00,
    description: 'Medium roast beans, 500g pack.',
  ),
  Product(
    id: 'p3',
    name: 'Handmade Soap',
    price: 4.25,
    description: 'Lavender-scented soap bar.',
  ),
  Product(
    id: 'p4',
    name: 'Cotton Tote Bag',
    price: 8.75,
    description: 'Eco-friendly reusable tote.',
  ),
  Product(
    id: 'p5',
    name: 'Artisanal Honey',
    price: 9.40,
    description: 'Wildflower honey, 350g jar.',
  ),
];

