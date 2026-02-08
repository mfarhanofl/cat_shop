class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final String category;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
  });
}

final List<Product> Item = [
  Product(
    id: '1',
    name: ' Hp Laptop',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/lp(1).jpg',
    price: 25000.0,
    category: 'Laptop',
  ),
  Product(
    id: '2',
    name: ' HP Laptop',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/lp(2).jpg',
    price: 95000.0,
    category: 'Laptop',
  ),
  Product(
    id: '3',
    name: ' Mobile',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/pn.png',
    price: 28000.0,
    category: 'Smartphone',
  ),
  Product(
    id: '4',
    name: ' IPhone',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/IPhone.png',
    price: 98000.0,
    category: 'Smartphone',
  ),
  Product(
    id: '5',
    name: 'Tablet',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/tab.png',
    price: 8000.0,
    category: 'Tablet',
  ),
  Product(
    id: '6',
    name: 'Tablet',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/tb.png',
    price: 8000.0,
    category: 'Tablet',
  ),
  Product(
    id: '7',
    name: 'LCD',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/tv.png',
    price: 88000.0,
    category: 'TV',
  ),
  Product(
    id: '8',
    name: 'LCD',
    description:
        'Designed for power and portability, this high-performance device blends cutting-edge technology with a sleek, minimalist aesthetic.',
    image: 'images/tv1.png',
    price: 109000.0,
    category: 'TV',
  ),
];
