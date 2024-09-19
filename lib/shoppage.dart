import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedCategory = 'Whey Protein';
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  bool isLoading = true; // Loading indicator
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Fetch data from API with error handling and timeout
  Future<void> fetchProducts() async {
    try {
      var url = 'https://gym-management-2.onrender.com/products/';
      var response =
      await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

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
        backgroundColor: Color(0xFF00B2B2),
        title: Text('SHOPS'),
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
      backgroundColor: Color(0xFF00B2B2),
      body: isLoading
          ? Center(child: CircularProgressIndicator())// Show message if no products
          : Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0x96D9D9D9),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.07),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: filterProducts, // Filter products as user types
            ),
            SizedBox(height: screenHeight * 0.02), // Add some space below the search bar

            // Create Button
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
              child: Text('Create New Product'),
            ),

            // Product Grid
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
                          builder: (context) => ProductDetailPage(product: filteredProducts[index]),
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
                side: BorderSide(width: 1, color: Color(0xFF9736C1)),
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              image: DecorationImage(
                image: NetworkImage(product['image']), // Use NetworkImage for images from API
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
                color: Color(0xFFD2FFE8),
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
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${product['price']}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteProduct(product['_id']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      updateProduct(
                        product['_id'],
                        'Updated Name',
                        '34.99',
                        'Updated description',
                        product['image'],
                        product['stock'],
                        product['reviews'],
                      );
                    },
                  ),
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

  CreateProductPage({required this.onCreate});

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
        title: Text('Create New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: stockController,
              decoration: InputDecoration(labelText: 'Stock Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: reviewsController,
              decoration: InputDecoration(labelText: 'Reviews'),
            ),
            SizedBox(height: 20),
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
              child: Text('Create Product'),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Detail Page
class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailPage({required this.product});

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
            SizedBox(height: 16.0),
            Text(
              product['desc'],
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '\$${product['price']}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Stock: ${product['stock']}'),
            SizedBox(height: 16.0),
            Text('Reviews: ${product['reviews']}'),
          ],
        ),
      ),
    );
  }
}
