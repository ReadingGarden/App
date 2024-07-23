import 'dart:ui';

class Constant {
  static const LOCAL_URL = 'http://localhost:8000/api/v1/';
  static const URL =
      'http://ec2-43-203-248-188.ap-northeast-2.compute.amazonaws.com/api/v1/';
  static const IMAGE_URL =
      'http://ec2-43-203-248-188.ap-northeast-2.compute.amazonaws.com/api/images/';

  static const FLOWER_LIST = ['데이지', '튤립', '물망초', '선인장', '민들레', '해바라기'];

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
    Color(0xffEE5757),
    Color(0xffFA8BB3),
    Color(0xffFFC038),
    Color(0xff79D94C),
    Color(0xff00AA96),
    Color(0xff476EFF),
    Color(0xff9570FF),
    Color(0xff2F2F2F),
  ];
}
