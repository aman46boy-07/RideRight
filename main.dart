import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(RideRightApp());
}

class RideRightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideRight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/compare': (context) => CompareScreen(),
        '/dealers': (context) => DealersScreen(),
        '/account': (context) => AccountScreen(),
        '/more': (context) => MoreScreen(),
      },
    );
  }
}

// 🟢 Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.motorcycle,
                size: 60,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'RideRight',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'DECODE YOUR RIDE',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🟢 Onboarding Screen
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Explore Bikes',
      'subtitle': 'Discover thousands of bikes and scooters',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa5QdEgB6BcDWAcUoeJvpVAHDUCGlJ_LIDWQ&s',
    },
    {
      'title': 'Compare & Choose',
      'subtitle': 'Compare features and find the perfect match',
      'image': 'https://imgd.aeplcdn.com/642x336/n/cw/ec/50511/suzuki-gixxer-sf-collage5.jpeg?wm=2&q=80',
    },
    {
      'title': 'Best Deals',
      'subtitle': 'Get the best prices and exclusive offers',
      'image': 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/yamaha-bikes-cars-poster-design-template-5e06187694ba4d2421cdd58c4cea260a_screen.jpg?ts=1715403653',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(141, 205, 214, 208),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _buildPage(_pages[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? Colors.blue : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text('Previous'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    if (_currentPage > 0) SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        child: Text(_currentPage < _pages.length - 1 ? 'Next' : 'Get Started'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> page) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              page['image'],
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, size: 60, color: Colors.grey)),
            ),
          ),
          SizedBox(height: 40),
          Text(
            page['title'],
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 19),
          Text(
            page['subtitle'],
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// 🟢 Auth Screen (Login/Signup)
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://img.autocarindia.com/ExtraImages/20210518083313_yamaha_R7_blue_1.jpg?w=700&c=1', // replace with your stable link
              fit: BoxFit.cover,
            ),
          ),

          // Optional: Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.6), // Darken for better contrast
            ),
          ),

          // Login Form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "RideRight",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      Navigator.pushReplacementNamed(context, '/home'); // ✅ FIXED
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: const Text("Login"),
),
),
                    const SizedBox(height: 12),
                    const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
     ),
);
}
}

// 🟢 Home Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.red),
            SizedBox(width: 8),
            Text('Kolhapur'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildFeaturedBike(),
            _buildCategoryGrid(),
            _buildMostSearchedBikes(),
            _buildPopularBrands(),
            _buildElectricZone(),
            _buildLatestBikes(),
            _buildUpcomingBikes(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Bikes or Scooters eg. YZF R15 V3, Act..',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          Icon(Icons.mic, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildFeaturedBike() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 200,
      child: _FeaturedBikeCarousel(),
    );
  }

