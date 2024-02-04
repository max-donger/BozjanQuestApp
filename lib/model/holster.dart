import 'package:flutter/material.dart';
import 'actions.dart';

class Holster {
  final int id;
  final String title;
  final IconData? icon;
  final String discord;
  final String zone;
  final String role; // Unable to name it class
  final int rank;
  final List<List<LostAction>> actions;
  // job, multi selectable;
  // tag, multi selectable;

  Holster({
    required this.id,
    required this.title,
    required this.icon,
    required this.discord,
    required this.zone,
    required this.role,
    required this.rank,
    required this.actions,
  });
}

final List<Holster> holsterList = [
  Holster(
    id: 1,
    title: 'anyprog Tank lowrank',
    icon: Icons.shield,
    discord: 'LegoSteppers',
    zone: 'drs',
    role: 'tank',
    rank: 15,
    actions: prePopActions1,
  ),
  Holster(
    id: 2,
    title: 'anyprog DPS lowrank',
    icon: Icons.assist_walker,
    discord: 'LegoSteppers',
    zone: 'drs',
    role: 'dps',
    rank: 15,
    actions: prePopActions1,
  ),
  Holster(
    id: 3,
    title: 'anyprog Healer lowrank',
    icon: Icons.healing,
    discord: 'LegoSteppers',
    zone: 'drs',
    role: 'healer',
    rank: 15,
    actions: prePopActions1,
  ),
  Holster(
    id: 4,
    title: 'anyprog Healer highrank',
    icon: Icons.medical_information,
    discord: 'LegoSteppers',
    zone: 'drs',
    role: 'healer',
    rank: 25,
    actions: prePopActions1,
  ),
  Holster(
    id: 5,
    title: 'Max Piggy BLM',
    icon: Icons.medical_information,
    discord: 'BozjaHelp',
    zone: 'drs',
    role: 'dps',
    rank: 25,
    actions: prePopActions1,
  ),
];

/*
title
  any description
  not used in filter
icon
  any IconData https://fonts.google.com/icons
  not used in filter

zone
  bsf / zadnor / cll / dal / drn / drs
  limit 1, must match one

rank
  1-25
  limit 1, must match exact

job
  PLD...BLM
  multi-select, must match one unless none chosen, then show all

tag
  anyprog / reclear / other / cluster farm / reflect farm
  multi-select, must match one unless none chosen, then show all

action
  1..99 (Lost Focus..Resistance Elixer)
  not used in filter, could also just link to an image for now
*/

/// discord
///  ABBA, CAFE, LegoSteppers, PEBE, BozjaHelp
///  limit 1, must match exact
final List<String> discords = [
  'ABBA',
  'BozjaHelp',
  'CAFE',
  'LegoSteppers',
  'PEBE',
];

/// role
///   tank / dps / healer
///  multi-select, must match one unless none chosen, then show all
final List<String> roles = [
  'tank',
  'dps',
  'healer',
];
