import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/mission_builder_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/house_rules_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(HeresyUnbound());
}

class HeresyUnbound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeresyUnbound',
      theme: ThemeData.dark(),
      home: MainNavigationShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  @override
  _MainNavigationShellState createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    _HomePage(),
    MissionBuilderPage(),
    _PlaceholderPage(title: 'Custom Missions'),
    _PlaceholderPage(title: 'Articles'),
    HouseRulesPage(),
    _PlaceholderPage(title: 'Resource Center'),
    _PlaceholderPage(title: 'Discover Heresy Challenges App'),
    _PlaceholderPage(title: 'Community'),
  ];

  final List<String> _titles = [
    'Home',
    'Custom Mission Builder',
    'Custom Missions',
    'Articles',
    'House Rules',
    'Resource Center',
    'Discover App',
    'Community',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(280),
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER ROW WITH CENTERED BANNER
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // LEFT: Logo
                      Image.asset('assets/HUColorsTRANSBGPNG.png', height: 150),
                      Spacer(),
                      // RIGHT: App Promo as vertical block
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Home of the Heresy Challenges App',
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/HCIcon512PNG.png', height: 40),
                              SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => _launchURL('https://apps.apple.com/us/app/heresy-challenges/id6748090992'),
                                child: Image.asset('assets/Appstore.png', height: 44),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _launchURL('https://play.google.com/store/apps/details?id=YOUR_PACKAGE_NAME'),
                                child: Image.asset('assets/Playstore.png', height: 44),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // CENTERED BANNER
                  Positioned(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 140),
                      child: Image.asset(
                        'assets/FullscreenFullNameTransparentPNG.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // NAVIGATION BAR
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_titles.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextButton(
                          onPressed: () => _onTabTapped(index),
                          child: Text(
                            _titles[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: index == _selectedIndex
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to HeresyUnbound',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Forge your own missions. Discover new challenges. Join the heresy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title Coming Soon',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}















