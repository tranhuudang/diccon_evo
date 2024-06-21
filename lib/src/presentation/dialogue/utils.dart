import 'package:diccon_evo/src/core/enum/sex.dart';

Sex sexDetectorByName(String name) {
  final femaleNameList = ['Rachel', 'Sarah', 'Emily', 'Emma', 'Rachel', 'Lisa'];
  final maleNameList = [
    'David',
    'Mark',
    'Alex',
    'Michael',
    'Chris',
    'Jake',
    'John',
    'Dr. Miller',
    'James',
    'Dr. Patel',
    'Dr. Thompson'
  ];
  if (femaleNameList.contains(name)) return Sex.women;
  if (maleNameList.contains(name)) return Sex.men;
  return Sex.men;
}
