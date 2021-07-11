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
import 'package:store_go/widgets/text_drawer.dart';
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
                          TextDrawer(
                              text: 'تفاصيل المنتج',
                              maxLines: 1,
                              fontWeight: FontWeight.w600,
                              fontSize: 26.0,
                              color: Colors.black),
                          GestureDetector(
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey[500], size: 40.0),
                              onTap: () => Navigator.pop(context))
                        ]),
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
                                            borderRadius:
                                                BorderRadius.circular(13.0),
                                            side: BorderSide(
                                                color: Colors.red,
                                                width: 1.5))),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.only(top: 9.0, bottom: 9.0)),
                                  ),
                                  onPressed: () => DeleteProductDialog
                                          .showDeleteProductDialog(
                                              context,
                                              _keyLoader2,
                                              deleteCurrentProduct, () {
                                        Navigator.of(context).pop();
                                      }),
                                  child: TextDrawer(
                                      text: 'حذف',
                                      textAlign: TextAlign.center,
                                      fontSize: 15.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500))),
                          SizedBox(width: 15.0),
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
                                        EdgeInsets.only(top: 9.0, bottom: 9.0)),
                                  ),
                                  onPressed: onEditProductPressed,
                                  child: TextDrawer(
                                      text: 'تعديل',
                                      textAlign: TextAlign.center,
                                      fontSize: 15.0,
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.w500)))
                        ]),
                    SizedBox(height: 8.0),
                    ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, maxHeight: 300.0),
                        child: Container(
                          child: Stack(children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 10.0),
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8.0, bottom: 3.0),
                                      child: TextDrawer(
                                          text:
                                              '${_presenter.getProductDisplayedState(_productDetails.status)}',
                                          textAlign: TextAlign.center,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                      decoration: BoxDecoration(
                                          color:
                                              _presenter.getProductStatusColor(
                                                  _productDetails.status),
                                          borderRadius:
                                              BorderRadius.circular(15.0))),
                                )),
                            Opacity(
                                opacity: 1.0,
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, left: 8.0),
                                      child: Container(
                                          padding: EdgeInsets.all(13.0),
                                          child: TextDrawer(
                                              text:
                                                  '${_presenter.getProductQuantity(_productDetails.quantity)}',
                                              textAlign: TextAlign.center,
                                              textOverflow:
                                                  TextOverflow.visible,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.deepOrangeAccent)),
                                    ))),
                          ]),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: NetworkImage(_productDetails.image),
                                fit: BoxFit.cover,
                              )),
                        )),
                    SizedBox(height: 8.0),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextDrawer(
                              text: '${_productDetails.name}',
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              maxLines: 1),
                          SizedBox(height: 2.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextDrawer(
                                    text:
                                        '${_presenter.getProductQuantity(_productDetails.quantity)}',
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                    maxLines: 1),
                                SizedBox(width: 5.0),
                                TextDrawer(
                                    text: ': الكمية',
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0,
                                    maxLines: 1)
                              ]),
                          SizedBox(height: 2.0),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextDrawer(
                                    text: 'ريال',
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    maxLines: 1),
                                SizedBox(width: 10.0),
                                TextDrawer(
                                    text: '${_productDetails.price}',
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    maxLines: 1)
                              ]),
                          SizedBox(height: 2.0),
                          TextDrawer(
                              text:
                                  '${_presenter.getProductDescription(_productDetails.description)}',
                              textAlign: TextAlign.center,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                              maxLines: 3)
                        ]),
                    SizedBox(height: 8.0),
                    TextDrawer(
                        text: 'حركة مخزون المنتج',
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
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
                                  child: TextDrawer(
                                      text: 'تاريخ العملية',
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.0,
                                      maxLines: 1,
                                      textAlign: TextAlign.center),
                                  flex: 2),
                              Expanded(
                                child: drawStockSectionsText(
                                    'الرصيد', Colors.grey[800], 13.0),
                                flex: 1,
                              ),
                              Expanded(
                                child: drawStockSectionsText(
                                    'الكمية', Colors.grey[800], 13.0),
                                flex: 1,
                              ),
                              Expanded(
                                child: drawStockSectionsText(
                                    'المصدر', Colors.grey[800], 13.0),
                                flex: 2,
                              ),
                              Expanded(
                                child: drawStockSectionsText(
                                    'نوع العملية', Colors.grey[800], 13.0),
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
                              child: drawStockSectionsText(
                                  _stockTransfer[index]
                                      .operationDate
                                      .toString(),
                                  Colors.grey[700],
                                  12.0),
                              flex: 2,
                            ),
                            Expanded(
                              child: drawStockSectionsText(
                                  _stockTransfer[index].balance.toString(),
                                  Colors.grey[700],
                                  12.0),
                              flex: 1,
                            ),
                            Expanded(
                              child: drawStockSectionsText(
                                  _stockTransfer[index].quantity.toString(),
                                  Colors.grey[700],
                                  12.0),
                              flex: 1,
                            ),
                            Expanded(
                              child: drawStockSectionsText(
                                  _stockTransfer[index].source.toString(),
                                  Colors.grey[700],
                                  12.0),
                              flex: 2,
                            ),
                            Expanded(
                                child: TextDrawer(
                                    text:
                                        '${_stockTransfer[index].operationType}',
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                    textAlign: TextAlign.center,
                                    maxLines: 1),
                                flex: 1),
                          ],
                        );
                      },
                    ))
                  ],
                )),
              )),
        ));
  }

  Widget drawStockSectionsText(
      String sectionText, Color textColor, double fontSize) {
    return TextDrawer(
        text: sectionText,
        color: Colors.grey[800],
        fontWeight: FontWeight.w600,
        fontSize: 13.0,
        textAlign: TextAlign.center,
        maxLines: 1);
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
    Navigator.of(context).pop();
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

    Navigator.of(context).pop();
    Navigator.of(context).pop();

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
