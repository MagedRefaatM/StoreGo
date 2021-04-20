import 'package:store_go/products/model/services/products/add_product_category.dart';
import 'package:store_go/products/model/entities/product_details_get_response.dart';
import 'package:store_go/products/model/entities/product_category_response.dart';
import 'package:store_go/products/model/entities/product_delete_response.dart';
import 'package:store_go/products/model/services/products/delete_product.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:store_go/products/presenter/products_presenter.dart';
import 'package:store_go/dialogs/delete_product_dialog.dart';
import 'package:store_go/products/view/update_product.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _getProductCategory = GetProductCategory();
  final _productDetails = ProductsLocalData.productDetails;
  final _stockTransfer = ProductsLocalData.stockTransfer;
  final _deleteProduct = DeleteProduct();
  final _keyLoader2 = new GlobalKey<State>();
  final _keyLoader = new GlobalKey<State>();
  final _presenter = ProductsPresenter();

  ProductsLocalData localData;

  @override
  void initState() {
    localData = ProductsLocalData();
    ProductsLocalData.productUpdateState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15.0),
                      SizedBox(),
                      Text(
                        'تفاصيل المنتج',
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
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                    side: BorderSide(
                                        color: Colors.red, width: 1.5))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(top: 9.0, bottom: 9.0)),
                          ),
                          onPressed: () =>
                              DeleteProductDialog.showDeleteProductDialog(
                                  context, _keyLoader2, deleteCurrentProduct,
                                  () {
                            Navigator.of(_keyLoader2.currentContext,
                                    rootNavigator: true)
                                .pop();
                          }),
                          child: Text(
                            'حذف',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.red,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
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
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(top: 9.0, bottom: 9.0)),
                          ),
                          onPressed: onEditProductPressed,
                          child: Text(
                            'تعديل',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.deepPurpleAccent,
                                fontFamily: 'ArabicUiDisplay',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, maxHeight: 300.0),
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
                                    '${_presenter.getProductDisplayedState(_productDetails.status)}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  decoration: BoxDecoration(
                                    color: _presenter.getProductStatusColor(
                                        _productDetails.status),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              )),
                          Opacity(
                            opacity: 1.0,
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5.0, left: 5.0),
                                  child: Container(
                                    padding: EdgeInsets.all(13.0),
                                    child: Text(
                                      '${_presenter.getProductQuantity(_productDetails.quantity)}',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ArabicUiDisplay',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.deepOrangeAccent),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(_productDetails.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${_productDetails.name}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'ArabicUiDisplay',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                        maxLines: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${_presenter.getProductQuantity(_productDetails.quantity)}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            ': الكمية',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                            ),
                            maxLines: 1,
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ريال',
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            '${_productDetails.price}',
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontFamily: 'ArabicUiDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                            maxLines: 1,
                          )
                        ],
                      ),
                      Text(
                        '${_presenter.getProductDescription(_productDetails.description)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'ArabicUiDisplay',
                          fontWeight: FontWeight.w600,
                          fontSize: 13.0,
                        ),
                        maxLines: 2,
                      )
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text('حركة مخزون المنتج',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'ArabicUiDisplay',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      maxLines: 1),
                  SizedBox(height: 8.0),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text('تاريخ العملية',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text('الرصيد',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1),
                              flex: 1,
                            ),
                            Expanded(
                              child: Text('الكمية',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1),
                              flex: 1,
                            ),
                            Expanded(
                              child: Text('المصدر',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text('نوع العملية',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1),
                              flex: 1,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _stockTransfer.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child:
                                  Text('${_stockTransfer[index].operationDate}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1),
                              flex: 2,
                            ),
                            Expanded(
                              child: Text('${_stockTransfer[index].balance}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1),
                              flex: 1,
                            ),
                            Expanded(
                              child: Text(
                                  '${_stockTransfer[index].quantity.toString()}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1),
                              flex: 1,
                            ),
                            Expanded(
                              child: Text('${_stockTransfer[index].source}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1),
                              flex: 2,
                            ),
                            Expanded(
                              child:
                                  Text('${_stockTransfer[index].operationType}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontFamily: 'ArabicUiDisplay',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1),
                              flex: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onEditProductPressed() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _getProductCategory
        .getProductCategory(
            localData.productsCategoryServiceLink, localData.userLoggedInToken)
        .then((productCategory) => _presenter.checkConnectionStatus(
            ProductsLocalData.networkConnectionState,
            () => successProductCategoryConnection(productCategory),
            () => showToast));
  }

  successProductCategoryConnection(ProductCategoryResponse productCategory) {
    ProductsLocalData.categoriesList = productCategory.data;
    ProductsLocalData.productImageStatus = _productDetails.imageStatus;
    Navigator.of(_keyLoader.currentContext, rootNavigator: true ?? context).pop();
    moveToEditProduct();
  }

  void deleteCurrentProduct() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _deleteProduct
        .deleteProduct(localData.productDeleteServiceLink,
            localData.userLoggedInToken, ProductsLocalData.productId.toString())
        .then((deleteResponse) => _presenter.checkConnectionStatus(
            ProductsLocalData.networkConnectionState,
            () => successDeleteConnection(deleteResponse),
            () => showToast));
  }

  successDeleteConnection(ProductDeleteResponse deleteResponse) {
    ProductsLocalData.deleteResultMessage = deleteResponse.message;

    Navigator.of(_keyLoader.currentContext, rootNavigator: true ?? context).pop();
    Navigator.of(_keyLoader2.currentContext, rootNavigator: true ?? context).pop();

    ProductsLocalData.products.remove(ProductsLocalData.singleProduct);
    Navigator.pop(context, ProductsLocalData.singleProduct);
  }

  void moveToEditProduct() async {
    final _product = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProduct()));
    _presenter.checkObjectActivity(_product, () => updateIgnoreCase(),
        () => updateDisplayedProduct(_product));
  }

  updateIgnoreCase() {
    ProductsLocalData.productUpdated = false;
    Navigator.pop(context);
  }

  updateDisplayedProduct(Data product) {
    setState(() {
      ProductsLocalData.updateModel(ProductsLocalData.productDetails, product);
      ProductsLocalData.stockTransfer.replaceRange(
          0, ProductsLocalData.stockTransfer.length, product.stockTransfer);
      ProductsLocalData.productOtherImagesList.replaceRange(0,
          ProductsLocalData.productOtherImagesList.length, product.otherImages);
      updateMainProducts(product);
    });
  }

  void updateMainProducts(Data product) {
    final _singleProduct =
        ProductsLocalData.products.firstWhere((item) => item.id == product.id);
    _singleProduct.createdAt = product.createdAt;
    _singleProduct.price = product.price;
    _singleProduct.status = int.parse(product.status.toString());
    _singleProduct.name = product.name.toString();
    _singleProduct.quantity = product.quantity;
    _singleProduct.imageLink = product.image;
  }

  void showToast() {
    Navigator.pop(context);
    Toast.show('من فضلك تحقق من اتصال الإنترنت لديك', context,
        duration: 3, gravity: Toast.BOTTOM);
  }
}
