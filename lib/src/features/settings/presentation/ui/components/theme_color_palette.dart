import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
class ColorPaletteSelector {
  Color selectedColor;
  Color onHover;
  ColorPaletteSelector({required this.selectedColor, required this.onHover});
  ColorPaletteSelector copyWith({Color? selectedColor, Color? onHover}) {
    return ColorPaletteSelector(
        selectedColor: selectedColor ?? this.selectedColor,
        onHover: onHover ?? this.onHover);
  }
}

class ThemeColorPalette extends StatefulWidget {
  const ThemeColorPalette({
    super.key,
  });

  @override
  State<ThemeColorPalette> createState() => _ThemeColorPaletteState();
}

class _ThemeColorPaletteState extends State<ThemeColorPalette> {
  final _selectController = StreamController<ColorPaletteSelector>();
  var _colorPaletteSelector = ColorPaletteSelector(
      selectedColor: Color(Properties.defaultSetting.themeColor),
      onHover: Colors.black54);
  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft, child: Text("Accent color".i18n)),
        const VerticalSpacing.small(),
        StreamBuilder<ColorPaletteSelector>(
          stream: _selectController.stream,
          initialData: _colorPaletteSelector,
          builder: (context, selectedColor) {
            return Wrap(
              spacing: 3,
              runSpacing: 3,
              alignment: WrapAlignment.center,
              children: [
                Colors.red,
                Colors.pinkAccent,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.teal,
                Colors.blueAccent,
                Colors.purple,
                Colors.brown,
                Colors.blueGrey,
                Colors.lime,
                Colors.grey
              ].map((currentColor) {
                return InkWell(
                  onTap: () {
                    _colorPaletteSelector = _colorPaletteSelector.copyWith(
                        selectedColor: currentColor);
                    _selectController.add(_colorPaletteSelector);
                    settingBloc.add(ChangeThemeColorEvent(color: currentColor));
                  },
                  onHover: (isHover) {
                    _colorPaletteSelector =
                        _colorPaletteSelector.copyWith(onHover: currentColor);
                    _selectController.add(_colorPaletteSelector);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: currentColor,
                          border: selectedColor.data?.onHover.value ==
                                  currentColor.value
                              ? Border.all(
                                  color: Colors.white,
                                  width: 3,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      if (selectedColor.data?.selectedColor.value ==
                          currentColor.value)
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
        const VerticalSpacing.large(),
        FilledButton.tonal(
            onPressed: () {
              settingBloc.add(EnableAdaptiveThemeColorEvent());
            },
            child: Text("Use System Theme".i18n))
      ],
    );
  }
}
