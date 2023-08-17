import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  /// Step to localization using flutter_i18n package:
  /// 1: install package flutter_i18n and flutter_localization
  /// 2: in main.dart, setup localizationDelegates and supportedLocales:
  /// MaterialApp(
  ///       localizationsDelegates: const [
  ///         GlobalMaterialLocalizations.delegate,
  ///         GlobalWidgetsLocalizations.delegate,
  ///         GlobalCupertinoLocalizations.delegate,
  ///       ],
  ///       supportedLocales: const [
  ///         Locale('en', "US"),
  ///         Locale('vi', "VI"),
  ///       ],
  /// 3: create a extension Localization on String like this file
  /// 4: import this localization file to the target .dart file and use .i18n after the text that you want to translate.

  static const _t = Translations.from("en_us", {
    "Dictionary": {
      "en_us": "Dictionary",
      "vi_vi": "Từ điển",
    },
    "Images": {
      "en_us": "Images",
      "vi_vi": "Hình ảnh",
    },
    "Antonyms": {
      "en_us": "Images",
      "vi_vi": "Trái nghĩa",
    },
    "History": {
      "en_us": "History",
      "vi_vi": "Lịch sử",
    },
    "Reverse List": {
      "en_us": "Reverse List",
      "vi_vi": "Đảo ngược danh sách",
    },
    "Clear all": {
      "en_us": "Clear all",
      "vi_vi": "Xóa tất cả",
    },
    "Watching time": {
      "en_us": "Watching time",
      "vi_vi": "Video ngắn",
    },
    "Footnote": {
      "en_us": "Footnote",
      "vi_vi": "Ghi chú",
    },
    "Non-Footnote": {
      "en_us": "Non-Footnote",
      "vi_vi": "Không ghi chú",
    },
    "All": {
      "en_us": "All",
      "vi_vi": "Tất cả",
    },
    "Elementary": {
      "en_us": "Elementary",
      "vi_vi": "Sơ cấp",
    },
    "Intermediate": {
      "en_us": "Intermediate",
      "vi_vi": "Trung cấp",
    },
    "Advanced": {
      "en_us": "Advanced",
      "vi_vi": "Nâng cao",
    },
    "Settings": {
      "en_us": "Settings",
      "vi_vi": "Cài đặt",
    },
    "Dictionary Section": {
      "en_us": "Dictionary Section",
      "vi_vi": "Từ điển",
    },
    "Number of synonyms": {
      "en_us": "Number of synonyms",
      "vi_vi": "Số từ đồng nghĩa",
    },
    "Number of antonyms": {
      "en_us": "Number of antonyms",
      "vi_vi": "Số từ trái nghĩa",
    },
    "Reading Section": {
      "en_us": "Reading Section",
      "vi_vi": "Truyện ngắn",
    },
    "Sample text that will be displayed on Reading.": {
      "en_us": "Sample text that will be displayed on Reading.",
      "vi_vi": "Kích thước font chữ hiển thị trong mục Truyện ngắn.",
    },
    "About": {
      "en_us": "About",
      "vi_vi": "Thông tin",
    },
    "All rights reserved.": {
      "en_us": "All rights reserved.",
      "vi_vi": "Mọi quyền được bảo lưu.",
    },
    "Available at": {
      "en_us": "Availabe at",
      "vi_vi": "Đã có mặt ở",
    },
    "Select a number": {
      "en_us": "Select a number",
      "vi_vi": "Chọn một số",
    },
    "Send a message": {
      "en_us": "Enter for lookup",
      "vi_vi": "Nhập để tra cứu",
    },
    "Reading time": {
      "en_us": "Reading time",
      "vi_vi": "Truyện ngắn",
    },
    "History is empty": {
      "en_us": "History is empty",
      "vi_vi": "Lịch sử trống",
    },
    "Synonyms": {
      "en_us": "Synonyms",
      "vi_vi": "Đồng nghĩa",
    },
    "Press back again to exit": {
      "en_us": "Press back again to exit",
      "vi_vi": "Bấm trở lại lần nữa để thoát",
    },
    "Welcome to Diccon": {
      "en_us": "Welcome to Diccon",
      "vi_vi": "Diccon xin chào bạn",
    },
    "Start exploring the world of words!": {
      "en_us": "Start exploring the world of words!",
      "vi_vi": "Cùng khám phá thế giới của câu từ!",
    }
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);
}
