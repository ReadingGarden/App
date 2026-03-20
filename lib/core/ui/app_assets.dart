import 'package:book_flutter/gen/assets.gen.dart';

class AppAssets {
  static SvgGenImage get iconAdd => Assets.icons.iconAdd;
  static SvgGenImage get iconAddBig => Assets.icons.iconAddBig;
  static SvgGenImage get iconAngleLeft => Assets.icons.iconAngleLeft;
  static SvgGenImage get iconAngleRight => Assets.icons.iconAngleRight;
  static SvgGenImage get iconBookmark => Assets.icons.iconBookmark;
  static SvgGenImage get iconBookmarkFull => Assets.icons.iconBookmarkFull;
  static SvgGenImage get iconCamera => Assets.icons.iconCamera;
  static SvgGenImage get iconCheck => Assets.icons.iconCheck;
  static SvgGenImage get iconCheckDeselect => Assets.icons.iconCheckDeselect;
  static SvgGenImage get iconCheckSelect => Assets.icons.iconCheckSelect;
  static SvgGenImage get iconClose => Assets.icons.iconClose;
  static SvgGenImage get iconEdit => Assets.icons.iconEdit;
  static SvgGenImage get iconEllipsis => Assets.icons.iconEllipsis;
  static SvgGenImage get iconKeyboardDown => Assets.icons.iconKeyboardDown;
  static SvgGenImage get iconKeyboardUp => Assets.icons.iconKeyboardUp;
  static SvgGenImage get iconLeader => Assets.icons.iconLeader;
  static SvgGenImage get iconPhoto => Assets.icons.iconPhoto;
  static SvgGenImage get iconSearch => Assets.icons.iconSearch;
  static SvgGenImage get iconShare => Assets.icons.iconShare;
  static SvgGenImage get iconStarDeselect => Assets.icons.iconStarDeselect;
  static SvgGenImage get iconStarSelect => Assets.icons.iconStarSelect;
  static SvgGenImage get iconWater => Assets.icons.iconWater;
  static SvgGenImage get iconWrite => Assets.icons.iconWrite;
  static SvgGenImage get imageAdd => Assets.images.imageAdd;

  static AssetGenImage emptyBookshelf(int pageViewIndex) {
    switch (pageViewIndex) {
      case 0:
        return Assets.images.empty.emptyPng____;
      case 1:
        return Assets.images.empty.emptyPng_;
      default:
        return Assets.images.empty.emptyPng___;
    }
  }

  static AssetGenImage get emptyMemo => Assets.images.empty.emptyPng__;

  static AssetGenImage get emptyGardenBookList => Assets.images.empty.emptyPng;

  static AssetGenImage pageFlower(String flowerName) {
    switch (flowerName) {
      case '데이지':
        return Assets.images.pageFlowers.pagePng;
      case '수선화':
        return Assets.images.pageFlowers.pagePng_;
      case '장미':
        return Assets.images.pageFlowers.pagePng__;
      case '튤립':
        return Assets.images.pageFlowers.pagePng___;
      case '팬지':
        return Assets.images.pageFlowers.pagePng____;
      default:
        return Assets.images.pageFlowers.pagePng;
    }
  }

  static AssetGenImage okFlower(String flowerName) {
    switch (flowerName) {
      case '데이지':
        return Assets.images.okFlowers.okPng;
      case '수선화':
        return Assets.images.okFlowers.okPng_;
      case '장미':
        return Assets.images.okFlowers.okPng__;
      case '튤립':
        return Assets.images.okFlowers.okPng___;
      case '팬지':
        return Assets.images.okFlowers.okPng____;
      default:
        return Assets.images.okFlowers.okPng;
    }
  }

  static AssetGenImage selectFlower(String flowerName) {
    switch (flowerName) {
      case '데이지':
        return Assets.images.selectFlowers.selectPng;
      case '수선화':
        return Assets.images.selectFlowers.selectPng_;
      case '장미':
        return Assets.images.selectFlowers.selectPng__;
      case '튤립':
        return Assets.images.selectFlowers.selectPng___;
      case '팬지':
        return Assets.images.selectFlowers.selectPng____;
      default:
        return Assets.images.selectFlowers.selectPng;
    }
  }

  static AssetGenImage bookFlower(String flowerName) {
    switch (flowerName) {
      case '데이지':
        return Assets.images.bookFlowers.bookPng;
      case '수선화':
        return Assets.images.bookFlowers.bookPng_;
      case '장미':
        return Assets.images.bookFlowers.bookPng__;
      case '튤립':
        return Assets.images.bookFlowers.bookPng___;
      case '팬지':
        return Assets.images.bookFlowers.bookPng____;
      default:
        return Assets.images.bookFlowers.bookPng;
    }
  }

  static AssetGenImage profileFlower(String flowerName) {
    switch (flowerName) {
      case '데이지':
        return Assets.images.profile.profilePng;
      case '수선화':
        return Assets.images.profile.profilePng_;
      case '장미':
        return Assets.images.profile.profilePng__;
      case '튤립':
        return Assets.images.profile.profilePng___;
      case '팬지':
        return Assets.images.profile.profilePng____;
      default:
        return Assets.images.profile.profilePng;
    }
  }

  static AssetGenImage mainFlower(int step, String flowerName) {
    switch (step) {
      case 1:
        switch (flowerName) {
          case '데이지':
            return Assets.images.mainFlowers.a1Png;
          case '수선화':
            return Assets.images.mainFlowers.a1Png_;
          case '장미':
            return Assets.images.mainFlowers.a1Png__;
          case '튤립':
            return Assets.images.mainFlowers.a1Png___;
          case '팬지':
            return Assets.images.mainFlowers.a1Png____;
        }
      case 2:
        switch (flowerName) {
          case '데이지':
            return Assets.images.mainFlowers.a2Png;
          case '수선화':
            return Assets.images.mainFlowers.a2Png_;
          case '장미':
            return Assets.images.mainFlowers.a2Png__;
          case '튤립':
            return Assets.images.mainFlowers.a2Png___;
          case '팬지':
            return Assets.images.mainFlowers.a2Png____;
        }
      case 3:
        switch (flowerName) {
          case '데이지':
            return Assets.images.mainFlowers.a3Png;
          case '수선화':
            return Assets.images.mainFlowers.a3Png_;
          case '장미':
            return Assets.images.mainFlowers.a3Png__;
          case '튤립':
            return Assets.images.mainFlowers.a3Png___;
          case '팬지':
            return Assets.images.mainFlowers.a3Png____;
        }
      case 4:
        switch (flowerName) {
          case '데이지':
            return Assets.images.mainFlowers.a4Png;
          case '수선화':
            return Assets.images.mainFlowers.a4Png_;
          case '장미':
            return Assets.images.mainFlowers.a4Png__;
          case '튤립':
            return Assets.images.mainFlowers.a4Png___;
          case '팬지':
            return Assets.images.mainFlowers.a4Png____;
        }
    }

    return Assets.images.mainFlowers.a1Png;
  }
}
