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
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
    ],
    'Vitamin': [
      {'name': 'Vitamin C', 'price': 999, 'image': 'assets/vitamin_c.png'},
      {'name': 'Vitamin D3', 'price': 799, 'image': 'assets/vitamin_d3.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
    ],
    'Gainers': [
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
    ],
    'Test Boosters': [
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
      {'name': 'Dymatize', 'price': 2999, 'image': 'assets/dymatize.png'},
      {'name': 'Cellucor', 'price': 2100, 'image': 'assets/cellucor.png'},
      {
        'name': 'Quest Nutrition',
        'price': 2399,
        'image': 'assets/quest_nutrition.png'
      },
      {'name': 'PEScience', 'price': 2949, 'image': 'assets/pescience.png'},
      {'name': 'Isopure', 'price': 1999, 'image': 'assets/cellucor.png'},
      {'name': 'ProSupps', 'price': 2799, 'image': 'assets/prosupps.png'},
    ]
    // Add more categories with products as needed
  };

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/gym_logo.png',
                width: 70.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF00B2B2),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
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
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryButton(
                          'Whey Protein', 'assets/whey_protein_icon.png'),
                      SizedBox(width: 16.0),
                      _buildCategoryButton(
                          'Vitamin', 'assets/vitamin_icon.png'),
                      SizedBox(width: 16.0),
                      _buildCategoryButton('Gainers', 'assets/gainer_icon.png'),
                      SizedBox(width: 16.0),
                      _buildCategoryButton(
                          'Test Boosters', 'assets/test_booster_icon.png'),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),

                // Category Title
                Center(
                  child: Text(
                    selectedCategory,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
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
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 40.0,
                    childAspectRatio:
                        0.8, // Adjust this ratio to match the image
                  ),
                  itemCount: productData[selectedCategory]!.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, String iconPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Image.asset(
              iconPath,
              height: 40,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(index) {
    var product = productData[selectedCategory]![index];
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // First container with increased height by 10%
          Container(
            width: 208,
            height: 214, // Increased by 10%
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFF9736C1)),
                borderRadius: BorderRadius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage(product['image']),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Second container positioned inside the bottom of the first container
          Positioned(
            bottom: -35.5, // Half of the second container's height
            child: Container(
              width: 182,
              height: 87,
              padding: EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: Color(0xFFD2FFE8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
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
                            fontSize: 12,
                            fontFamily: 'Inria Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${product['price']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
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
                        size: 30,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8.0),
                      // "BUY NOW" button
                      GestureDetector(
                        onTap: () {
                          // Handle buy now action here
                        },
                        child: Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              'BUY NOW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
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
