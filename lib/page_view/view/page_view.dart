import 'package:store_go/page_view/presenter/page_view_presenter.dart';
import 'package:store_go/settings/view/settings.dart';
import 'package:store_go/orders/view/orders.dart';
import 'package:store_go/store/view/store.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'new_invoice.dart';

class PageViewController extends StatefulWidget {
  @override
  _PageViewControllerState createState() => _PageViewControllerState();
}

class _PageViewControllerState extends State<PageViewController> {
  PageViewPresenter _presenter = PageViewPresenter();

  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 14,
                  child: PageView(
                    onPageChanged: (int page) => setState(
                        () => _presenter.onPageChangeOpacityHandler(page)),
                    controller: _controller,
                    reverse: true,
                    children: <Widget>[
                      NewInvoice(),
                      Orders(),
                      Store(),
                      Settings()
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الإعدادات',
                            style: TextStyle(
                                color: _presenter.pageFourTextColor,
                                fontSize: 15.0,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 2.0),
                            child: Opacity(
                              opacity: _presenter.fourthPageIndicatorOpacity,
                              child: Container(
                                height: 3.0,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'المتجر',
                            style: TextStyle(
                                color: _presenter.pageThreeTextColor,
                                fontSize: 15.0,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 2.0),
                            child: Opacity(
                              opacity: _presenter.thirdPageIndicatorOpacity,
                              child: Container(
                                height: 3.0,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الطلبات',
                            style: TextStyle(
                                color: _presenter.pageTwoTextColor,
                                fontSize: 15.0,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 2.0),
                            child: Opacity(
                              opacity: _presenter.secondPageIndicatorOpacity,
                              child: Container(
                                height: 3.0,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'فاتورة جديدة',
                            style: TextStyle(
                                color: _presenter.pageOneTextColor,
                                fontSize: 15.0,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 2.0),
                            child: Opacity(
                              opacity: _presenter.firstPageIndicatorOpacity,
                              child: Container(
                                height: 3.0,
                                width: 40.0,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
