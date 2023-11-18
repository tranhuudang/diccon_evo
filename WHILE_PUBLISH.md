### Update licences file
You might want to update licences file in `common/constant/licenses.dart` by the following command:
```bash
flutter pub run flutter_oss_licenses:generate.dart -o %cd%/lib/src/common/constants/licences.dart
```
### Creating an MSIX Package for Windows

To create an MSIX installer, follow these steps:

1. Make sure you have the correct version set in your `pubspec.yaml` before creating the package.

2. Open your command prompt or terminal.

3. Run the following command:

```bash
dart run msix:create
```
