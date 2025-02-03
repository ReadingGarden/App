import 'dart:ui';

class Constant {
  static const ASSETS_ICONS = 'assets/icons/';
  static const MAIN_FLOWERS = 'assets/images/main_flowers/';
  static const PROFILE = 'assets/images/profile/';

  // static const URL = 'http://172.30.1.41:8000/api/v1/';

  static const URL =
      'http://ec2-43-203-248-188.ap-northeast-2.compute.amazonaws.com/api/v1/';
  static const IMAGE_URL =
      'http://ec2-43-203-248-188.ap-northeast-2.compute.amazonaws.com/api/images/';

  static const FLOWER_LIST = ['데이지', '튤립', '장미', '팬지', '수선화'];

  static const FLOWER_INFO_LIST = [
    '데이지는 해가 뜨면 고개를 들고 해가 지면\n다시 고개를 내린다고 해서 태양의 눈이라고도 불려요',
    '튤립은 햇빛을 받으면 춤을 추듯 흔들리며,\n매일마다 활짝 피고 오므라드는 모습이 매력적이에요',
    '장미는 가시에 둘러싸인 아름다움으로\n보호의 상징이 되어 사랑과 열정을 나타내요',
    '팬지는 다양한 색의 조합과 독특한 꽃잎 모양을 가지며\n사람의 웃는 얼굴처럼 보이기도 해요',
    '수선화는 진하고 상쾌한 향기를 지니고\n물가에서도 잘 자라 물과 친한 꽃으로 알려져 있어요',
  ];

  static const GARDEN_COLOR_LIST = [
    'red',
    'pink',
    'yellow',
    'light-green',
    'green',
    'blue',
    'purple',
    'black'
  ];

  static const GARDEN_COLOR_SET_LIST = [
    Color(0xffE27979),
    Color(0xffEAACC5),
    Color(0xffF9D780),
    Color(0xff9DCC93),
    Color(0xff6A9386),
    Color(0xff97C2DD),
    Color(0xff9C95C4),
    Color(0xff595959),
  ];

  static const GARDEN_BACK_COLOR_SET_LIST = [
    Color(0xffE5C3C1),
    Color(0xffE5CAD5),
    Color(0xffF4EBC9),
    Color(0xffD6E2C3),
    Color(0xffC1D6CB),
    Color(0xffC6DBE0),
    Color(0xffCFCFE5),
    Color(0xffCACACA),
  ];
}
