import 'package:flutter/material.dart';

class PageViewPresenter {
  var firstPageIndicatorOpacity = 1.0;
  var secondPageIndicatorOpacity = 0.0;
  var thirdPageIndicatorOpacity = 0.0;
  var fourthPageIndicatorOpacity = 0.0;

  Color pageOneTextColor = Colors.black;
  Color pageTwoTextColor = Colors.grey[600];
  Color pageThreeTextColor = Colors.grey[600];
  Color pageFourTextColor = Colors.grey[600];

  void onPageChangeOpacityHandler(int page) {
    switch (page) {
      case 1:
        {
          pageOneTextColor = Colors.grey[600];
          pageTwoTextColor = Colors.black;
          pageThreeTextColor = Colors.grey[600];
          pageFourTextColor = Colors.grey[600];

          firstPageIndicatorOpacity = 0.0;
          secondPageIndicatorOpacity = 1.0;
          // reverse case handle
          thirdPageIndicatorOpacity = 0.0;
        }
        break;

      case 2:
        {
          pageOneTextColor = Colors.grey[600];
          pageTwoTextColor = Colors.grey[600];
          pageThreeTextColor = Colors.black;
          pageFourTextColor = Colors.grey[600];

          firstPageIndicatorOpacity = 0.0;
          secondPageIndicatorOpacity = 0.0;
          thirdPageIndicatorOpacity = 1.0;
          // reverse case handle
          fourthPageIndicatorOpacity = 0.0;
        }
        break;

      case 3:
        {
          pageOneTextColor = Colors.grey[600];
          pageTwoTextColor = Colors.grey[600];
          pageThreeTextColor = Colors.grey[600];
          pageFourTextColor = Colors.black;

          firstPageIndicatorOpacity = 0.0;
          secondPageIndicatorOpacity = 0.0;
          thirdPageIndicatorOpacity = 0.0;
          fourthPageIndicatorOpacity = 1.0;
        }
        break;

      default:
        {
          pageOneTextColor = Colors.black;
          pageTwoTextColor = Colors.grey[600];
          pageThreeTextColor = Colors.grey[600];
          pageFourTextColor = Colors.grey[600];

          firstPageIndicatorOpacity = 1.0;
          secondPageIndicatorOpacity = 0.0;
          thirdPageIndicatorOpacity = 0.0;
          fourthPageIndicatorOpacity = 0.0;
        }
        break;
    }
  }
}
