import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/mission_builder_page.dart';

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
    _PlaceholderPage(title: 'Resource Center'),
    _PlaceholderPage(title: 'Discover Heresy Challenges App'),
    _PlaceholderPage(title: 'Community'),
  ];

  final List<String> _titles = [
    'Home',
    'Custom Mission Builder',
    'Custom Missions',
    'Articles',
    'Resource Center',
    'Discover App',
    'Community',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HeresyUnbound'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Add login logic later
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_titles.length, (index) {
                return TextButton(
                  onPressed: () => _onTabTapped(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      _titles[index],
                      style: TextStyle(
                        color: index == _selectedIndex ? Colors.white : Colors.grey[400],
                      ),
                    ),
                  ),
                );
              }),
            ),
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
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to HeresyUnbound',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Forge your own missions. Discover new challenges. Join the heresy.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
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
    return Center(child: Text('$title Coming Soon', style: TextStyle(fontSize: 20)));
  }
}




