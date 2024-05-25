import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class ReleaseNotes extends StatelessWidget {
  const ReleaseNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Release notes".i18n,
        ),
      ),
      body: ListView(
        children: const [
          ReleaseNotesItem(
            version: '664',
            date: '25-05-2024',
            changesNote: [
              'Gỡ bỏ từ điển cổ điển',
              'Cải thiện hiệu suất ứng dụng',
            ],
          ),
          ReleaseNotesItem(
            version: '656',
            date: '17-05-2024',
            changesNote: [
              'Sửa lỗi thanh điều hướng âm thanh trong truyện đọc',
              'Cải thiện hiệu suất ứng dụng',
            ],
          ),
          ReleaseNotesItem(
            version: '637',
            date: '30-04-2024',
            changesNote: [
              'Hỗ trợ đăng nhập trên Windows bằng mã QR',
              'Thêm nút bấm sao chép cho từ điển',
            ],
          ),
          ReleaseNotesItem(
            version: '630',
            date: '23-04-2024',
            changesNote: [
              'Sử dụng token trong trò chuyện',
              'Hỗ trợ thay đổi mật khẩu',
              'Cải thiện chất lượng giao diện trên màn hình đăng nhập'
            ],
          ),
          ReleaseNotesItem(
            version: '621',
            date: '18-04-2024',
            changesNote: [
              'Cải thiện chất lượng AI',
              'Cải thiện trải nghiệm người dùng'
            ],
          ),
          ReleaseNotesItem(
            version: '617',
            date: '16-04-2024',
            changesNote: [
              'Giảm thiểu lỗi quá tải khi sử dụng Conversation',
              'Sửa tiêu đề không hiển thị trong Light mode',
              'Mở khóa đăng nhập và sao lưu dữ liệu'
            ],
          ),
          ReleaseNotesItem(
            version: '607',
            date: '09-04-2024',
            changesNote: [
              'Cải thiện tốc độ tải âm thanh trong truyện',
              'Cải thiện hiệu năng ứng dụng'
            ],
          ),
          ReleaseNotesItem(
            version: '596',
            date: '02-01-2024',
            changesNote: [
              'Cải thiện trải nghiệm người dùng',
            ],
          ),
          ReleaseNotesItem(
            version: '590',
            date: '26-12-2023',
            changesNote: [
              'Cải thiện trải nghiệm người dùng trên Windows',
            ],
          ),
          ReleaseNotesItem(
            version: '583',
            date: '19-12-2023',
            changesNote: [
              'Thêm âm thanh cho truyện',
              'Cải thiện hiệu năng ứng dụng trên Windows'
            ],
          ),
          ReleaseNotesItem(
            version: '574',
            date: '14-12-2023',
            changesNote: [
              'Cải thiện chất lượng bóng chat',
            ],
          ),
          ReleaseNotesItem(
            version: '570',
            date: '11-12-2023',
            changesNote: [
              'Sửa lỗi mất dữ liệu trong bộ lọc truyện',
              'Cải thiện giao diện người dùng',
            ],
          ),
          ReleaseNotesItem(
            version: '562',
            date: '09-12-2023',
            changesNote: [
              'Mở khóa tốc độ trả lời AI trên windows',
            ],
          ),
          ReleaseNotesItem(
            version: '552',
            date: '30-11-2023',
            changesNote: [
              'Cải thiện chất lượng câu trả lời của AI',
              'Cải thiện giao diện trên Windows',
              'Tối ưu hóa việc sử dụng CPU trên Windows',
              'Thêm truyện mới cho Thư viện',
            ],
          ),
          ReleaseNotesItem(
            version: '532',
            date: '28-11-2023',
            changesNote: [
              'Sửa lỗi bong bóng chat xuất hiện hai lần trong Từ điển',
              'Tái cấu trúc dự án',
            ],
          ),
          ReleaseNotesItem(
            version: '520',
            date: '18-11-2023',
            changesNote: [
              'Dự án chính thức thành dự án mã nguồn mở',
              'Sửa lỗi và cải thiện hiệu năng',
            ],
          ),
          ReleaseNotesItem(
            version: '487',
            date: '15-11-2023',
            changesNote: [
              'Thêm tính năng dịch từ tiếng Việt sang tiếng Anh',
              'Thêm tính năng tự nhận dạng ngôn ngữ',
            ],
          ),
          ReleaseNotesItem(
            version: '471',
            date: '13-11-2023',
            changesNote: [
              'Thêm tính năng thông báo phiên bản mới',
              'Thanh tùy chỉnh trong chế độ đọc trong mục Truyện ngắn'
            ],
          ),
          ReleaseNotesItem(
            version: '454',
            date: '11-11-2023',
            changesNote: [
              'Dịch từ và giải thích trong câu văn ở mục Truyện ngắn',
              'Sửa lỗi khi không tìm thấy từ trong từ điển Classic'
            ],
          ),
          ReleaseNotesItem(
            version: '448',
            date: '10-11-2023',
            changesNote: [
              'Thêm tính năng tìm kiếm truyện',
              'Tăng tốc độ tra cứu từ điển trên Windows',
              'Giảm kích thước gói cài đặt ứng dụng'
            ],
          ),
          ReleaseNotesItem(
            version: '439',
            date: '09-11-2023',
            changesNote: [
              'Tăng tốc xử lí hình ảnh trong Text Recognizer',
              'Cải thiện giao diện người dùng',
              'Tái cấu trúc sử dụng freezed'
            ],
          ),
          ReleaseNotesItem(
            version: '416',
            date: '02-11-2023',
            changesNote: [
              'Thêm tính năng dịch từ hình ảnh',
              'Thêm bảng màu mới',
              'Giới hạn tùy chọn tra cứu',
              'Sửa lỗi từ điển Thesaurus hiển thị sai',
              'Sửa lỗi không phát được âm thanh đối với câu dài',
              'Sửa lỗi không copy được chữ khi chạm vào tin nhắn của người dùng'
            ],
          ),
          ReleaseNotesItem(
            version: '398',
            date: '01-11-2023',
            changesNote: [
              'Tăng tốc độ tìm kiếm khi sử dụng từ điển AI',
            ],
          ),
          ReleaseNotesItem(
            version: '394',
            date: '30-10-2023',
            changesNote: [
              'Tăng tốc độ tìm kiếm khi sử dụng từ điển Cổ điển',
              'Giảm thiểu mức sử dụng RAM trên thiết bị Android và Windows',
              'Sửa lỗi và cải thiện hiệu năng',
            ],
          ),
          ReleaseNotesItem(
            version: '378',
            date: '27-10-2023',
            changesNote: [
              'Hỗ trợ speech-to-text trên thiết bị Android',
              'Sửa lỗi và cải thiện hiệu năng'
            ],
          ),
          ReleaseNotesItem(
            version: '365',
            date: '23-10-2023',
            changesNote: [
              'Thêm nút bấm "Dừng trả lời" trong mục trò chuyện, cho phép dừng câu trả lời của AI.',
              'Thay đổi cách tùy chỉnh câu trả lời trong mục Từ điển.'
                  'Thêm trang Release notes'
            ],
          ),
          ReleaseNotesItem(
            version: '358',
            date: '23-10-2023',
            changesNote: ['Tối ưu hóa hiệu năng'],
          ),
          ReleaseNotesItem(
            version: '346',
            date: '16-10-2023',
            changesNote: [
              'Cập nhật giao diện ứng dụng đúng với quy cách của Material 3',
              'Cải thiện hiệu năng cho trang Lịch sử trong mục Từ điển'
            ],
          ),
          ReleaseNotesItem(
            version: '330',
            date: '17-10-2023',
            changesNote: [
              'Sửa lỗi giao diện',
              'Thêm tính năng chuyển đổi giao diện',
              'Thêm Color Palette cho giao diện',
              'Sử dụng Material 3 cho giao điện'
            ],
          ),
          ReleaseNotesItem(
            version: '317',
            date: '14-10-2023',
            changesNote: [
              'Sửa lỗi đăng nhập và đồng bộ dữ liệu',
              'Adaptive theme cho thiết bị desktop và Android'
            ],
          ),
          ReleaseNotesItem(
            version: '309',
            date: '11-10-2023',
            changesNote: [
              'Thêm Responsive để hiển thị tốt hơn trên các màn hình với kích thước khác nhau.',
              'AI cho mục Truyện đọc',
              'Sửa lỗi khi đồng bộ dữ liệu'
            ],
          ),
          ReleaseNotesItem(
            version: '293',
            date: '10-10-2023',
            changesNote: [
              'Sửa lỗi nút bấm Heart trong Recent Topic ở mục 1848 Essential Words',
              'Sửa lỗi và cải thiện hiệu năng',
              'Gỡ bỏ Google Translator và thay thế bằng Chat GPT 3.5 Turbo',
              'Sử dụng Go Router thay cho Navigator'
            ],
          ),
          ReleaseNotesItem(
            version: '265',
            date: '05-10-2023',
            changesNote: [
              'Tối ưu hóa trải nghiệm người dùng trên thiết bị desktop',
              'Sửa lỗi trên refresh button trong mục Từ điển',
              'Thêm clear button cho Từ điển và Trò chuyện',
            ],
          ),
          ReleaseNotesItem(
            version: '254',
            date: '04-10-2023',
            changesNote: [
              'Cập nhật thuật toán tìm kiếm',
              'Thêm trang Thông tin ứng dụng',
              'Tái cấu trúc dự án',
              'Cải thiện giao diện người dùng',
              'Thêm trí tuệ nhân tạo vào ứng dụng',
              'Sửa lỗi và cải thiện hiệu năng',
            ],
          ),
          ReleaseNotesItem(
            version: '184',
            date: '20-09-2023',
            changesNote: [
              'Cập nhật dependency',
              'Tối ưu hóa giao diện người dùng'
            ],
          ),
          ReleaseNotesItem(
            version: '179',
            date: '19-09-2023',
            changesNote: [
              'Thêm menu trên màn hình chính',
              'Thêm cài đặt ngôn ngữ trong mục Settings',
              'Hoàn thiện đăng nhập và đăng xuất người dùng trên thiết bị Android',
              'Cải thiện hiệu năng khi tải truyện',
              'Thêm tính năng đồng bộ hóa dữ liệu',
              'Hỗ trợ chuyển đổi giao diện Dark Mode, Light Mode'
            ],
          ),
          ReleaseNotesItem(
            version: '143',
            date: '12-09-2023',
            changesNote: ['Tái cấu trúc lại chương trình'],
          ),
          ReleaseNotesItem(
            version: '135',
            date: '05-09-2023',
            changesNote: [
              'Tối ưu hóa trải nghiệm người dùng, cải thiện giao diện',
            ],
          ),
          ReleaseNotesItem(
            version: '126',
            date: '27-08-2023',
            changesNote: [
              'Cải thiện hiệu năng',
              'Sửa lỗi màu sắc hiển thị sai trên Navigation Bar'
            ],
          ),
          ReleaseNotesItem(
            version: '112',
            date: '24-08-2023',
            changesNote: ['Gỡ bỏ truyện đọc và video'],
          ),
          ReleaseNotesItem(
            version: '109',
            date: '21-08-2023',
            changesNote: [
              'Cải thiện hiệu năng trên thiết bị Android',
              'Sử dụng Bloc để quản lý State trên trang tra cứu từ điển',
              'Thêm tính năng gợi ý từ khi gõ',
              'Hỗ trợ giao diện đa ngôn ngữ sử dụng i18n',
            ],
          ),
          ReleaseNotesItem(
            version: '93',
            date: '14-08-2023',
            changesNote: ['Hỗ trợ Dark Mode trên thiết bị Android'],
          ),
          ReleaseNotesItem(
            version: '88',
            date: '10-08-2023',
            changesNote: [
              'Thêm tính năng xóa lịch sử cho mục Video',
              'Sửa lỗi overflow cho GridItem trong các Item truyện đọc',
              'Thêm gợi ý hình ảnh từ Pixabay cho từ điển'
            ],
          ),
          ReleaseNotesItem(
            version: '82',
            date: '07-08-2023',
            changesNote: [
              'Sửa lỗi âm thanh trên những từ vựng mới',
              'Sửa lỗi tra cứu từ điển trong Bottom Translator',
              'Gỡ bỏ adaptive title bar trên phiên bản desktop',
              'Thêm trang video và lịch sử xem',
              'Đăng nhập và đăng xuất người dùng'
            ],
          ),
          ReleaseNotesItem(
            version: '60',
            date: '14-07-2023',
            changesNote: [
              'Thêm trang lịch sử cho các câu chuyện đã đọc',
              'Cải thiện giao diện trang đọc'
            ],
          ),
          ReleaseNotesItem(
            version: '50',
            date: '03-07-2023',
            changesNote: [
              'Thêm tính năng tra cứu từ điển',
              'Gợi ý từ đồng nghĩa và trái nghĩa',
              'Cho phép lưu lại Cài đặt của người dùng',
              'Âm thanh cho từ vựng',
            ],
          ),
          ReleaseNotesItem(
            version: '1',
            date: '02-05-2023',
            changesNote: [
              'Xây dựng cấu trúc ứng dụng.',
            ],
          ),
        ],
      ),
    );
  }
}

class ReleaseNotesItem extends StatelessWidget {
  const ReleaseNotesItem({
    super.key,
    required this.version,
    required this.date,
    required this.changesNote,
  });
  final String version;
  final String date;
  final List<String> changesNote;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            version,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(date),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: changesNote.map((e) => Text('- $e')).toList(),
      ),
    );
  }
}
