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
    "Getting new stories..": {
      "en_us": "Getting new stories..",
      "vi_vi": "Đang tải truyện mới..",
    },
    "Cancel": {
      "en_us": "Cancel",
      "vi_vi": "Hủy",
    },
    "Sync your data": {
      "en_us": "Sync your data",
      "vi_vi": "Đồng bộ dữ liệu",
    },
    "Log out": {
      "en_us": "Log out",
      "vi_vi": "Đăng xuất",
    },
    "Account": {
      "en_us": "Account",
      "vi_vi": "Tài khoản",
    },
    "User": {
      "en_us": "User",
      "vi_vi": "Người dùng",
    },
    "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices": {
      "en_us": "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices",
      "vi_vi": "Đăng nhập để đồng bộ dữ liệu giữa các thiết bị của bạn",
    },
    "Continue with Google": {
      "en_us": "Continue with Google",
      "vi_vi": "Tiếp tục với Google",
    },
    "Feedbacks": {
      "en_us": "Feedbacks",
      "vi_vi": "Góp ý",
    },
    "Language Updated": {
      "en_us": "Language Updated",
      "vi_vi": "Cập nhật ngôn ngữ",
    },
    "Diccon will update new language setting in the next time you open.": {
      "en_us": "Diccon will update new language setting in the next time you open.",
      "vi_vi": "Thay đổi cài đặt ngôn ngữ sẽ có hiệu lực trong lần khởi động ứng dụng tiếp theo.",
    },
    "Common Section": {
      "en_us": "Common Section",
      "vi_vi": "Cài đặt chung",
    },
    "Language": {
      "en_us": "Language",
      "vi_vi": "Ngôn ngữ",
    },
    "Select a language": {
      "en_us": "Select a language",
      "vi_vi": "Chọn một ngôn ngữ",
    },
    "Recent topics": {
      "en_us": "Recent topics",
      "vi_vi": "Chủ đề gần đây",
    },

    "Bookmarks is empty": {
      "en_us": "Bookmarks is empty",
      "vi_vi": "Bookmarks trống",
    },
    "From the universe": {
      "en_us": "From the universe",
      "vi_vi": "Dành riêng cho bạn",
    },

    "Reinforce": {
      "en_us": "Reinforce",
      "vi_vi": "Reinforce",
    },
    "your": {
      "en_us": "your",
      "vi_vi": "your",
    },
    "knowledge": {
      "en_us": "knowledge",
      "vi_vi": "knowledge",
    },
    "Guid": {
      "en_us": "Guid",
      "vi_vi": "Chỉ dẫn",
    },
    "We recognize that application quality is crucial for customer satisfaction. Your feedback is greatly appreciated and drives ongoing improvements for our valued customers.":
        {
      "en_us":
          "We recognize that application quality is crucial for customer satisfaction. Your feedback is greatly appreciated and drives ongoing improvements for our valued customers.",
      "vi_vi":
          "Chúng tôi nhận thấy rằng chất lượng ứng dụng rất quan trọng để đảm bảo sự hài lòng của khách hàng. Những phản hồi của bạn là nhân tố quan trọng và là động lực để chúng tôi liên tục cải thiện sản phẩm và dịch vụ của mình.",
    },
    "Give feedbacks": {
      "en_us": "Give feedbacks",
      "vi_vi": "Gửi phản hồi",
    },
    "You're studying": {
      "en_us": "You're studying",
      "vi_vi": "You're studying",
    },
    "the subject of": {
      "en_us": "the subject of",
      "vi_vi": "the subject of",
    },
    "Tips": {
      "en_us": "Tips",
      "vi_vi": "Mẹo nhỏ",
    },
    "Read whenever possible.": {
      "en_us": "Read whenever possible.",
      "vi_vi": "Đọc mọi lúc mọi nơi.",
    },
    "Write down new words.": {
      "en_us": "Write down new words.",
      "vi_vi": "Viết từ mới ra giấy.",
    },
    "Vocally practice new words.": {
      "en_us": "Vocally practice new words.",
      "vi_vi": "Đọc thành tiếng về từ đó.",
    },
    "Visually remember words.": {
      "en_us": "Visually remember words.",
      "vi_vi": "Liên tưởng tới hình ảnh về một từ.",
    },
    "Play word games online.": {
      "en_us": "Play word games online.",
      "vi_vi": "Chơi trò chơi đố chữ luyện từ.",
    },
    "Empower": {
      "en_us": "Empower",
      "vi_vi": "Empower",
    },
    "Your English": {
      "en_us": "Your English",
      "vi_vi": "Your English",
    },
    "Proficiency": {
      "en_us": "Proficiency",
      "vi_vi": "Proficiency",
    },
    "Nothing": {
      "en_us": "Nothing",
      "vi_vi": "Nothing",
    },
    "Worth Doing": {
      "en_us": "Worth Doing",
      "vi_vi": "Worth Doing",
    },
    "Ever": {
      "en_us": "Ever",
      "vi_vi": "Ever",
    },
    "Came Easy": {
      "en_us": "Came Easy",
      "vi_vi": "Came Easy",
    },
    "Mastering 1848 core English words fosters clear communication. Enhanced vocabulary aids reading, writing, speaking, and understanding. It facilitates meaningful interactions, empowers expression, and broadens access to information and opportunities.":
        {
      "en_us":
          "Mastering 1848 core English words fosters clear communication. Enhanced vocabulary aids reading, writing, speaking, and understanding. It facilitates meaningful interactions, empowers expression, and broadens access to information and opportunities.",
      "vi_vi":
          "Nắm vững 1848 từ tiếng Anh cốt lõi sẽ thúc đẩy sự giao tiếp rõ ràng. Tăng vốn từ vựng giúp người học cải thiện khả năng đọc, viết, nói và hiểu. Việc này tạo điều kiện cho các cuộc trò chuyện mang nhiều màu sắc, tăng cường khả năng diễn đạt của người nói trong nhiều hoàn cảnh khác nhau.",
    },
    "1848 Essential English Words": {
      "en_us": "1848 Essential English Words",
      "vi_vi": "1848 Từ Tiếng Anh Thông Dụng",
    },
    "Reading Chamber": {
      "en_us": "Reading Chamber",
      "vi_vi": "Phòng đọc",
    },
    "Dictionary History": {
      "en_us": "Dictionary History",
      "vi_vi": "Lịch sử tra cứu",
    },
    "Reading History": {
      "en_us": "Reading History",
      "vi_vi": "Lịch sử phòng đọc",
    },
    "Start your journey exploring new words.": {
      "en_us": "Start your journey exploring new words.",
      "vi_vi": "Bắt đầu cuộc hành trình khám phá từ mới.",
    },
    "Revise the words you enjoy.": {
      "en_us": "Revise the words you enjoy.",
      "vi_vi": "Hồi tưởng lại những gì bạn yêu thích.",
    },
    "Other tools": {
      "en_us": "Other tools",
      "vi_vi": "Khác",
    },
    "words to learn": {
      "en_us": "words to learn",
      "vi_vi": "từ để học",
    },
    "Dictionary": {
      "en_us": "Dictionary",
      "vi_vi": "Từ điển",
    },
    "Images": {
      "en_us": "Images",
      "vi_vi": "Hình ảnh",
    },
    "Antonyms": {
      "en_us": "Antonyms",
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
      "en_us": "  Enter for lookup",
      "vi_vi": "  Nhập để tra cứu",
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
