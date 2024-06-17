import 'package:diccon_evo/src/core/enum/sex.dart';

Sex sexDetectorByName(String name){
  final femaleNameList = ['Rachel','Sarah','Emily','Emma','Rachel'];
  final maleNameList = ['David','Mark','Alex','Michael'];
  if (femaleNameList.contains(name)) return Sex.women;
  if (maleNameList.contains(name)) return Sex.men;
  return Sex.men;
}