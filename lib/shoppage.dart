import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedCategory = 'Whey Protein';
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  String userRole = 'user'; // Default role

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    fetchProducts();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user') ?? 'user';
    });
  }

  // Fetch data from API with error handling and timeout
  Future<void> fetchProducts() async {
    try {
      var url = 'https://gym-management-2.onrender.com/products/';
      var response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          products = data;
          filteredProducts = products; // Initialize filteredProducts with all products
          isLoading = false; // Data fetched, hide the loading indicator
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showErrorMessage('Failed to load products: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorMessage('Client error: $e');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorMessage('Error: $e');
    }
  }

  // Show error message
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Filter products based on the search query
  void filterProducts(String query) {
    List<dynamic> filtered = products.where((product) {
      final productName = product['name'].toLowerCase();
      final input = query.toLowerCase();
      return productName.contains(input);
    }).toList();

    setState(() {
      filteredProducts = filtered;
    });
  }

  // Create a new product
  Future<void> createProduct(String name, String price, String desc,
      String image, int stock, String reviews) async {
    if (userRole != 'admin') {
      _showErrorMessage('You do not have permission to create products.');
      return;
    }
    try {
      var url = 'https://gym-management-2.onrender.com/products/';
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'name': name,
          'price': price,
          'desc': desc,
          'image': image,
          'stock': stock,
          'reviews': reviews,
        }),
      );

      if (response.statusCode == 201) {
        fetchProducts(); // Fetch updated products list
      } else {
        _showErrorMessage('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String productId) async {
    if (userRole != 'admin') {
      _showErrorMessage('You do not have permission to delete products.');
      return;
    }
    try {
      var url = 'https://gym-management-2.onrender.com/products/$productId';
      var response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        fetchProducts(); // Fetch updated products list
      } else {
        _showErrorMessage('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
    }
  }

  // Update a product
  Future<void> updateProduct(String productId, String name, String price,
      String desc, String image, int stock, String reviews) async {
    if (userRole != 'admin') {
      _showErrorMessage('You do not have permission to update products.');
      return;
    }
    try {
      var url = 'https://gym-management-2.onrender.com/products/$productId';
      var response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'name': name,
          'price': price,
          'desc': desc,
          'image': image,
          'stock': stock,
          'reviews': reviews,
        }),
      );

      if (response.statusCode == 200) {
        fetchProducts(); // Fetch updated products list
      } else {
        _showErrorMessage('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B2B2),
        title: const Text('SHOPS'),
        actions: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.013),
            child: Image.asset(
              'assets/gym_logo.png',
              width: screenWidth * 0.2,
              height: screenHeight * 0.08,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF00B2B2),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0x96D9D9D9),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.07),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: filterProducts,
            ),
            SizedBox(height: screenHeight * 0.02),

            if (userRole == 'admin') ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateProductPage(
                        onCreate: (name, price, desc, image, stock, reviews) {
                          createProduct(name, price, desc, image, stock, reviews);
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Create New Product'),
              ),
            ],

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.04,
                  mainAxisSpacing: screenHeight * 0.07,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: filteredProducts[index],
                            userRole: userRole,
                          ),
                        ),
                      );
                    },
                    child: _buildProductCard(filteredProducts[index], screenWidth, screenHeight),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
      Map<String, dynamic> product, double screenWidth, double screenHeight) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: screenWidth * 0.55,
            height: screenHeight * 0.28,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFF9736C1)),
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              image: DecorationImage(
                image: NetworkImage(product['image']),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: -screenHeight * 0.05,
            child: Container(
              width: screenWidth * 0.44,
              height: screenHeight * 0.11,
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: ShapeDecoration(
                color: const Color(0xFFD2FFE8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${product['price']}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (userRole == 'admin') ...[
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteProduct(product['_id']);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProductPage(
                              product: product,
                              onUpdate: (id, name, price, desc, image, stock, reviews) {
                                updateProduct(id, name, price, desc, image, stock, reviews);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CreateProductPage to input product details
class CreateProductPage extends StatelessWidget {
  final Function(String, String, String, String, int, String) onCreate;

  CreateProductPage({super.key, required this.onCreate});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController reviewsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Stock Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: reviewsController,
              decoration: const InputDecoration(labelText: 'Reviews'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onCreate(
                  nameController.text,
                  priceController.text,
                  descController.text,
                  imageController.text,
                  int.parse(stockController.text),
                  reviewsController.text,
                );
                Navigator.pop(context); // Close the form after submission
              },
              child: const Text('Create Product'),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Detail Page

class UpdateProductPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(String, String, String, String, String, int, String) onUpdate;

  UpdateProductPage({super.key, required this.product, required this.onUpdate});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController reviewsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = product['name'];
    priceController.text = product['price'].toString();
    descController.text = product['desc'];
    imageController.text = product['image'];
    stockController.text = product['stock'].toString();
    reviewsController.text = product['reviews'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: 'Stock Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: reviewsController,
              decoration: const InputDecoration(labelText: 'Reviews'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onUpdate(
                  product['_id'],
                  nameController.text,
                  priceController.text,
                  descController.text,
                  imageController.text,
                  int.parse(stockController.text),
                  reviewsController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final String userRole;

  const ProductDetailPage({super.key, required this.product, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['image']),
            const SizedBox(height: 16.0),
            Text(
              product['desc'],
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              '\$${product['price']}',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text('Stock: ${product['stock']}'),
            const SizedBox(height: 16.0),
            Text('Reviews: ${product['reviews']}'),
            if (userRole != 'admin') ...[
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement add to cart functionality
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

