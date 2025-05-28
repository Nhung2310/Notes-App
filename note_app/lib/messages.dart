import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'Notes': 'Notes',
      'Create your first note !': 'Create your first note !',
      'Title': 'Title',
      'Type something...': 'Type something...',
    },
    'vi_VN': {
      'Notes': 'Ghi chú',
      'Create your first note !': ' Tạo ghi chú đầu tiên của bạn!',
      'Title': 'Tiêu đề',
      'Type something...': 'Gõ gì đó đi...',
    },
  };
}
