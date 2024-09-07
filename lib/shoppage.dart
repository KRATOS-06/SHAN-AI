import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedCategory = 'Whey Protein';

  // Dummy data for products categorized by type
  Map<String, List<Map<String, dynamic>>> productData = {
    'Whey Protein': [
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {'name': 'Quest Nutrition', 'price': 2399, 'image': 'assets/quest_nutrition.png'},
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
    ],
    'Vitamin': [
      {'name': 'Vitamin C', 'price': 999, 'image': 'assets/vitamin_c.png'},
      {'name': 'Vitamin D3', 'price': 799, 'image': 'assets/vitamin_d3.png'},
    ],
    'Gainers': [
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
    ],
    'Test Boosters': [
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
    ]
  };

  @override
  Widget build(BuildContext context) {
    // Obtain screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                TextField(
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
                ),
                SizedBox(height: screenHeight * 0.02),

                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryButton('Whey Protein', 'assets/whey_protein_icon.png', screenWidth, screenHeight),
                      SizedBox(width: screenWidth * 0.04),
                      _buildCategoryButton('Vitamin', 'assets/vitamin_icon.png', screenWidth, screenHeight),
                      SizedBox(width: screenWidth * 0.04),
                      _buildCategoryButton('Gainers', 'assets/gainer_icon.png', screenWidth, screenHeight),
                      SizedBox(width: screenWidth * 0.04),
                      _buildCategoryButton('Test Boosters', 'assets/test_booster_icon.png', screenWidth, screenHeight),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Category Title
                Center(
                  child: Text(
                    selectedCategory,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Product Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenHeight * 0.07,
                    childAspectRatio: 0.8, // Adjust this ratio to match the image
                  ),
                  itemCount: productData[selectedCategory]!.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(index, screenWidth, screenHeight);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, String iconPath, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.1,
            backgroundColor: Colors.white,
            child: Image.asset(
              iconPath,
              height: screenHeight * 0.06,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.037,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index, double screenWidth, double screenHeight) {
    var product = productData[selectedCategory]![index];
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // First container with increased height by 10%
          Container(
            width: screenWidth * 0.55,
            height: screenHeight * 0.28, // Increased by 10%
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF9736C1)),
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              image: DecorationImage(
                image: AssetImage(product['image']),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Second container positioned inside the bottom of the first container
          Positioned(
            bottom: -screenHeight * 0.05, // Adjust based on the screen height
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Column for the price and product name
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product['name']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontFamily: 'Inria Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          '\$${product['price']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Inria Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add the shopping cart icon and "BUY NOW" button
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Shopping cart icon
                      Icon(
                        Icons.shopping_cart,
                        size: screenWidth * 0.07,
                        color: Colors.black,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // "BUY NOW" button
                      GestureDetector(
                        onTap: () {
                          // Handle buy now action here
                        },
                        child: Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.03,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              'BUY NOW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.025,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
