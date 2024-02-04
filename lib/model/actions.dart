import 'package:flutter/material.dart';

class LostAction extends StatelessWidget {
  final int id;
  final String name;
  final IconData? icon;
  final int weight;

  LostAction({
    required this.id,
    required this.name,
    required this.icon,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return LostAction(
      id: this.id,
      name: this.name,
      icon: this.icon,
      weight: this.weight,
    );
  }
}

// Database of Lost Actions
final List<LostAction> lostActionList = [
  LostAction(
    id: 1,
    name: 'Lost Focus',
    icon: Icons.center_focus_strong,
    weight: 6,
  ),
  LostAction(
    id: 56,
    name: 'Resistance Reraiser',
    icon: Icons.person_add,
    weight: 6,
  ),
  LostAction(
    id: 91,
    name: 'Pure Essence of the Gambler',
    icon: Icons.casino,
    weight: 6,
  ),
  LostAction(
    id: 92,
    name: 'Pure Essence of the Elder',
    icon: Icons.elderly,
    weight: 6,
  ),
  LostAction(
    id: 93,
    name: 'Pure Essence of the Duelist',
    icon: Icons.downhill_skiing,
    weight: 6,
  ),
  LostAction(
    id: 94,
    name: 'Pure Essence of the Fiendhunter',
    icon: Icons.spatial_tracking,
    weight: 6,
  ),
  LostAction(
    id: 95,
    name: 'Pure Essence of the Indomitable',
    icon: Icons.shield_moon,
    weight: 6,
  ),
  LostAction(
    id: 96,
    name: 'Pure Essence of the Divine',
    icon: Icons.support_agent,
    weight: 6,
  ),
];

/*
Quick lookup for new Ids
12  Offensive     (12)
 6  Defensive     (18)
 9  Restorative   (27)
13  Beneficial    (40)
 6  Tactical      (46)
 7  Detrimental   (53)
46  Item-related  (99) (rows are 15, so 68,83,98)
*/

// HolsterList 1 PrePop
final List<List<LostAction>> prePopActions1 = [
  [
    lostActionList.firstWhere((action) => action.id == 56),
    lostActionList.firstWhere((action) => action.id == 95)
  ],
  [
    lostActionList.firstWhere((action) => action.id == 56),
    lostActionList.firstWhere((action) => action.id == 56),
    lostActionList.firstWhere((action) => action.id == 56)
  ]
];
