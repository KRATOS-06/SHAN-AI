import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  Future<void> fetchProducts() async {
    try {
      var url = 'https://gym-management-2.onrender.com/products/';
      var response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          products = data;
          filteredProducts = products;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showErrorMessage('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorMessage('Error: $e');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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

  Future<void> createProduct(String name, String price, String desc,
      File image, int stock, String reviews, String type) async {
    if (userRole != 'admin') {
      _showErrorMessage('You do not have permission to create products.');
      return;
    }
    try {
      var url = 'https://gym-management-2.onrender.com/products/';
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['name'] = name;
      request.fields['price'] = price;
      request.fields['type'] = type;
      request.fields['desc'] = desc;
      request.fields['stock'] = stock.toString();
      request.fields['reviews'] = reviews;
      request.fields['gym_id'] = prefs.getString('gym_id') ?? '';
      request.fields['admin'] = prefs.getString('user_id') ?? '';

      var pic = await http.MultipartFile.fromPath('image', image.path);
      request.files.add(pic);

      var response = await request.send();
      if (response.statusCode == 201) {
        fetchProducts();
      } else {
        _showErrorMessage('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    if (userRole != 'admin') {
      _showErrorMessage('You do not have permission to delete products.');
      return;
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Get the required query parameters
      String adminId = prefs.getString('user_id') ?? '';
      String gymId = prefs.getString('gym_id') ?? '';

      // Construct the URL with query parameters
      var url =
          'https://gym-management-2.onrender.com/products/?admin=$adminId&gym_id=$gymId&product_id=$productId';

      // Make the DELETE request
      var response = await http.delete(Uri.parse(url));

      // Handle the response
      if (response.statusCode == 204) {
        fetchProducts(); // Fetch updated products list
      } else {
        print(response.body);
        _showErrorMessage('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Error: $e');
    }
  }


  Future<void> updateProduct(String productId, String name, String price,
      String desc, File? image, int stock, String reviews, String type) async {
    if (userRole != 'admin') {
      _showErrorMessage('You do not have permission to update products.');
      return;
    }
    try {
      var url = 'https://gym-management-2.onrender.com/products/';
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Create a Multipart request for updating product (using PUT method)
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      // Add the necessary fields (as required by the API)
      request.fields['stock'] = stock.toString();
      request.fields['admin'] = prefs.getString('user_id') ?? ''; // Admin ID
      request.fields['gym_id'] = prefs.getString('gym_id') ?? ''; // Gym ID
      request.fields['product_id'] = productId;  // Product ID for updating


      // Send the request
      var response = await request.send();

      // Debugging: print the fields being sent
      print(request.fields);

      // Handle response
      if (response.statusCode == 200) {
        fetchProducts();  // Refresh the product list if update succeeds
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
                        onCreate: (name, price, desc, image, stock, reviews, type) {
                          createProduct(name, price, desc, image, stock, reviews, type);
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
                image: NetworkImage('https://gym-management-2.onrender.com/products/' + product['image']),
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
                        deleteProduct(product['id']);
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
                              onUpdate: (id, name, price, desc, image, stock, reviews, type) {
                                updateProduct(id, name, price, desc, image, stock, reviews, type);
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

class CreateProductPage extends StatefulWidget {
  final Function(String, String, String, File, int, String, String) onCreate;

  const CreateProductPage({Key? key, required this.onCreate}) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController reviewsController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Type'),
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
              onPressed: getImage,
              child: const Text('Pick Image'),
            ),
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  widget.onCreate(
                    nameController.text,
                    priceController.text,
                    descController.text,
                    _image!,
                    int.parse(stockController.text),
                    reviewsController.text,
                    typeController.text,
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select an image')),
                  );
                }
              },
              child: const Text('Create Product'),
            ),
          ],
        ),
      ),
    );
  }
}


class UpdateProductPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(String, String, String, String, File?, int, String, String) onUpdate;

  const UpdateProductPage({Key? key, required this.product, required this.onUpdate}) : super(key: key);

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController reviewsController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product['name']?.toString() ?? '';
    typeController.text = widget.product['type']?.toString() ?? '';
    priceController.text = widget.product['price']?.toString() ?? '';
    descController.text = widget.product['desc']?.toString() ?? '';
    stockController.text = widget.product['stock']?.toString() ?? '';
    reviewsController.text = widget.product['reviews']?.toString() ?? '';
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Type'),
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
              onPressed: getImage,
              child: const Text('Pick Image'),
            ),
            _image != null
                ? Image.file(_image!)
                : (widget.product['image'] != null
                ? Image.network('https://gym-management-2.onrender.com/products/${widget.product['image']}')
                : const Text('No image available')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    stockController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields')),
                  );
                  return;
                }

                // Ensure the '_id' field is not null
                final productId = widget.product['id']?.toString() ?? '';
                print(productId);

                if (productId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product ID is missing')),
                  );
                  return;
                }

                widget.onUpdate(
                  productId,
                  nameController.text,
                  priceController.text,
                  descController.text,
                  _image,
                  int.tryParse(stockController.text) ?? 0,
                  reviewsController.text,
                  typeController.text,
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

  const ProductDetailPage({Key? key, required this.product, required this.userRole}) : super(key: key);

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
            Image.network('https://gym-management-2.onrender.com/products/${product['image']}'),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
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