Widget _buildCategoryGrid() {
  final categories = [
    {
      'title': 'Bikes',
      'subtitle': 'with best offers',
      'color': Colors.purple,
      'image': 'assets/images/bike-removebg-preview.png'
    },
    {
      'title': 'Scooters',
      'subtitle': 'with best offers',
      'color': Colors.red,
      'image': 'assets/images/scooter-removebg-preview.png'
    },
    {
      'title': 'Electric Vehicle',
      'subtitle': 'with best offers',
      'color': Colors.green,
      'image': 'assets/images/electric-removebg-preview.png'
    },
    {
      'title': 'Compare',
      'subtitle': 'and find the right bike',
      'color': Colors.blue,
      'image': 'assets/images/compare-removebg-preview.png'
    },
  ];

  return Container(
    margin: EdgeInsets.all(16),
    child: Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Container(
              decoration: BoxDecoration(
                color: category['color'] as Color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -0,
                    bottom: -0,
                    child: Image.asset( // ✅ Yeh ab asset wala image use karta hai
                      category['image'] as String,
                      width: 200,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category['title'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          category['subtitle'] as String,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View more'),
            SizedBox(width: 8),
            Icon(Icons.keyboard_arrow_down, color: Colors.red),
          ],
        ),
      ],
),
);
}

  Widget _buildMostSearchedBikes() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Most Searched Bikes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildBikeCard('Honda SP 125', '₹ 93,247 - 1.02 Lakh*', 'https://imgd.aeplcdn.com/1280x720/n/cw/ec/43482/sp-125-right-side-view-3.jpeg?isig=0'),
                _buildBikeCard('Hero Splendor', '₹ 77,000 - 85,000*', 'https://imgd.aeplcdn.com/1280x720/n/cw/ec/15109/splendor-plus-right-side-view-2.png?isig=0'),
                _buildBikeCard('TVS Apache', '₹ 1.20 - 1.35 Lakh*', 'https://imgd.aeplcdn.com/1056x594/n/bw/models/colors/tvs-select-model-glossy-black-be-1718781206746.png?q=80'),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'View All Commuter Bikes',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.red, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBikeCard(String name, String price, String image) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {},
              ),
            ),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
            ),
          ),
          SizedBox(height: 40),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 40),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 40),
          Text(
            'View July Offers',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  //widgets

  Widget _buildPopularBrands() {
    final brands = [
      {'name': 'Honda', 'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1AJpoiGjTzQtp5VT3ttYre6hyOwrNGAlF0w&s'},
      {'name': 'Royal Enfield', 'logo': 'https://www.shutterstock.com/image-vector/logo-british-motorcyle-called-royal-260nw-2433567443.jpg'},
      {'name': 'TVS', 'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRO_W758ZKmSRhm9pDlOZdc_lOZbLMNxDxLeQ&s'},
      {'name': 'Yamaha', 'logo': 'https://m.media-amazon.com/images/I/41Ho+Om5PWL.jpg'},
      {'name': 'Hero', 'logo': 'https://cdn.iconscout.com/icon/free/png-256/free-hero-logo-icon-download-in-svg-png-gif-file-formats--bike-automobile-indian-companies-pack-logos-icons-2249162.png'},
      {'name': 'Bajaj', 'logo': 'https://media.licdn.com/dms/image/v2/C5112AQHpBRc8QaFvBg/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1558344670455?e=2147483647&v=beta&t=XlRROayhD6vcsnauwreSKpnlElfq4r2UpKhgrqRzY98'},
      {'name': 'KTM', 'logo': 'https://static.wixstatic.com/media/c684ef_897cdf2ae4eb477b9353dabc36067c80~mv2.png'},
      {'name': 'Kawasaki', 'logo': 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Kawasaki_Frontale_former_logo.gif'},
      {'name': 'BMW', 'logo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQccV-_FCo_OCr4fPGbt3Bzy6gCiDUPkoJgw&s'},
    ];

    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Brands',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return Column(
                children: [
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(brand['logo'] as String),
                        fit: BoxFit.cover,
                        onError: (error, stackTrace) {},
                      ),
                    ),
                    child: Image.network(
                      brand['logo'] as String,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator(strokeWidth: 2));
                      },
                      errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, size: 30, color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    brand['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'View All Brands',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.red, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildElectricZone() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Electric Zone',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildElectricBikeCard('Ultraviolette F77', '₹ 2.99 - 3.99 Lakh*', 'https://imgd.aeplcdn.com/1200x900/n/cw/ec/175595/f77-mach-2-right-side-view-12.png?isig=0'),
                _buildElectricBikeCard('Revolt RV400', '₹ 1.20 - 1.35 Lakh*', 'https://imgd.aeplcdn.com/1280x720/n/cw/ec/40710/rv-400-right-side-view-12.png?isig=0'),
                _buildElectricBikeCard('Odysse Evoqis', '₹ 1.45 - 1.80 Lakh*', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFhKI58JqFb0GPlfIFV4b60r2iA0ymDuAjDg&s'),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'View All Electric Bikes',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.red, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildElectricBikeCard(String name, String price, String image) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {},
                  ),
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Electric',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'View July Offers',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestBikes() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest Bikes & Scooters',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildBikeCard('Aprilia SR 125 hp.e', '₹ 1.22 Lakh*', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqDP3ritCpYk_I9BLeQXPvcbKh_iX2Ti7e5A&s'),
                _buildBikeCard('Honda Activa 6G', '₹ 75,000 - 82,000*', 'https://imgd.aeplcdn.com/1280x720/n/cw/ec/44686/activa-6g-right-side-view-3.png?isig=0'),
                _buildBikeCard('TVS Jupiter', '₹ 65,000 - 72,000*', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeFb6bBKJuPe5A1lXXc8VQ90EFz2lbjOlWAQ&s'),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Latest Bikes',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.red, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingBikes() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Bikes & Scooters',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildUpcomingBikeCard('Xtreme 125r', '₹ 1 Lakh* Estimated Price', 'https://images.tractorjunction.com/COBALT_BLUE_1_591bd197c8.png?format=webp&quality=40'),
                _buildUpcomingBikeCard('2025 Bajaj Pulsar NS200', '₹ 2.5 Lakh* Estimated', 'https://imgd.aeplcdn.com/1280x720/n/cw/ec/58025/pulsar-ns-right-side-view-9.png?isig=0'),
                _buildUpcomingBikeCard('Hero Electric', '₹ 1.8 Lakh* Estimated', 'https://imgd.aeplcdn.com/1280x720/bw/models/hero-electric-optima-lead-acid20210511154426.jpg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🟢 Featured Bike Carousel Widget
  Widget _FeaturedBikeCarousel() {
    return _FeaturedBikeCarouselStateful();
  }

  Widget _buildUpcomingBikeCard(String name, String price, String image) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {},
                  ),
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Alert Me When Launched',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome to RideRight',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem('Bikes', Icons.motorcycle, [
            'Commuter Bikes',
            'Sports Bikes',
            'Cruiser Bikes',
            'Adventure Bikes',
            'Naked Bikes',
          ]),
          _buildDrawerItem('Scooters', Icons.directions_bike, [
            'Electric Scooters',
            'Petrol Scooters',
          ]),
          _buildDrawerItem('Electric Zone', Icons.electric_car, [
            'Electric Bikes',
            'Electric Scooters',
            'Charging Stations',
          ]),
          _buildDrawerItem('Used Bikes', Icons.history, []),
          _buildDrawerItem('Sell Bike', Icons.sell, []),
          _buildDrawerItem('Offers', Icons.local_offer, []),
          _buildDrawerItem('Compare Bikes', Icons.compare, []),
          _buildDrawerItem('News', Icons.article, []),
          _buildDrawerItem('Videos', Icons.video_library, []),
          _buildDrawerItem('User Reviews', Icons.rate_review, []),
          _buildDrawerItem('On-Road Price', Icons.attach_money, []),
          _buildDrawerItem('Dealers', Icons.store, []),
          _buildDrawerItem('Service Centers', Icons.build, []),
          _buildDrawerItem('About', Icons.info, []),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, List<String> subItems) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      children: subItems.map((item) => ListTile(
        title: Text(item),
        leading: SizedBox(width: 20),
        onTap: () {},
      )).toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 0:
            // Already on home
            break;
          case 1:
            Navigator.pushNamed(context, '/compare');
            break;
          case 2:
            Navigator.pushNamed(context, '/dealers');
            break;
          case 3:
            Navigator.pushNamed(context, '/account');
            break;
          case 4:
            Navigator.pushNamed(context, '/more');
            break;
        }
      },
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.compare), label: 'Compare'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Dealers'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
      ],
    );
  }
}

