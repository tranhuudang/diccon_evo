import 'package:i18n_extension/i18n_extension.dart';

extension Localization on Object {
  /// Step to localization using i18n_extension package:
  /// 1: install package i18n_extension and flutter_localization
  ///   # localization
  ///   flutter_localization: ^0.1.14
  ///   flutter_localizations:
  ///     sdk: flutter
  ///   i18n_extension: ^10.0.1
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

  static final _t = Translations.byId<Object>("en_us", {
    /// Common
    // NoInternetBubble
    // "": {
    // "en_us": "",
    // "vi_vi": "",
    // },
    // "": {
    //   "en_us": "",
    //   "vi_vi": "",
    // },
    // "": {
    //   "en_us": "",
    //   "vi_vi": "",
    // },
    "Your feedback matters! Help us improve your learning experience by sharing your thoughts. We appreciate your input and use it to make our app better for you.":
        {
      "en_us":
          "Your feedback matters! Help us improve your learning experience by sharing your thoughts. We appreciate your input and use it to make our app better for you.",
      "vi_vi":
          "Đánh giá của bạn rất quan trọng đối với chúng tôi! Hãy giúp chúng tôi cải thiện trải nghiệm học tập của bạn bằng cách chia sẻ ý kiến của bạn. Chúng tôi rất coi trọng những góp ý của bạn và sử dụng nó để làm cho ứng dụng của chúng tôi tốt hơn đối với bạn.",
    },
    "Feedback": {
      "en_us": "Feedback",
      "vi_vi": "Góp ý",
    },
    "Submit": {
      "en_us": "Submit",
      "vi_vi": "Hoàn tất",
    },
    "Send": {
      "en_us": "Send",
      "vi_vi": "Gửi đi",
    },
    "Feedback submitted successfully!": {
      "en_us": "Feedback submitted successfully!",
      "vi_vi": "Góp ý của bạn đã được gửi!",
    },
    "Rate us": {
      "en_us": "Rate us",
      "vi_vi": "Đánh giá",
    },
    "Sign up": {
      "en_us": "Sign up",
      "vi_vi": "Đăng ký",
    },
    "Don't have an account?": {
      "en_us": "Don't have an account?",
      "vi_vi": "Bạn chưa có tài khoản?",
    },
    "Continues": {
      "en_us": "Continues",
      "vi_vi": "Tiếp tục",
    },
    "Password": {
      "en_us": "Password",
      "vi_vi": "Mật khẩu",
    },
    "Introducing a cutting-edge chat-based dictionary, your instant language companion at your fingertips! Explore the world of words and definitions with ease, right in your chat window.":
        {
      "en_us":
          "Introducing a cutting-edge chat-based dictionary, your instant language companion at your fingertips! Explore the world of words and definitions with ease, right in your chat window.",
      "vi_vi":
          "Giới thiệu từ điển trò chuyện tiên tiến, người bạn đồng hành ngôn ngữ tức thì ngay trong tầm tay bạn! Khám phá thế giới từ ngữ và định nghĩa một cách dễ dàng, ngay trong cửa sổ trò chuyện của bạn.",
    },
    "You're not connected": {
      "en_us": "You're not connected",
      "vi_vi": "Không có kết nối mạng",
    },
    "Short stories in": {
      "en_us": "Short stories in",
      "vi_vi": "Học qua truyện",
    },
    "WordNotFoundInLocalDictionary": {
      "en_us":
          "Local dictionary not have this word, please swipe right/left to see AI Dictionary",
      "vi_vi":
          "Không tìm thấy định nghĩa của từ này trong từ điển offline, vuốt sang trái/ phải để dùng từ điển AI",
    },
    "We'd love to hear your feedback!": {
      "en_us": "We'd love to hear your feedback!",
      "vi_vi": "Chúng tôi rất muốn nghe phản hồi của bạn!",
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
      "en_us": "Images (BETA)",
      "vi_vi": "Hình ảnh (Thử nghiệm)",
    },
    "Antonyms": {
      "en_us": "Antonyms",
      "vi_vi": "Trái nghĩa",
    },
    "History": {
      "en_us": "History",
      "vi_vi": "Lịch sử",
    },
    "Reverse": {
      "en_us": "Reverse",
      "vi_vi": "Đảo ngược danh sách",
    },
    "Clear all": {
      "en_us": "Clear all",
      "vi_vi": "Xóa tất cả",
    },
    "Edit": {
      "en_us": "Edit",
      "vi_vi": "Chỉnh sửa",
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
      "en_us": "  Enter to look up",
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

    "Listening to you...": {
      "en_us": "Listening to you...",
      "vi_vi": "Đang lắng nghe...",
    },
    "Stories": {
      "en_us": "Stories",
      "vi_vi": "Truyện đọc",
    },
    "Open dictionary": {
      "en_us": "Open dictionary",
      "vi_vi": "Mở từ điển",
    },
    "Open conversation": {
      "en_us": "Open conversation",
      "vi_vi": "Mở trò chuyện",
    },
    "1848 Essential Words": {
      "en_us": "1848 Essential Words",
      "vi_vi": "1848 từ vựng thông dụng",
    },
    "Practice your vocabulary through simple tests. You'll find that sometimes the words you think you know are quickly forgotten.":
        {
      "en_us":
          "Practice your vocabulary through simple tests. You'll find that sometimes the words you think you know are quickly forgotten.",
      "vi_vi":
          "Ôn luyện vốn từ vựng của mình thông qua những bài kiểm tra đơn giản. Bạn sẽ thấy rằng có thể những từ bạn tưởng chừng như đã biết lại bị lãng quên thật nhanh.",
    },
    "I can even tell you a story !": {
      "en_us": "I can even tell you a story !",
      "vi_vi": "Tôi còn có thể kể cho bạn nghe một câu chuyện thú vị!",
    },
    "In the premium version, you have the opportunity to chat with an AI specialized in language learning. Ready to answer any questions you have or become a conversational companion.":
        {
      "en_us":
          "In the premium version, you have the opportunity to chat with an AI specialized in language learning. Ready to answer any questions you have or become a conversational companion.",
      "vi_vi":
          "Với phiên bản trả phí, bạn có cơ hội trò chuyện với trí tuệ nhân tạo dành riêng cho việc học ngôn ngữ. Sẵn sàng giải đáp bất kì thắc mắc nào của bạn hoặc trở thành một người bạn tâm giao.",
    },
    "Access an extensive dictionary repository offering advanced customizations tailored to best suit your needs.":
        {
      "en_us":
          "Access an extensive dictionary repository offering advanced customizations tailored to best suit your needs.",
      "vi_vi":
          "Truy cập kho từ điển phong phú với những tùy tỉnh nâng cao, phù hợp với bạn nhất.",
    },
    "Don't forget to tap on the words for translations of the passage": {
      "en_us":
          "Don't forget to tap on the words for translations of the passage.",
      "vi_vi": "Đừng quên chạm vào từ mà bạn không biết để dịch từ và câu.",
    },
    "Report Errors": {
      "en_us": "Report Errors",
      "vi_vi": "Báo lỗi",
    },
    "Learning English through stories is a proven method that is particularly effective in enhancing vocabulary and sentence structure.":
        {
      "en_us":
          "Learning English through stories is a proven method that is particularly effective in enhancing vocabulary and sentence structure.",
      "vi_vi":
          "Học tiếng Anh thông qua truyện là một trong những phương pháp học được chứng minh là đặc biệt hiệu quả để cải thiện vốn từ và cách dùng từ trong câu.",
    },
    "Here, you can discover a myriad of captivating stories tailored to various proficiency levels. Depending on your abilities, feel free to select stories that align with your learning objectives while providing entertainment.":
        {
      "en_us":
          "Here, you can discover a myriad of captivating stories tailored to various proficiency levels. Depending on your abilities, feel free to select stories that align with your learning objectives while providing entertainment.",
      "vi_vi":
          "Ở đây, bạn có thể tìm thấy hàng trăm câu chuyện thú vị với nhiều mức độ khác nhau. Tùy vào khả năng của mình, bạn hãy chọn truyện đọc phù hợp để vừa học vừa giải trí nhé.",
    },
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
    "Play story": {
      "en_us": "Play story",
      "vi_vi": "Nghe truyện",
    },
    "Often less than 10 seconds": {
      "en_us": "Often less than 10 seconds",
      "vi_vi": "Thường mất khoảng 10 giây",
    },
    "Increase": {
      "en_us": "Increase Font Size",
      "vi_vi": "Tăng phông chữ",
    },
    "Download audio": {
      "en_us": "Download audio",
      "vi_vi": "Tải âm thanh",
    },
    "Audio": {
      "en_us": "Audio",
      "vi_vi": "Âm thanh",
    },
    "Decrease": {
      "en_us": "Decrease Font Size",
      "vi_vi": "Giảm phông chữ",
    },
    "Definition": {
      "en_us": "Definition",
      "vi_vi": "Định nghĩa",
    },
    "Explanation": {
      "en_us": "Explanation",
      "vi_vi": "Giải thích",
    },
    "Suggestion": {
      "en_us": "Suggestion",
      "vi_vi": "Gợi ý",
    },
    "Find your story": {
      "en_us": "Find your story",
      "vi_vi": "Tìm câu chuyện mà bạn thích",
    },
    "No matching story found": {
      "en_us": "No matching story found",
      "vi_vi": "Không tìm thấy câu chuyện tương tự",
    },
    "Never miss out on your story ever again": {
      "en_us": "Never miss out on your story ever again",
      "vi_vi": "Bạn sẽ không bỏ lỡ câu chuyện đang dang dở",
    },
    "You can search by using title, description, contents and author of the story.":
        {
      "en_us":
          "You can search by using title, description, contents and author of the story.",
      "vi_vi":
          "Bạn có thể sử dụng từ khóa tìm kiếm từ tiêu đề, mô tả, nội dung hay tên tác giả của câu chuyện.",
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
    "Library of": {
      "en_us": "Library of",
      "vi_vi": "Truyện ngắn",
    },
    "Infinite Adventures": {
      "en_us": "Infinite Adventures",
      "vi_vi": "song ngữ",
    },

    /// Your peers
    "Your peers": {
      "en_us": "Your peers",
      "vi_vi": "Nhóm",
    },
    "Create new group": {
      "en_us": "Create new group",
      "vi_vi": "Tạo nhóm mới",
    },
    "Create": {
      "en_us": "Create",
      "vi_vi": "Tạo",
    },
    "Group Info": {
      "en_us": "Group Info",
      "vi_vi": "Thông tin nhóm",
    },
    "Info": {
      "en_us": "Info",
      "vi_vi": "Thông tin",
    },
    "Group Id": {
      "en_us": "Group Id",
      "vi_vi": "ID của nhóm",
    },
    "Group name": {
      "en_us": "Group name",
      "vi_vi": "Tên nhóm",
    },
    "Enter a name": {
      "en_us": "Enter a name",
      "vi_vi": "Nhập tên nhóm",
    },
    "Update": {
      "en_us": "Update",
      "vi_vi": "Cập nhật",
    },
    "Members": {
      "en_us": "Members",
      "vi_vi": "Thành viên",
    },
    "You": {
      "en_us": "You",
      "vi_vi": "Bạn",
    },
    "Add a new member ID": {
      "en_us": "Add a new member ID",
      "vi_vi": "Nhập ID của thành viên mới",
    },
    "Add": {
      "en_us": "Add",
      "vi_vi": "Thêm",
    },
    "member": {
      "en_us": "member",
      "vi_vi": "thành viên",
    },
    "members": {
      "en_us": "members",
      "vi_vi": "thành viên",
    },
    "Manage group": {
      "en_us": "Manage group",
      "vi_vi": "Quản lý nhóm",
    },
    "Delete Group": {
      "en_us": "Delete Group",
      "vi_vi": "Xóa nhóm",
    },
    "Add Image": {
      "en_us": "Add Image",
      "vi_vi": "Thêm ảnh",
    },
    "Add Video": {
      "en_us": "Add Video",
      "vi_vi": "Thêm video",
    },
    "Add Audio": {
      "en_us": "Add Audio",
      "vi_vi": "Thêm âm thanh",
    },
    "Add File": {
      "en_us": "Add File",
      "vi_vi": "Thêm tệp tin",
    },
    "Enter a message": {
      "en_us": "Enter a message",
      "vi_vi": "Nhập tin nhắn",
    },
    "Create Group": {
      "en_us": "Create Group",
      "vi_vi": "Tạo nhóm",
    },
    "Member IDs (comma-separated)": {
      "en_us": "Member IDs (comma-separated)",
      "vi_vi": "ID các thành viên (phân tách bởi dấu phẩy)",
    },
    "Your Id": {
      "en_us": "Your Id",
      "vi_vi": "ID của bạn",
    },
    "Join a group": {
      "en_us": "Join a group",
      "vi_vi": "Tham gia vào một nhóm",
    },
    "Group ID not found": {
      "en_us": "Group ID not found",
      "vi_vi": "Không tìm thấy ID của nhóm này",
    },
    "Join": {
      "en_us": "Join",
      "vi_vi": "Tham gia",
    },
    "Provides a list of groups you are part of. You can create new groups, join existing ones, and chat with your peers.":
        {
      "en_us":
          "List of groups you are part of. You can create new groups, join existing ones, and chat with your peers.",
      "vi_vi":
          "Danh sách các nhóm bạn đang tham gia. Bạn có thể tạo nhóm mới, tham gia các nhóm hiện có và trò chuyện với bạn bè của mình.",
    },
    "Connect with your peers through group chats.": {
      "en_us": "Connect with your peers through group chats.",
      "vi_vi": "Kết nối với bạn bè của bạn qua các cuộc trò chuyện nhóm.",
    },
    "See your groups": {
      "en_us": "See your groups",
      "vi_vi": "Xem nhóm của bạn",
    },
    "Welcome to groups, let's create your new group and share awesome things with your friends while you learn":
        {
      "en_us":
          "Welcome to groups, let's create your new group and share awesome things with your friends while you learn",
      "vi_vi":
          "Chào mừng bạn, hãy tạo nhóm mới của bạn và chia sẻ những điều tuyệt vời với bạn bè của bạn trong khi học.",
    },
    "Feel free to share your questions, ideas, and tips. We're here to learn and support each other.":
        {
      "en_us":
          "Feel free to share your questions, ideas, and tips. We're here to learn and support each other.",
      "vi_vi":
          "Hãy thoải mái chia sẻ câu hỏi, ý tưởng và mẹo học của bạn. Chúng ta ở đây để học hỏi và hỗ trợ lẫn nhau.",
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
      "vi_vi": "Tra cứu với tùy chọn của riêng bạn",
    },
    "The complexity of the response will significantly increase the time it takes for the application to reply.":
        {
      "en_us":
          "The complexity of the response will significantly increase the time it takes for the application to reply.",
      "vi_vi":
          "Mức độ phức tạp trong câu trả lời sẽ làm tăng thêm đáng kể thời gian để ứng dụng trả lời.",
    },
    "Pronunciation:": {
      "en_us": "Pronunciation:",
      "vi_vi": "Phiên âm:",
    },
    "Generate Engine": {
      "en_us": "Generate Engine",
      "vi_vi": "Bộ máy trả lời",
    },
    "Recommend": {
      "en_us": "Recommend",
      "vi_vi": "Khuyến nghị",
    },
    "in the sentence": {
      "en_us": "in the sentence",
      "vi_vi": "trong câu",
    },
    "The meaning of": {
      "en_us": "The meaning of",
      "vi_vi": "Nghĩa của từ",
    },
    "Faster but less reliable and stable.": {
      "en_us": "Faster but less reliable and stable.",
      "vi_vi": "Nhanh hơn nhưng giảm độ tin cậy và sự ổn định.",
    },
    "Slower but more accurate and precise.": {
      "en_us": "Slower but more accurate and precise.",
      "vi_vi": "Chậm hơn nhưng đúng đắn và chính xác hơn.",
    },
    "Translate word from sentence": {
      "en_us": "Translate word from sentence",
      "vi_vi": "Dịch từ trong ngữ cảnh",
    },
    "Enter sentence": {
      "en_us": "Enter sentence that contain the word",
      "vi_vi": "Nhập câu chứa từ cần dịch",
    },
    "Enter word to translate": {
      "en_us": "Enter word",
      "vi_vi": "Nhập từ",
    },
    "Capture your text": {
      "en_us": "Capture your text",
      "vi_vi": "Dịch từ hình ảnh",
    },
    "Practice your communication skills": {
      "en_us": "Practice your communication skills",
      "vi_vi": "Cải thiện kĩ năng giao tiếp",
    },
    "SubSentenceInImageRecognizer": {
      "en_us":
          "Instantly convert images into text. Scan, translate, and extract text from photos, making language barriers a thing of the past.",
      "vi_vi":
          "Chuyển đổi hình ảnh thành văn bản nhanh chóng. Quét, dịch và trích xuất văn bản từ hình ảnh, phá vỡ rào cản ngôn ngữ.",
    },
    "Auto detect language": {
      "en_us": "Auto detect language",
      "vi_vi": "Tự động nhận dạng ngôn ngữ",
    },
    "Translator options:": {
      "en_us": "Translator options:",
      "vi_vi": "Tùy chọn",
    },
    "Force translate Vietnamese to English": {
      "en_us": "Force translate Vietnamese to English",
      "vi_vi": "Dịch tiếng Việt sang tiếng Anh",
    },
    "Force translate English to Vietnamese": {
      "en_us": "Force translate English to Vietnamese",
      "vi_vi": "Dịch tiếng Anh sang tiếng Việt",
    },
    "Clear all the bubbles in this translation session.": {
      "en_us":
          "Clear all the bubbles in this translation session and create a new one.",
      "vi_vi":
          "Xóa tất cả nội dung trong cuộc trò chuyện này và tạo cuộc trò chuyện mới.",
    },
    "Create a new section": {
      "en_us": "Create a new section",
      "vi_vi": "Tạo cuộc trò chuyện mới",
    },
    "Close this session?": {
      "en_us": "Create a new session",
      "vi_vi": "Tạo cuộc trò chuyện mới",
    },
    "Gallery": {
      "en_us": "Gallery",
      "vi_vi": "Bộ sưu tập",
    },
    "Translate now": {
      "en_us": "Translate now",
      "vi_vi": "Dịch ngay",
    },
    "Translate": {
      "en_us": "Translate",
      "vi_vi": "Dịch",
    },
    "Take a picture": {
      "en_us": "Take a picture",
      "vi_vi": "Dịch từ máy ảnh",
    },
    "Changing camera lens": {
      "en_us": "Changing camera lens",
      "vi_vi": "Đang thay đổi ống kính",
    },
    "Recognized Text": {
      "en_us": "Recognized Text",
      "vi_vi": "Chữ nhận dạng được",
    },
    "Go to dictionary": {
      "en_us": "Go to dictionary",
      "vi_vi": "Đi tới từ điển",
    },
    "Prefer AI": {
      "en_us": "Prefer AI",
      "vi_vi": "Ưu tiên AI",
    },
    "Prefer Classic": {
      "en_us": "Prefer Classic",
      "vi_vi": "Ưu tiên Cổ điển",
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
    "Delete History": {
      "en_us": "Delete History",
      "vi_vi": "Xóa lịch sử",
    },
    "AskQuestionBeforeDelete": {
      "en_us":
          "This operation will completely erase your entire history. Are you sure you want to proceed?",
      "vi_vi":
          "Tác vụ này sẽ xóa tất cả lịch sử tra cứu của bạn. Bạn có muốn tiếp tục không?",
    },

    /// Dialogue
    "dialogue_corner_welcoming": {
      "en_us":
          "Welcome to our delightful English-Vietnamese dialogue corner! Dive in and discover a treasure trove of common phrases, beautifully translated between English and Vietnamese.",
      "vi_vi":
          "Chào mừng bạn đến với góc đối thoại Anh-Việt thú vị của chúng tôi! Hãy khám phá kho tàng các cụm từ thông dụng, được dịch một cách hoàn hảo giữa tiếng Anh và tiếng Việt."
    },
    "Dialogue": {
      "en_us": "Dialogue",
      "vi_vi": "Đối thoại",
    },
    "Newest": {
      "en_us": "Newest",
      "vi_vi": "Mới nhất",
    },
    "Most popular": {
      "en_us": "Most popular",
      "vi_vi": "Phổ biến nhất",
    },
    "Seen": {
      "en_us": "Seen",
      "vi_vi": "Đã xem",
    },
    "Provides a list of dual-language English and Vietnamese dialogues on various topics. Feel free to explore and use them for your language practice.":
        {
      "en_us":
          "Provides a list of dual-language English and Vietnamese dialogues on various topics. Feel free to explore and use them for your language practice.",
      "vi_vi":
          "Cung cấp danh sách các đối thoại song ngữ Anh-Việt trên nhiều chủ đề khác nhau. Hãy thoải mái khám phá và sử dụng chúng cho việc luyện tập ngôn ngữ của bạn.",
    },

    "Dialogue Duo: English-Vietnamese Edition": {
      "en_us": "Dialogue Duo: English-Vietnamese Edition",
      "vi_vi": "Đối Thoại Song Ngữ: Phiên Bản Anh-Việt",
    },
    "Thank you for your feedbacks!": {
      "en_us": "Thank you for your feedbacks!",
      "vi_vi": "Cảm ơn những phản hồi từ bạn!",
    },
    "Do you find this dialogue is helpful?": {
      "en_us": "Do you find this dialogue is helpful?",
      "vi_vi": "Bạn có thấy đoạn đối thoại này hữu ích không?",
    },

    "Enhance your language skills with practical dialogues.": {
      "en_us": "Enhance your language skills with practical dialogues.",
      "vi_vi": "Nâng cao kỹ năng ngôn ngữ của bạn với các đối thoại thực tế.",
    },

    /// Conversation

    "Touch to start": {"en_us": "Touch to start", "vi_vi": "Chạm để bắt đầu"},
    "Listening from you": {
      "en_us": "Listening from you",
      "vi_vi": "Đang lắng nghe từ bạn"
    },
    "Bot is speaking": {"en_us": "Bot is speaking", "vi_vi": "Bot đang nói"},
    "Bot is thinking": {
      "en_us": "Bot is thinking",
      "vi_vi": "Bot đang suy nghĩ"
    },
    "No Internet": {
      "en_us": "No Internet",
      "vi_vi": "Không có kết nối Internet"
    },
    "Permission Required": {
      "en_us": "Permission Required",
      "vi_vi": "Yêu cầu quyền"
    },
    "You must allow application to get access to microphone to able to record your voice":
        {
      "en_us":
          "You must allow application to get access to microphone to able to record your voice",
      "vi_vi":
          "Bạn phải cho phép ứng dụng truy cập vào microphone để có thể ghi âm giọng nói của bạn"
    },
    "You not connected to the internet or the application having trouble while trying to connect to the network.":
        {
      "en_us":
          "You not connected to the internet or the application having trouble while trying to connect to the network.",
      "vi_vi":
          "Bạn không kết nối với Internet hoặc ứng dụng gặp sự cố khi cố gắng kết nối với mạng."
    },
    "Voice only": {"en_us": "Voice only", "vi_vi": "Giọng nói"},
    "Text chat": {"en_us": "Text chat", "vi_vi": "Văn bản"},

    "Scan to login": {"en_us": "Scan to login", "vi_vi": "Quét để đăng nhập"},

    "Login successful": {
      "en_us": "Login successful",
      "vi_vi": "Đăng nhập thành công"
    },

    "Congratulations! Your login was successful. You can now enjoy using the app on Windows just like you would on Android.":
        {
      "en_us":
          "Congratulations! Your login was successful. You can now enjoy using the app on Windows just like you would on Android.",
      "vi_vi":
          "Chúc mừng! Đăng nhập của bạn đã thành công. Bây giờ bạn có thể thưởng thức việc sử dụng ứng dụng trên Windows giống như bạn đã làm trên Android."
    },

    "Please use Diccon on your Android phone and click at menu button:": {
      "en_us":
          "Please use Diccon on your Android phone and click at menu button:",
      "vi_vi":
          "Vui lòng sử dụng Diccon trên điện thoại Android của bạn và nhấn vào nút menu:"
    },

    "Send a message for practice": {
      "en_us": "Send a message for practice",
      "vi_vi": "Viết để mở đầu cuộc trò chuyện",
    },
    "Ask me anything": {
      "en_us": "Ask me anything",
      "vi_vi": "Hỏi đáp với",
    },
    "Stop Responding": {
      "en_us": "Stop Responding",
      "vi_vi": "Dừng trả lời",
    },
    "This practice will prepare you for various real-life conversation scenarios.":
        {
      "en_us":
          "This practice will prepare you for various real-life conversation scenarios.",
      "vi_vi":
          "Chuẩn bị cho bạn kĩ năng đối thoại trong nhiều tình huống khác nhau.",
    },
    "Enhance your communication skills with our advanced bot.": {
      "en_us": "Enhance your communication skills with our advanced bot",
      "vi_vi": "Cải thiện kĩ năng giao tiếp cùng với Diccon",
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

    "Your email address appears to be malformed.": {
      "en_us": "Your email address appears to be malformed.",
      "vi_vi": "Địa chỉ email của bạn có vẻ không đúng cú pháp."
    },
    "Your password should be at least 6 characters.": {
      "en_us": "Your password should be at least 6 characters.",
      "vi_vi": "Mật khẩu của bạn phải có ít nhất 6 ký tự."
    },
    "Your email or password is wrong.": {
      "en_us": "Your email or password is wrong.",
      "vi_vi": "Email hoặc mật khẩu của bạn không đúng."
    },
    "The email address is already in use by another account.": {
      "en_us": "The email address is already in use by another account.",
      "vi_vi": "Địa chỉ email đã được sử dụng bởi tài khoản khác."
    },
    "An error occured. Please try again later.": {
      "en_us": "An error occurred. Please try again later.",
      "vi_vi": "Đã xảy ra lỗi. Vui lòng thử lại sau."
    },
    "An email is sent to your provided email.": {
      "en_us": "An email is sent to your provided email.",
      "vi_vi": "Một email đã được gửi đến địa chỉ email bạn cung cấp."
    },
    "Forgot Password?": {
      "en_us": "Forgot Password?",
      "vi_vi": "Quên mật khẩu?"
    },
    "We will send you a reset password link to your email. Kindly check both primary inbox and spams box.":
        {
      "en_us":
          "We will send you a reset password link to your email. Kindly check both primary inbox and spams box.",
      "vi_vi":
          "Chúng tôi sẽ gửi cho bạn một liên kết đặt lại mật khẩu đến email của bạn. Vui lòng kiểm tra cả hộp thư chính và hộp thư rác."
    },
    "Reset password": {"en_us": "Reset password", "vi_vi": "Đặt lại mật khẩu"},

    "Login is required": {
      "en_us": "Login is required",
      "vi_vi": "Bạn cần đăng nhập",
    },
    "You need to login to use this function.": {
      "en_us": "You need to login to use this function.",
      "vi_vi": "Tính năng này của ứng dụng cần bạn phải đăng nhập.",
    },

    "Free": {
      "en_us": "Free",
      "vi_vi": "Dùng thử",
    },

    "Upgrade": {
      "en_us": "Upgrade",
      "vi_vi": "Nâng cấp",
    },
    "This tokens will be used on Conversation or other premium functions.": {
      "en_us":
          "This tokens will be used on Conversation or other premium functions.",
      "vi_vi":
          "Các token này sẽ được sử dụng trong các chức năng Trò chuyện hoặc các chức năng cao cấp khác.",
    },
    "User type: ": {
      "en_us": "User type: ",
      "vi_vi": "Gói tài khoản: ",
    },
    "Upgrade to our premium features for an enhanced dictionary experience. Unlock exclusive tools and resources to enrich your language journey today!":
        {
      "en_us":
          "Upgrade to our premium features for an enhanced dictionary experience. Unlock exclusive tools and resources to enrich your language journey today!",
      "vi_vi":
          "Nâng cấp lên các tính năng cao cấp của chúng tôi để trải nghiệm từ điển tốt hơn. Mở khóa công cụ và tài nguyên độc quyền để làm phong phú hành trình học ngôn ngữ của bạn ngay hôm nay!",
    },

    "BETA": {
      "en_us": "BETA",
      "vi_vi": "Thử nghiệm",
    },
    // "":{
    //   "en_us":"",
    //   "vi_vi":"",
    // },
    // "":{
    //   "en_us":"",
    //   "vi_vi":"",
    // },

    "Maximum Choices Reached": {
      "en_us": "Maximum Choices Reached",
      "vi_vi": "Giới hạn 7 sự lựa chọn"
    },
    "Licenses": {"en_us": "Licenses", "vi_vi": "Giấy phép"},
    "DescriptionTextForLicenses": {
      "en_us":
          "Our app utilizes various open-source libraries. Here, you can view the licenses and attributions for the third-party software integrated into our product.",
      "vi_vi":
          "Ứng dụng của chúng tôi sử dụng nhiều thư viện mã nguồn mở. Tại đây, bạn có thể xem các giấy phép và sự ghi nhận cho phần mềm của bên thứ ba được tích hợp vào sản phẩm của chúng tôi."
    },
    "You've reached the maximum limit of 7 choices in your selection. Please review your choices and make any necessary adjustments before proceeding":
        {
      "en_us":
          "You've reached the maximum limit of 7 choices in your selection. Please review your choices and make any necessary adjustments before proceeding",
      "vi_vi":
          "Bạn đã đạt đến giới hạn tối đa là 7 lựa chọn trong sự lựa chọn của bạn. Vui lòng xem xét lại các lựa chọn của bạn và thực hiện bất kỳ điều chỉnh cần thiết trước khi tiếp tục."
    },
    "Customize response format": {
      "en_us": "Customize response format",
      "vi_vi": "Cấu trúc câu trả lời AI"
    },
    "Release notes": {"en_us": "Release notes", "vi_vi": "Thông tin phiên bản"},
    "Word details": {"en_us": "Word details", "vi_vi": "Độ chi tiết"},
    "Specialized meanings": {
      "en_us": "Specialized meanings",
      "vi_vi": "Chuyên ngành"
    },
    "Phiên âm": {"en_us": "Pronunciation", "vi_vi": "Phát âm"},
    "Định nghĩa": {"en_us": "Definitions", "vi_vi": "Định nghĩa"},
    "Ví dụ": {"en_us": "Examples", "vi_vi": "Ví dụ"},
    "Nguồn gốc": {"en_us": "Etymology", "vi_vi": "Nguồn gốc"},
    "Loại từ": {"en_us": "Part of Speech", "vi_vi": "Loại từ"},
    "Ghi chú về cách sử dụng": {
      "en_us": "Usage Notes",
      "vi_vi": "Ghi chú về cách sử dụng"
    },
    "Từ liên quan": {"en_us": "Related Words", "vi_vi": "Từ liên quan"},
    "Từ đồng âm": {"en_us": "Homonyms", "vi_vi": "Từ đồng âm"},
    "Biến thể vùng miền": {
      "en_us": "Regional Variations",
      "vi_vi": "Biến thể vùng miền"
    },
    "Bối cảnh văn hóa hoặc lịch sử": {
      "en_us": "Cultural or Historical Context",
      "vi_vi": "Bối cảnh văn hóa hoặc lịch sử"
    },
    "Từ tạo thành từ này": {
      "en_us": "Derived Terms",
      "vi_vi": "Từ tạo thành từ này"
    },
    "Cụm động từ": {"en_us": "Phrasal Verbs", "vi_vi": "Cụm động từ"},
    "Viết tắt": {"en_us": "Abbreviations", "vi_vi": "Viết tắt"},
    "Khái niệm liên quan": {
      "en_us": "Related Concepts",
      "vi_vi": "Khái niệm liên quan"
    },
    "Tần suất sử dụng": {
      "en_us": "Usage Frequency",
      "vi_vi": "Tần suất sử dụng"
    },
    "Lưu ý về cách sử dụng": {
      "en_us": "Notes on Usage",
      "vi_vi": "Lưu ý về cách sử dụng"
    },
    "Y học": {"en_us": "Medical", "vi_vi": "Y học"},
    "Luật pháp": {"en_us": "Legal", "vi_vi": "Luật pháp"},
    "Khoa học": {"en_us": "Scientific", "vi_vi": "Khoa học"},
    "Kỹ thuật": {"en_us": "Technical", "vi_vi": "Kỹ thuật"},
    "Tài chính và Kinh tế": {
      "en_us": "Financial and Economic",
      "vi_vi": "Tài chính và Kinh tế"
    },
    "Môi trường": {"en_us": "Environmental", "vi_vi": "Môi trường"},
    "Ngôn ngữ học": {"en_us": "Linguistics", "vi_vi": "Ngôn ngữ học"},
    "Toán học": {"en_us": "Mathematics", "vi_vi": "Toán học"},
    "Nghệ thuật": {"en_us": "Art", "vi_vi": "Nghệ thuật"},
    "Âm nhạc": {"en_us": "Music", "vi_vi": "Âm nhạc"},
    "Tâm lý học": {"en_us": "Psychology", "vi_vi": "Tâm lý học"},
    "Triết học": {"en_us": "Philosophy", "vi_vi": "Triết học"},
    "Thiên văn học": {"en_us": "Astronomy", "vi_vi": "Thiên văn học"},
    "Địa chất học": {"en_us": "Geology", "vi_vi": "Địa chất học"},
    "Thực vật học": {"en_us": "Botany", "vi_vi": "Thực vật học"},
    "Động vật học": {"en_us": "Zoology", "vi_vi": "Động vật học"},
    "Kiến trúc": {"en_us": "Architecture", "vi_vi": "Kiến trúc"},
    "Lịch sử": {"en_us": "History", "vi_vi": "Lịch sử"},
    "Ẩm thực": {"en_us": "Culinary", "vi_vi": "Ẩm thực"},
    "Thời trang": {"en_us": "Fashion", "vi_vi": "Thời trang"},
    "Thể thao": {"en_us": "Sports", "vi_vi": "Thể thao"},
    "Du lịch": {"en_us": "Travel", "vi_vi": "Du lịch"},
    "Hàng không vũ trụ": {
      "en_us": "Aviation and Aerospace",
      "vi_vi": "Hàng không và Vũ trụ"
    },
    "Hàng hải": {"en_us": "Maritime", "vi_vi": "Hàng hải"},
    "Giao thông vận tải": {
      "en_us": "Automotive and Transportation",
      "vi_vi": "Giao thông vận tải"
    },
    "Sync your data": {
      "en_us": "Sync your data",
      "vi_vi": "Đồng bộ dữ liệu",
    },
    "System default": {
      "en_us": "System default",
      "vi_vi": "Tự động",
    },
    "English": {
      "en_us": "English",
      "vi_vi": "English",
    },
    "Tiếng Việt": {
      "en_us": "Tiếng Việt",
      "vi_vi": "Tiếng Việt",
    },
    "Use System Theme": {
      "en_us": "Use System Theme",
      "vi_vi": "Sử dụng chủ đề hệ thống",
    },
    "Accent color": {
      "en_us": "Accent color",
      "vi_vi": "Tông màu",
    },
    "DesciptionTextForPrivacyPolicy": {
      "en_us":
          "We hold your privacy in high regard and assure you that your personal data will not be disclosed to any third party.",
      "vi_vi":
          "Chúng tôi tôn trọng quyền riêng tư của bạn và cam kết dữ liệu cá nhân của bạn sẽ không được chia sẻ với bất cứ bên thứ ba nào cả.",
    },
    "For more information about our privacy policy, please visit:": {
      "en_us": "For more information about our privacy policy, please visit:",
      "vi_vi":
          "Để biết thêm chi tiết về điều khoản riêng tư, vui lòng truy cập:",
    },
    "Privacy Policy": {
      "en_us": "Privacy Policy",
      "vi_vi": "Điều khoản",
    },
    "Continue without login": {
      "en_us": "Continue without login",
      "vi_vi": "Đăng nhập sau",
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
          "Note: The changes will become effective the next time you open the app.",
      "vi_vi":
          "Ghi chú: Những thay đổi sẽ có hiệu lực vào lần tiếp theo bạn mở ứng dụng.",
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
    "Preferences": {
      "en_us": "Preferences",
      "vi_vi": "Tùy chỉnh",
    },

    /// Essential
    "School-supplies": {
      "en_us": "School-supplies",
      "vi_vi": "Vật dụng học tập",
    },
    "Practice": {
      "en_us": "Practice",
      "vi_vi": "Luyện tập",
    },
    "The page is broken, please try to reload again.": {
      "en_us": "The page is broken, please try to reload again.",
      "vi_vi": "Trang này đã bị hỏng, vui lòng tải lại trang.",
    },
    "Uninvited guest": {
      "en_us": "Uninvited guest",
      "vi_vi": "Lỗi tải trang",
    },
    "Oops, something went wrong": {
      "en_us": "Oops, something went wrong",
      "vi_vi": "Oops, có gì đó sai sai",
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
          "Mastering 1848 core English words fosters clear communication. It facilitates meaningful interactions, empowers expression, and broadens access to information and opportunities.",
      "vi_vi":
          "Nắm vững 1848 từ tiếng Anh cốt lõi sẽ thúc đẩy sự giao tiếp rõ ràng. Tạo điều kiện cho các cuộc trò chuyện mang nhiều màu sắc, tăng cường khả năng diễn đạt của người nói.",
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
  String get i18nEnglish => localize(this, _t, locale: 'en_us');

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);
}
