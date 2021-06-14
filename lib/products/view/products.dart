import 'package:store_go/products/model/services/products/add_product_category.dart';
import 'package:store_go/products/model/services/products/get_product_details.dart';
import 'package:store_go/products/model/services/products/get_products_api.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:store_go/products/model/entities/single_product.dart';
import 'package:store_go/products/presenter/products_presenter.dart';
import 'package:store_go/store/model/data/store_local_data.dart';
import 'package:store_go/products/view/product_details.dart';
import 'package:store_go/products/view/product_item.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'add_new_product.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final _productsScrollController = ScrollController();
  final _getProductCategory = GetProductCategory();
  final _getProductDetails = GetProductDetails();
  final _keyLoader = new GlobalKey<State>();
  final _presenter = ProductsPresenter();
  final _getProducts = GetProducts();

  ProductsLocalData localData;
  bool enableInteraction = true;

  @override
  void initState() {
    localData = ProductsLocalData();
    super.initState();
    ProductsLocalData.products = StoreLocalData.storeProducts;
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
                SizedBox(height: 15.0),
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
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          side: BorderSide(
                                              color: Colors.deepPurpleAccent,
                                              width: 1.5))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(13.0)),
                                ),
                                onPressed: onAddProductPressed,
                                child: TextDrawer(
                                    text: 'إضافة منتج',
                                    textAlign: TextAlign.center,
                                    fontSize: 19.0,
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w500))),
                        TextDrawer(
                            text: 'المنتجات',
                            maxLines: 1,
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0,
                            color: Colors.black),
                        SizedBox(width: 5.0),
                        GestureDetector(
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: Colors.grey[500], size: 40.0),
                            onTap: () => Navigator.pop(context))
                      ],
                    )),
                IgnorePointer(
                    ignoring: _presenter.getInteractionState(enableInteraction),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextDrawer(
                                              text: 'منتهى الكمية',
                                              textAlign: TextAlign.center,
                                              color: Colors.grey[600],
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(width: 8.0),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0),
                                              child: TextDrawer(
                                                  text:
                                                      '${ProductsLocalData.totalEmptyQuantityProducts}',
                                                  textAlign: TextAlign.center,
                                                  color: Colors.grey[600],
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400)),
                                        ]),
                                    onTap: () => setState(() {
                                          enableInteraction = false;
                                          ProductsLocalData.products.clear();
                                          ProductsLocalData
                                              .currentProductPageFilter = 2;
                                          ProductsLocalData.currentProductPage =
                                              1;
                                          getFilteredProducts(2, 8);
                                        })),
                                Container(
                                    height: 1.5,
                                    width: 25.0,
                                    color: Colors.deepOrangeAccent),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextDrawer(
                                              text: 'غير معروض',
                                              textAlign: TextAlign.center,
                                              color: Colors.grey[600],
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(width: 8.0),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0),
                                              child: TextDrawer(
                                                  text:
                                                      '${ProductsLocalData.totalNotDisplayedProducts}',
                                                  textAlign: TextAlign.center,
                                                  color: Colors.grey[600],
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400)),
                                        ]),
                                    onTap: () => setState(() {
                                          enableInteraction = false;
                                          ProductsLocalData.products.clear();
                                          ProductsLocalData
                                              .currentProductPageFilter = 0;
                                          ProductsLocalData.currentProductPage =
                                              1;
                                          getFilteredProducts(0, 8);
                                        })),
                                Container(
                                    height: 1.5,
                                    width: 25.0,
                                    color: Colors.red),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextDrawer(
                                              text: 'معروض',
                                              textAlign: TextAlign.center,
                                              color: Colors.grey[600],
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(width: 8.0),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0),
                                              child: TextDrawer(
                                                  text:
                                                      '${ProductsLocalData.totalDisplayedProducts}',
                                                  textAlign: TextAlign.center,
                                                  color: Colors.grey[600],
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400)),
                                        ]),
                                    onTap: () => setState(() {
                                          enableInteraction = false;
                                          ProductsLocalData.products.clear();
                                          ProductsLocalData.currentProductPage =
                                              1;
                                          ProductsLocalData
                                              .currentProductPageFilter = 1;
                                          getFilteredProducts(1, 8);
                                        })),
                                Container(
                                    height: 1.5,
                                    width: 25.0,
                                    color: Colors.deepPurpleAccent),
                              ]),
                        ])),
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
        return ProductItem(
          imageLink: ProductsLocalData.products[index].imageLink,
          name: ProductsLocalData.products[index].name,
          opacityValue: _presenter.getQuantityVisibilityStatus(
              ProductsLocalData.products[index].quantity),
          price: ProductsLocalData.products[index].price.toString(),
          quantity: ProductsLocalData.products[index].quantity.toString(),
          status: _presenter
              .getProductStatus(ProductsLocalData.products[index].status),
          statusColor: _presenter
              .getProductStatusColor(ProductsLocalData.products[index].status),
          productClickHandler: () {
            ProductsLocalData.singleProduct = ProductsLocalData.products[index];
            getProductDetails();
          },
        );
      }),
    );
  }

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

  void onAddProductPressed() {
    enableInteraction = false;
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _getProductCategory
        .getProductCategory(
            localData.productsCategoryServiceLink, localData.userLoggedInToken)
        .then((productCategory) async {
      enableInteraction = true;
      ProductsLocalData.categoriesList = productCategory.data;
      Navigator.of(context).pop();

      final _isPageReturned = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddProduct()));
      _presenter.checkPageReturnState(
          _isPageReturned,
          () => setState(() {
                ProductsLocalData.currentProductPage = 1;
                getFilteredProducts(1, 8);
              }));
    });
  }

  void getFilteredProducts(int pageFilter, int productsNumber) {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _getProducts
        .getProducts(
            localData.productsServiceLink,
            localData.userLoggedInToken,
            '$productsNumber',
            '${ProductsLocalData.currentProductPage}',
            '$pageFilter')
        .then((productsResponse) {
      enableInteraction = true;
      Navigator.of(context).pop();

      ProductsLocalData.productsResponse = productsResponse;
      _presenter.checkConnectionStatus(ProductsLocalData.networkConnectionState,
          onFilteredProductsConnectionSuccess, showToast);
    });
  }

  void onFilteredProductsConnectionSuccess() => setState(() {
        ProductsLocalData.products
            .addAll(ProductsLocalData.productsResponse.data);
        ProductsLocalData.totalProducts =
            ProductsLocalData.productsResponse.totalProducts;
        ProductsLocalData.totalDisplayedProducts =
            ProductsLocalData.productsResponse.totalActive;
        ProductsLocalData.totalNotDisplayedProducts =
            ProductsLocalData.productsResponse.totalNotActive;
        ProductsLocalData.totalEmptyQuantityProducts =
            ProductsLocalData.productsResponse.totalEmpty;
      });

  SingleProduct passSingleProductToRequestTap(int index) {
    ProductsLocalData.singleProduct = ProductsLocalData.products[index];
    return ProductsLocalData.products[index];
  }

  getProductDetails() {
    enableInteraction = false;
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    ProductsLocalData.productId = ProductsLocalData.singleProduct.id;

    _getProductDetails
        .getProductDetails(localData.productDetailsServiceLink,
            ProductsLocalData.productId.toString(), localData.userLoggedInToken)
        .then((response) {
      Navigator.of(context).pop();

      ProductsLocalData.productDetailsResponse = response;
      _presenter.checkConnectionStatus(ProductsLocalData.networkConnectionState,
          onProductDetailsConnectionSuccess, showToast);
    });
  }

  void onProductDetailsConnectionSuccess() {
    enableInteraction = true;
    ProductsLocalData.productOtherImagesList =
        ProductsLocalData.productDetailsResponse.data.otherImages;
    ProductsLocalData.productDetails =
        ProductsLocalData.productDetailsResponse.data;
    ProductsLocalData.stockTransfer =
        ProductsLocalData.productDetailsResponse.data.stockTransfer;
    moveToProductDetails();
  }

  void moveToProductDetails() async {
    final _singleProduct = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductDetails()));
    _presenter.checkObjectActivity(_singleProduct, () => getNewProductsList(),
        () => removeItemFromDisplayedList(_singleProduct));
  }

  getNewProductsList() => _presenter.checkProductUpdateState(
      ProductsLocalData.productUpdated,
      () => setState(() {
            ProductsLocalData.products.clear();
            ProductsLocalData.currentProductPage = 1;
            ProductsLocalData.currentProductPageFilter = 1;
            getFilteredProducts(1, 8);
          }));

  removeItemFromDisplayedList(SingleProduct singleProduct) {
    setState(() {
      ProductsLocalData.products.remove(singleProduct);
      ProductsLocalData.products.clear();
      ProductsLocalData.currentProductPage = 1;
      ProductsLocalData.currentProductPageFilter = 1;
      getFilteredProducts(1, 8);
    });
  }

  void showToast() {
    Navigator.pop(context);
    Toast.show('من فضلك تحقق من اتصال الإنترنت لديك', context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  @override
  void dispose() {
    _productsScrollController.dispose();
    super.dispose();
  }
}