// 🟢 Featured Bike Carousel Stateful Widget
class _FeaturedBikeCarouselStateful extends StatefulWidget {
  @override
  _FeaturedBikeCarouselState createState() => _FeaturedBikeCarouselState();
}

class _FeaturedBikeCarouselState extends State<_FeaturedBikeCarouselStateful> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _featuredBikes = [
    {
      'title': 'LAUNCHED',
      'bikeName': 'YAMAHA R1M',
      'image': 'assets/images/R1m-removebg-preview.png',
    },
    {
      'title': 'NEW ARRIVAL',
      'bikeName': 'BMW S1000RR',
      'image': 'assets/images/bmw_s1000rr-removebg-preview.png',
    },
    {
      'title': 'FEATURED',
      'bikeName': 'DUCATI PANIGALE V4',
      'image': 'assets/images/ducati-removebg-preview.png',
    },
    {
      'title': 'POPULAR',
      'bikeName': 'NINJA ZX10R',
      'image': 'assets/images/ninja-removebg-preview.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _featuredBikes.length - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _featuredBikes.length,
            itemBuilder: (context, index) {
              return _buildBikeSlide(_featuredBikes[index]);
            },
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _featuredBikes.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.red : Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBikeSlide(Map<String, dynamic> bike) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bike['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  bike['bikeName'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Know More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.red, size: 16),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              bike['image'],
              height: 175,
              fit: BoxFit.contain,
            ),
          ),
        ],
     ),
);
}
}

// 🟢 Compare Screen
class CompareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compare Bikes')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.compare, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Compare Bikes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Select bikes to compare features and specifications',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// 🟢 Dealers Screen
class DealersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dealers')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Find Dealers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Locate authorized dealers near you',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// 🟢 Account Screen
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'My Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Manage your profile and preferences',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// 🟢 More Screen
class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('More')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.more_horiz, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'More Options',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Additional features and settings',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}