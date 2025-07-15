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
                      Text('• Contemptor Dreadnaughts to have WS5'),
                      SizedBox(height: 8),
                      Text('• Deredeo Dreadnaughts to have BS5'),
                      SizedBox(height: 8),
                      Text('• Leviathan Dreadnaughts to have WS5 and BS5'),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // 2.0 House Rules Section
                Text(
                  '2.0 House Rules (Includes rules taken from SNBR)',
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
                      Text('• Kings Must Play Fair: Players may not bring a model with the Primarch Keyword unless both players agree to bring a model with the Primarch Keyword'),
                      SizedBox(height: 8),
                      Text('• Skew Sucks: Rites of war which generate “Skew” (ie: take Elite, Heavy Support, or Fast Attack options as Troops) do not have that effect. You may still benefit from the Rite of War providing the Line Subtype and any other effects, but the units must be taken in their associated Force Org slot and cannot be taken as Troops.  -- This rule is inverted for Legion Specific RoW’s.  You may take the non-Troop unit in the Troops slot, and it may be Compulsory if the RoW allows for that, but those units do NOT benefit from the Line Sub-type.  '),
                      SizedBox(height: 8),
                      Text('• No Deathballs!: Players are limited to the minimum unit size of Legion Specific Units.  Exception: Retinue units that have a minimum unit size lower than 5, may still take up to 5 models in that unit.  '),
                      SizedBox(height: 8),
                      Text('• Players are limited to the minimum unit size of Heavy Support Squads'),
                      SizedBox(height: 8),
                      Text('• SN: Dreads are limited to 1 per 1,000 Points'),
                      SizedBox(height: 8),
                      Text('• SN: Artificer Armor - Limit # of 2+ Saves to Initiative of Squad - Only affects AA when it’s paid for, not when it’s native to a unit'),
                      SizedBox(height: 8),
                      Text('• SN: Combat Spill Over - Only Independent Characters can issue challenges (or Special Rules like Chosen Warriors), Wounds spill over from combat (ie: if a Primarch nukes some lowly Consul, the wounds continue to spill into the squad).  If you deny a challenge, your squad does not benefit from any of your special rules or other effects the Leader was giving them.'),
                      SizedBox(height: 8),
                      Text('• SN: Lasting Templates - Just mark the units as being on Difficult Terrain, and don’t put down the template until nothing would need to be moved to do so.'),
                      SizedBox(height: 8),
                      Text('• SN: Deep Strike - Models must arrive within 4” of the “initial model” placed. (5” if more than 10 models)'),
                      SizedBox(height: 8),
                      Text('• SN: Heavy Support - Each heavy support squad is limited to 1 unit per Weapon Selection '),
                      SizedBox(height: 8),
                      Text('• SN: Iron Warriors Siege Tyrants and Iron Havocs are limited to 1 unit'),
                      SizedBox(height: 8),
                      Text('• SN: Mechanicum are limited to 1 unit of Myrmidon Secutors OR Myrmidon Destructors (up to unit size of 5)'),
                      SizedBox(height: 8),
                      Text('• SN: Iron Hands Grav Moritats are limited to 1 unit'),
                      SizedBox(height: 8),
                      Text('• SN: Imperial Fist Phalanx Warders are limited to 0-2 units'),
                      SizedBox(height: 8),
                      Text('• SN: Daemons of the Ruinstorm are limited to 0-2 units of Sovereigns'),
                      SizedBox(height: 8),
                      Text('• SN: Paragon Thanatar Calix gain 5+ Precision Shot instead of normal Sniping Rules')
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



