import 'package:flutter/material.dart';

class FansiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  FansiteAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.person),
          tooltip: 'Account',
          onPressed: () {
            // Navigate to login/profile later
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _navButton(context, 'Home', '/'),
            _navButton(context, 'Custom Missions', '/missions'),
            _navButton(context, 'Mission Builder', '/builder'),
            _navButton(context, 'Articles', '/articles'),
            _navButton(context, 'Resource Center', '/resources'),
            _navButton(context, 'Discover App', '/discover'),
            _navButton(context, 'Community', '/community'),
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String label, String route) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
