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
  // "": {
  // "en_us": "",
  // "vi_vi": "",
  // },

  static const _t = Translations.from("en_us", {
    /// Common
    // NoInternetBubble
    "You're not connected": {
      "en_us": "You're not connected",
      "vi_vi": "Không có kết nối mạng",
    },
    "We'd love to hear your feedback!": {
      "en_us": "We'd love to hear your feedback!",
      "vi_vi": "Bạn có thích sử dụng Diccon không?",
    },
    "Give feedbacks": {
      "en_us": "Give feedbacks",
      "vi_vi": "Gửi phản hồi",
    },
    "Later": {
      "en_us": "Later",
      "vi_vi": "Để sau",
    },
    "SubSentenceInNoInternetBubble": {
      "en_us":
          "No internet. You are not connected to the internet, or your internet connection is experiencing an issue.",
      "vi_vi":
          "Không có mạng. Bạn đang mất kết nối mạng hoặc mạng của bạn đang gặp sự cố.",
    },
    "Cancel": {
      "en_us": "Cancel",
      "vi_vi": "Hủy bỏ",
    },

    "From the universe": {
      "en_us": "From the universe",
      "vi_vi": "Dành riêng cho bạn",
    },

    "Guid": {
      "en_us": "Guid",
      "vi_vi": "Chỉ dẫn",
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

    "1848 Essential English Words": {
      "en_us": "1848 Essential English Words",
      "vi_vi": "1848 Từ Tiếng Anh Thông Dụng",
    },
    "Reading Chamber": {
      "en_us": "Reading Chamber",
      "vi_vi": "Phòng đọc",
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

    "Sample text that will be displayed on Reading.": {
      "en_us": "Sample text that will be displayed on Reading.",
      "vi_vi": "Kích thước font chữ hiển thị trong mục Truyện ngắn.",
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

    /// Home

    "About": {
      "en_us": "About",
      "vi_vi": "Thông tin",
    },
    "Library": {
      "en_us": "Library",
      "vi_vi": "Thư viện",
    },
    "Search in dictionary": {
      "en_us": "Search in dictionary",
      "vi_vi": "Tra cứu từ điển",
    },
    "Feedbacks": {
      "en_us": "Feedbacks",
      "vi_vi": "Góp ý",
    },

    /// Story
    "SubSentenceInStoryList": {
      "en_us":
          "Let the magic of words transport you to realms uncharted and dreams unbound.",
      "vi_vi":
          "Hãy để phép màu của từ ngữ đưa bạn đến những miền đất chưa được khám phá và những giấc mơ không bị ràng buộc.",
    },
    "Getting new stories..": {
      "en_us": "Getting new stories..",
      "vi_vi": "Đang tải truyện mới..",
    },
    // Story Bookmark
    "Bookmark is removed": {
      "en_us": "Bookmark is removed",
      "vi_vi": "Bookmark đã được gỡ",
    },
    "Bookmark is added": {
      "en_us": "Bookmark is added",
      "vi_vi": "Bookmark đã được thêm vào",
    },
    "Bookmarks": {
      "en_us": "Bookmarks",
      "vi_vi": "Bookmarks",
    },
    "TitleBookmarkEmptyBox": {
      "en_us": "Bookmark is empty",
      "vi_vi": "Bookmark đang trống",
    },
    "SubSentenceInBookmarkEmptyList": {
      "en_us":
          "You can bookmark your favorite books here, allowing you to revisit them at your convenience.",
      "vi_vi":
          "Bạn có thể lưu giữ nhưng mẩu truyện mà mình yêu thích ở đây. Để thi thoảng ghé vào đọc lại.",
    },
    // Story History
    "SubSentenceInStoryHistory": {
      "en_us": "History is shaped by your actions.",
      "vi_vi": "Lịch sử được viết nên bởi chính bạn.",
    },
    "SubSentenceInWordHistory": {
      "en_us": "You're the one shaping history !",
      "vi_vi": "Bạn là người viết nên lịch sử !",
    },

    /// Dictionary

    "SubWordInDictionaryWelcomeBox": {
      "en_us":
          "Learning vocabulary can be quite challenging, but when you overcome the fear of new words, you'll unlock the door to a new language.",
      "vi_vi":
          "Sẽ khá khó khăn trong việc ghi nhớ những từ vựng mới, nhưng bằng sự nỗ lực và kiên trì, bạn sẽ vượt qua những thử thách.",
    },
    "TitleWordInDictionaryWelcomeBox": {
      "en_us": "Word wisdom in your pocket",
      "vi_vi": "Tra cứu với những tùy chọn của riêng bạn",
    },
    "Customize your experience": {
      "en_us": "Customize your experience",
      "vi_vi": "Tùy chỉnh",
    },
    "Custom": {
      "en_us": "Custom",
      "vi_vi": "Tùy chỉnh",
    },
    "Set as default format": {
      "en_us": "Set as default format",
      "vi_vi": "Đặt làm mẫu trả lời mặc định",
    },

    /// Conversation
    "Send a message for practice": {
      "en_us": "Send a message for practice",
      "vi_vi": "Viết để mở đầu cuộc trò chuyện",
    },
    "Ask me anything": {
      "en_us": "Ask me anything",
      "vi_vi": "Hỏi đáp với",
    },
    "This practice will prepare you for various real-life conversation scenarios.":
        {
      "en_us":
          "This practice will prepare you for various real-life conversation scenarios.",
      "vi_vi":
          "Chuẩn bị cho bạn kĩ năng đối thoại trong nhiều tình huống khác nhau.",
    },
    "Enhance your communication skills with our advanced bot.": {
      "en_us": "Enhance your communication skills with our advanced bot.",
      "vi_vi": "Cải thiện kĩ năng giao tiếp với Diccon Chat-bot.",
    },
    "Conversation": {
      "en_us": "Conversation",
      "vi_vi": "Trò chuyện",
    },

    "essential sentences to master": {
      "en_us": "essential sentences to master",
      "vi_vi": "câu thoại thường dùng",
    },
    "stories to read": {
      "en_us": "stories to read",
      "vi_vi": "truyện ngắn",
    },
    "For all levels and audiences": {
      "en_us": "For all levels and audiences",
      "vi_vi": "Cho mọi trình độ và lứa tuổi",
    },
    "Boost your English communication skills with 939 invaluable phrases": {
      "en_us":
          "Boost your English communication skills with 939 invaluable phrases",
      "vi_vi":
          "Cải thiện kĩ năng giao tiếp với 939 câu thoại hay trong Tiếng Anh",
    },

    /// Settings
    "Sync your data": {
      "en_us": "Sync your data",
      "vi_vi": "Đồng bộ dữ liệu",
    },
    "Privacy Policy": {
      "en_us": "Privacy Policy",
      "vi_vi": "Điều khoản",
    },
    "Continue without login": {
      "en_us": "Continue without login",
      "vi_vi": "Tiếp tục mà không đăng nhập",
    },
    "Sync": {
      "en_us": "Sync",
      "vi_vi": "Đồng bộ hóa",
    },
    "Erase all": {
      "en_us": "Erase all",
      "vi_vi": "Xóa tất cả",
    },
    "Delete all your data on cloud.": {
      "en_us": "Delete all your data on cloud.",
      "vi_vi": "Xóa tất cả dữ liệu trực tuyến của bạn.",
    },
    "(This process once fired will never be undone. Please take it serious.)": {
      "en_us":
          "(This process once fired will never be undone. Please take it serious.)",
      "vi_vi":
          "(Không thể khôi phục dữ liệu sau khi xóa, vui lòng cân nhắc trước khi thực hiện.)",
    },
    "Settings": {
      "en_us": "Settings",
      "vi_vi": "Cài đặt",
    },
    "Dictionary Section": {
      "en_us": "Dictionary Section",
      "vi_vi": "Từ điển",
    },

    "Reading Section": {
      "en_us": "Reading Section",
      "vi_vi": "Truyện ngắn",
    },
    "* The changes will become effective the next time you open the app.": {
      "en_us":
          "* The changes will become effective the next time you open the app.",
      "vi_vi":
          "* Những thay đổi sẽ có hiệu lực vào lần tiếp theo bạn mở ứng dụng.",
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
    "Number of synonyms": {
      "en_us": "Number of synonyms",
      "vi_vi": "Số từ đồng nghĩa",
    },
    "Number of antonyms": {
      "en_us": "Number of antonyms",
      "vi_vi": "Số từ trái nghĩa",
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
    "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices":
        {
      "en_us":
          "Log in to get the most out of Diccon Evo and enjoy data synchronous across your devices",
      "vi_vi": "Đăng nhập để đồng bộ dữ liệu giữa các thiết bị của bạn",
    },
    "Continue with Google": {
      "en_us": "Continue with Google",
      "vi_vi": "Tiếp tục với Google",
    },
    "Light mode": {
      "en_us": "Light",
      "vi_vi": "Sáng",
    },
    "Dark mode": {
      "en_us": "Dark",
      "vi_vi": "Tối",
    },
    "Adaptive": {
      "en_us": "Adaptive",
      "vi_vi": "Tự động",
    },
    "Theme": {
      "en_us": "Theme",
      "vi_vi": "Giao diện",
    },
    "Customize dictionary responses": {
      "en_us": "Customize dictionary responses",
      "vi_vi": "Tùy chỉnh câu trả lời/ phản hồi",
    },
    "Customize": {
      "en_us": "Customize",
      "vi_vi": "Tùy chỉnh",
    },

    /// Essential
    "School-supplies": {
      "en_us": "School-supplies",
      "vi_vi": "Vật dụng học tập",
    },
    "Start your journey exploring new words.": {
      "en_us": "Start your journey exploring new words.",
      "vi_vi": "Bắt đầu cuộc hành trình khám phá từ mới.",
    },
    "Revise the words you enjoy.": {
      "en_us": "Revise the words you enjoy.",
      "vi_vi": "Hồi tưởng lại những gì bạn yêu thích.",
    },
    "Recent topics": {
      "en_us": "Recent topics",
      "vi_vi": "Chủ đề gần đây",
    },
    "SubSentenceInEssentialWord": {
      "en_us":
          "Mastering 1848 core English words fosters clear communication. Enhanced vocabulary aids reading, writing, speaking, and understanding. It facilitates meaningful interactions, empowers expression, and broadens access to information and opportunities.",
      "vi_vi":
          "Nắm vững 1848 từ tiếng Anh cốt lõi sẽ thúc đẩy sự giao tiếp rõ ràng. Tăng vốn từ vựng giúp người học cải thiện khả năng đọc, viết, nói và hiểu. Việc này tạo điều kiện cho các cuộc trò chuyện mang nhiều màu sắc, tăng cường khả năng diễn đạt của người nói trong nhiều hoàn cảnh khác nhau.",
    },
    "Actions": {
      "en_us": "Actions",
      "vi_vi": "Hành động",
    },
    "Everyday activities": {
      "en_us": "Everyday activities",
      "vi_vi": "Hoạt động hàng ngày",
    },
    "Sea": {
      "en_us": "Sea",
      "vi_vi": "Biển",
    },
    "The number": {
      "en_us": "The number",
      "vi_vi": "Số",
    },
    "Shopping": {
      "en_us": "Shopping",
      "vi_vi": "Mua sắm",
    },
    "Bedroom": {
      "en_us": "Bedroom",
      "vi_vi": "Phòng ngủ",
    },
    "Friendship": {
      "en_us": "Friendship",
      "vi_vi": "Tình bạn",
    },
    "Kitchen": {
      "en_us": "Kitchen",
      "vi_vi": "Nhà bếp",
    },
    "Jewelry": {
      "en_us": "Jewelry",
      "vi_vi": "Trang sức",
    },
    "Environment": {
      "en_us": "Environment",
      "vi_vi": "Môi trường",
    },
    "Living room": {
      "en_us": "Living room",
      "vi_vi": "Phòng khách",
    },
    "Hospital": {
      "en_us": "Hospital",
      "vi_vi": "Bệnh viện",
    },
    "Computer": {
      "en_us": "Computer",
      "vi_vi": "Máy tính",
    },
    "Housework": {
      "en_us": "Housework",
      "vi_vi": "Việc nhà",
    },
    "The shops": {
      "en_us": "The shops",
      "vi_vi": "Cửa hàng",
    },
    "Entertainment": {
      "en_us": "Entertainment",
      "vi_vi": "Giải trí",
    },
    "Traveling": {
      "en_us": "Traveling",
      "vi_vi": "Du lịch",
    },
    "Hometown": {
      "en_us": "Hometown",
      "vi_vi": "Quê hương",
    },
    "Mid-autumn": {
      "en_us": "Mid-autumn",
      "vi_vi": "Tết Trung thu",
    },
    "Wedding": {
      "en_us": "Wedding",
      "vi_vi": "Đám cưới",
    },
    "Airport": {
      "en_us": "Airport",
      "vi_vi": "Sân bay",
    },
    "Health": {
      "en_us": "Health",
      "vi_vi": "Sức khỏe",
    },
    "Vegetable": {
      "en_us": "Vegetable",
      "vi_vi": "Rau cải",
    },
    "Transport": {
      "en_us": "Transport",
      "vi_vi": "Giao thông",
    },
    "Time": {
      "en_us": "Time",
      "vi_vi": "Thời gian",
    },
    "Emotions": {
      "en_us": "Emotions",
      "vi_vi": "Tình cảm",
    },
    "Character": {
      "en_us": "Character",
      "vi_vi": "Tính cách",
    },
    "Drinks": {
      "en_us": "Drinks",
      "vi_vi": "Đồ uống",
    },
    "Flowers": {
      "en_us": "Flowers",
      "vi_vi": "Hoa",
    },
    "Movies": {
      "en_us": "Movies",
      "vi_vi": "Phim ảnh",
    },
    "Soccer": {
      "en_us": "Soccer",
      "vi_vi": "Bóng đá",
    },
    "Christmas": {
      "en_us": "Christmas",
      "vi_vi": "Giáng sinh",
    },
    "Foods": {
      "en_us": "Foods",
      "vi_vi": "Thực phẩm",
    },
    "Sport": {
      "en_us": "Sport",
      "vi_vi": "Thể thao",
    },
    "Music": {
      "en_us": "Music",
      "vi_vi": "Âm nhạc",
    },
    "Love": {
      "en_us": "Love",
      "vi_vi": "Tình yêu",
    },
    "Restaurant-Hotel": {
      "en_us": "Restaurant-Hotel",
      "vi_vi": "Nhà hàng-Khách sạn",
    },
    "School": {
      "en_us": "School",
      "vi_vi": "Trường học",
    },
    "Colors": {
      "en_us": "Colors",
      "vi_vi": "Màu sắc",
    },
    "Weather": {
      "en_us": "Weather",
      "vi_vi": "Thời tiết",
    },
    "Clothes": {
      "en_us": "Clothes",
      "vi_vi": "Quần áo",
    },
    "Body parts": {
      "en_us": "Body parts",
      "vi_vi": "Bộ phận cơ thể",
    },
    "Education": {
      "en_us": "Education",
      "vi_vi": "Giáo dục",
    },
    "Family": {
      "en_us": "Family",
      "vi_vi": "Gia đình",
    },
    "Fruits": {
      "en_us": "Fruits",
      "vi_vi": "Trái cây",
    },
    "Animal": {
      "en_us": "Animal",
      "vi_vi": "Động vật",
    },
    "Insect": {
      "en_us": "Insect",
      "vi_vi": "Côn trùng",
    },
    "Study": {
      "en_us": "Study",
      "vi_vi": "Học tập",
    },
    "Plants": {
      "en_us": "Plants",
      "vi_vi": "Cây cỏ",
    },
    "Country": {
      "en_us": "Country",
      "vi_vi": "Quốc gia",
    },
    "Seafood": {
      "en_us": "Seafood",
      "vi_vi": "Hải sản",
    },
    "Energy": {
      "en_us": "Energy",
      "vi_vi": "Năng lượng",
    },
    "Jobs": {
      "en_us": "Jobs",
      "vi_vi": "Công việc",
    },
    "Diet": {
      "en_us": "Diet",
      "vi_vi": "Chế độ ăn uống",
    },
    "Natural disaster": {
      "en_us": "Natural disaster",
      "vi_vi": "Thảm họa tự nhiên",
    },
    "Asking the way": {
      "en_us": "Asking the way",
      "vi_vi": "Hỏi đường",
    },
    "A hotel room": {
      "en_us": "A hotel room",
      "vi_vi": "Một phòng khách sạn",
    },
    "At the post office": {
      "en_us": "At the post office",
      "vi_vi": "Tại bưu điện",
    },
    "At the bank": {
      "en_us": "At the bank",
      "vi_vi": "Tại ngân hàng",
    },
  });

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);
}
