import 'package:diccon_evo/src/presentation/presentation.dart';

extension IntExtension on int{
  Widget get height => SizedBox(height: toDouble(),);
  Widget get width => SizedBox(width: toDouble(),);
}