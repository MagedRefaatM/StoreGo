import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:store_go/products/model/entities/single_product.dart';
import 'package:store_go/products/model/services/products/add_product_category.dart';
import 'package:store_go/products/model/services/products/get_product_details.dart';
import 'package:store_go/products/model/services/products/get_products_api.dart';
import 'package:store_go/products/presenter/products_presenter.dart';
import 'package:store_go/products/view/product_details.dart';
import 'package:toast/toast.dart';

import 'add_new_product.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  GetProducts _getProducts;
  GetProductCategory _getProductCategory;
  GetProductDetails _getProductDetails;
  ProductsPresenter _presenter;

  final _productsScrollController = ScrollController();
  final _keyLoader = new GlobalKey<State>();

  _scrollListener() {
    _presenter.handleScrollDirection(
        _productsScrollController,
        () => setState(() {
              ProductsLocalData.currentProductPage =
                  ProductsLocalData.currentProductPage + 1;
              getFilteredProducts(
                  ProductsLocalData.currentProductPageFilter, 8);
            }));
  }

  @override
  void initState() {
    super.initState();
    _presenter = ProductsPresenter();
    _getProducts = GetProducts();
    _getProductDetails = GetProductDetails();
    _getProductCategory = GetProductCategory();
    _productsScrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          body: SingleChildScrollView(
            controller: _productsScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 8.0, 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                    side: BorderSide(
                                        color: Colors.deepPurpleAccent,
                                        width: 1.5))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(13.0)),
                          ),
                          onPressed: onAddProductPressed,
                          child: Text(
                            'إضافة منتج',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 19.0,
                                color: Colors.deepPurpleAccent,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Text(
                        'المنتجات',
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ArabicUiDisplay',
                            fontSize: 26.0,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey[500],
                          size: 40.0,
                        ),
                        onTap: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'منتهى الكمية',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.0,
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 8.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 9.0),
                                child: Text(
                                  '${ProductsLocalData.totalEmptyQuantityProducts}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => setState(() {
                            ProductsLocalData.products.clear();
                            ProductsLocalData.currentProductPageFilter = 2;
                            ProductsLocalData.currentProductPage = 1;
                            getFilteredProducts(2, 8);
                          }),
                        ),
                        Container(
                          height: 1.5,
                          width: 25.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'غير معروض',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.0,
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 8.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 9.0),
                                child: Text(
                                  '${ProductsLocalData.totalNotDisplayedProducts}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => setState(() {
                            ProductsLocalData.products.clear();
                            ProductsLocalData.currentProductPageFilter = 0;
                            ProductsLocalData.currentProductPage = 1;
                            getFilteredProducts(0, 8);
                          }),
                        ),
                        Container(
                          height: 1.5,
                          width: 25.0,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'معروض',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.0,
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 8.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 9.0),
                                child: Text(
                                  '${ProductsLocalData.totalDisplayedProducts}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => setState(() {
                            ProductsLocalData.products.clear();
                            ProductsLocalData.currentProductPage = 1;
                            ProductsLocalData.currentProductPageFilter = 1;
                            getFilteredProducts(1, 8);
                          }),
                        ),
                        Container(
                          height: 1.5,
                          width: 25.0,
                          color: Colors.deepPurpleAccent,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                inflateProductsList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inflateProductsList() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(ProductsLocalData.products.length, (index) {
        return Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () =>
                        getProductDetails(ProductsLocalData.products[index]),
                    child: Container(
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 3.0),
                                  child: Text(
                                    _presenter.getProductStatus(
                                        ProductsLocalData
                                            .products[index].status),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  decoration: BoxDecoration(
                                    color: _presenter.getProductStatusColor(
                                        ProductsLocalData
                                            .products[index].status),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Opacity(
                              opacity: _presenter.getQuantityVisibilityStatus(
                                  ProductsLocalData.products[index].quantity),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      ProductsLocalData.products[index].quantity
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ArabicUiDisplay',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.deepOrangeAccent),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              ProductsLocalData.products[index].imageLink),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ProductsLocalData.products[index].name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7.0),
                            child: Text(
                              'ريال',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontFamily: 'ArabicUiDisplay',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            ProductsLocalData.products[index].price.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ));
      }),
    );
  }

  void onAddProductPressed() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _getProductCategory
        .getProductCategory(ProductsLocalData.productsCategoryServiceLink,
            ProductsLocalData.userLoggedInToken)
        .then((productCategory) async {
      ProductsLocalData.categoriesList = productCategory.data;
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      final bool _isPageReturned = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddProduct()));
      if (_isPageReturned)
        setState(() {
          ProductsLocalData.currentProductPage = 1;
          getFilteredProducts(1, 8);
        });
    });
  }

  void getFilteredProducts(int pageFilter, int productsNumber) {
    try {
      LoadingDialog.showLoadingDialog(context, _keyLoader);
      _getProducts
          .getProducts(
              ProductsLocalData.productsServiceLink,
              ProductsLocalData.userLoggedInToken,
              '$productsNumber',
              '${ProductsLocalData.currentProductPage}',
              '$pageFilter')
          .then((productsResponse) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        setState(() {
          ProductsLocalData.products.addAll(productsResponse.data);
          ProductsLocalData.totalProducts = productsResponse.totalProducts;
          ProductsLocalData.totalDisplayedProducts =
              productsResponse.totalActive;
          ProductsLocalData.totalNotDisplayedProducts =
              productsResponse.totalNotActive;
          ProductsLocalData.totalEmptyQuantityProducts =
              productsResponse.totalEmpty;
        });
      });
    } catch (error) {
      showToast();
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    }
  }

  SingleProduct passSingleProductToRequestTap(int index) {
    ProductsLocalData.singleProduct = ProductsLocalData.products[index];
    return ProductsLocalData.products[index];
  }

  getProductDetails(SingleProduct singleProduct) {
    try {
      LoadingDialog.showLoadingDialog(context, _keyLoader);
      ProductsLocalData.productId = singleProduct.id;

      _getProductDetails
          .getProductDetails(
              ProductsLocalData.productDetailsServiceLink,
              ProductsLocalData.productId.toString(),
              ProductsLocalData.userLoggedInToken)
          .then((response) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        ProductsLocalData.productOtherImagesList = response.data.otherImages;
        ProductsLocalData.productDetails = response.data;
        ProductsLocalData.stockTransfer = response.data.stockTransfer;
        moveToProductDetails(singleProduct);
      });
    } catch (error) {
      print(error);
    }
  }

  void moveToProductDetails(SingleProduct singleProduct) async {
    ProductsLocalData.singleProduct = singleProduct;
    final _singleProduct = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductDetails()));
    _singleProduct != null
        ? removeItemFromDisplayedList(_singleProduct)
        : getNewProductsList();
  }

  getNewProductsList() {
    if (ProductsLocalData.productUpdateState)
      setState(() => getFilteredProducts(1, 8));
  }

  removeItemFromDisplayedList(SingleProduct singleProduct) {
    setState(() {
      ProductsLocalData.products.remove(singleProduct);
      getFilteredProducts(1, 8);
    });
  }

  void showToast() {
    Toast.show('من فضلك تحقق من اتصال الإنترنت لديك', context,
        duration: 3, gravity: Toast.BOTTOM);
  }
}
