import 'package:flutter/material.dart';

class HouseRulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Intro Text
                Text(
                  'House Rules',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  'These House Rules do not reflect any sort of "correct" or "mandatory" way to play Heresy. '
                  'Each rule is ad-hoc, and you can choose to or not to utilize them in your games of Heresy. '
                  'We test House Rules and, where they feel like they improve the game for us, record them here.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 32),

                // 3.0 House Rules Section
                Text(
                  '3.0 House Rules',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('• Placeholder rule for 3.0 edition.'),
                      SizedBox(height: 8),
                      Text('• Vehicles failing Dangerous Terrain lose 1 Hull Point.'),
                      SizedBox(height: 8),
                      Text('• No re-rolls allowed for Psychic Tests.'),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // 2.0 House Rules Section
                Text(
                  '2.0 House Rules',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('• Placeholder rule from 2.0.'),
                      SizedBox(height: 8),
                      Text('• You may allocate wounds before saves.'),
                      SizedBox(height: 8),
                      Text('• Units may only Overwatch once per turn.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



