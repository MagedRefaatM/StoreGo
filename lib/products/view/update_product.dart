import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_go/dialogs/delete_photo_dialog.dart';
import 'package:store_go/dialogs/exit_edit_product_dialog.dart';
import 'package:store_go/dialogs/image_dialog.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:store_go/products/model/entities/product_category_response.dart';
import 'package:store_go/products/model/entities/product_details_get_response.dart';
import 'package:store_go/products/model/services/files/upload_selected_image.dart';
import 'package:store_go/products/model/services/products/update_product_api.dart';
import 'package:store_go/products/presenter/products_presenter.dart';
import 'package:toast/toast.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  GetUpdateProductResponse _getUpdateProductResponse;
  ProductsPresenter _presenter = ProductsPresenter();
  UploadSelectedImage _uploadSelectedImage;

  List<SingleCategory> categoriesList = ProductsLocalData.categoriesList;
  List<String> productOtherImages = [];
  List<String> productOtherDeletedImages = [];

  String dropdownValue = ProductsLocalData.categoriesList[0].name;
  String mainProductImage;
  String mainProductImageFileName;

  int idAutoIncrement = 0;

  bool isQuantityToggleChecked;
  bool isStateToggleChecked;
  bool isTextFieldEnabled;
  bool mainImageStatus;

  final _productNameController = TextEditingController();
  final _productSectionController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _keyLoader = new GlobalKey<State>();
  final _keyLoader2 = new GlobalKey<State>();
  final _keyLoader3 = new GlobalKey<State>();
  final _picker = ImagePicker();

  @override
  void initState() {
    _getUpdateProductResponse = GetUpdateProductResponse();
    _uploadSelectedImage = UploadSelectedImage();

    //Data Integrity
    isQuantityToggleChecked = _presenter
        .getQuantityToggleState(ProductsLocalData.productDetails.quantity);
    isStateToggleChecked = _presenter
        .getDisplayStateToggle(ProductsLocalData.productDetails.status);
    isTextFieldEnabled =
        _presenter.getTextFieldDisplayStatus(isQuantityToggleChecked);

    mainImageStatus = ProductsLocalData.productImageStatus;
    mainProductImage = ProductsLocalData.productDetails.image;
    mainProductImageFileName = ProductsLocalData.productDetails.mainImageName;
    ProductsLocalData.imageFileName = mainProductImageFileName;

    productOtherImages = ProductsLocalData.productDetails.otherImagesNames;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ExitEditProductDialog.showExitEditProductDialog(
          context, onBackPressed),
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 40.0),
                        Text('تعديل',
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ArabicUiDisplay',
                                fontSize: 21.0,
                                color: Colors.black)),
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey[500],
                            size: 40.0,
                          ),
                          onTap: () =>
                              ExitEditProductDialog.showExitEditProductDialog(
                                  context, onBackPressed),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      controller: _productNameController,
                      maxLines: 1,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                          ),
                          hintStyle: new TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                          ),
                          labelText: ProductsLocalData.productDetails.name,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'ArabicUiDisplay',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                          hintText: "اسم المنتج",
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: DropdownButtonHideUnderline(
                                child: Center(
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      "قسم المنتج",
                                      textAlign: TextAlign.center,
                                    ),
                                    isDense: true,
                                    isExpanded: false,
                                    value: dropdownValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: categoriesList
                                        .map((SingleCategory value) {
                                      return DropdownMenuItem<String>(
                                        value: value.name,
                                        onTap: () {
                                          ProductsLocalData.categoryId =
                                              value.id;
                                        },
                                        child: Text(
                                          value.name,
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: _productPriceController,
                      maxLines: 1,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                          ),
                          hintStyle: new TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                          ),
                          hintText: "السعر",
                          labelText: ProductsLocalData.productDetails.price,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'ArabicUiDisplay',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      controller: _productDescriptionController,
                      maxLines: 4,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                          ),
                          hintStyle: new TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'ArabicUiDisplay',
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                          ),
                          hintText: "الوصف",
                          labelText: _presenter.getProductDescription(
                              ProductsLocalData.productDetails.description),
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'ArabicUiDisplay',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: TextField(
                              controller: _productQuantityController,
                              textInputAction: TextInputAction.done,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              enabled: isTextFieldEnabled,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(8.0),
                                    ),
                                  ),
                                  hintStyle: new TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey[700],
                                  ),
                                  hintText: "الكمية",
                                  labelText: _presenter
                                      .displayQuantityTextFieldLabel(
                                          ProductsLocalData
                                              .productDetails.quantity)
                                      .toString(),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'ArabicUiDisplay',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                  fillColor: Colors.white),
                            ),
                          ),
                          flex: 3,
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          flex: 1,
                          child: FlutterSwitch(
                            value: isQuantityToggleChecked,
                            activeColor: Colors.grey[300],
                            inactiveColor: Colors.deepPurpleAccent,
                            onToggle: (val) {
                              setState(() {
                                isQuantityToggleChecked = val;
                                isTextFieldEnabled = _presenter
                                    .editTextFieldStatus(isTextFieldEnabled);
                                _productQuantityController.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '(${_presenter.getCurrentProductStatus(isStateToggleChecked)})',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'ArabicUiDisplay',
                                      color: Colors.grey[900]),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'حالة العرض',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'ArabicUiDisplay',
                                      color: Colors.grey[900]),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),
                          flex: 3,
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          flex: 1,
                          child: FlutterSwitch(
                            value: isStateToggleChecked,
                            activeColor: Colors.grey[300],
                            inactiveColor: Colors.deepPurpleAccent,
                            onToggle: (val) {
                              setState(() {
                                isStateToggleChecked = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text('صورة المنتج الرئيسية',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ArabicUiDisplay',
                            color: Colors.grey[900])),
                    SizedBox(height: 8.0),
                    ConstrainedBox(
                        child: Container(
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.0, top: 5.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(Icons.edit,
                                              color: Colors.white),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                        ),
                                        onTap: () {
                                          mainImageStatus = false;
                                          getImage();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                image: NetworkImage(mainProductImage),
                                fit: BoxFit.cover),
                          ),
                        ),
                        constraints:
                            BoxConstraints(maxHeight: 140.0, maxWidth: 140.0)),
                    SizedBox(height: 8.0),
                    Text('صور المنتج الإضافية (إختيارى)',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ArabicUiDisplay',
                            color: Colors.grey[900])),
                    SizedBox(height: 8.0),
                    ConstrainedBox(
                      child: _presenter.getCurrentDisplayedWidget(
                          ProductsLocalData.productOtherImagesList.length,
                          inflateAdditionalImagesList(),
                          inflateAddImageTexts()),
                      constraints: BoxConstraints(
                          minWidth: double.infinity, maxHeight: 270.0),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Colors.deepPurpleAccent))),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurpleAccent),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Colors.white)),
                            ),
                            onPressed: () => _presenter.validateProductUpdate(
                                mainImageStatus,
                                showToast,
                                onUpdateProductClicked),
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                              child: Text('تعديل',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'ArabicUiDisplay',
                                    fontWeight: FontWeight.w900,
                                  )),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inflateAdditionalImagesList() {
    return GestureDetector(
      child: GridView.count(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        crossAxisCount: 3,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(ProductsLocalData.productOtherImagesList.length,
            (index) {
          ProductsLocalData.otherImagesIndex = index;
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0, top: 5.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(Icons.remove, color: Colors.white),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            ),
                            onTap: () {
                              ProductsLocalData.currentImageListIndex = index;
                              ProductsLocalData.imageListFileName =
                                  ProductsLocalData
                                      .productOtherImagesList[index].name
                                      .toString();
                              DeleteProductImageDialog
                                  .showDeleteProductImageDialog(
                                      context, _keyLoader3, removeImageFromList,
                                      () {
                                Navigator.of(_keyLoader3.currentContext,
                                        rootNavigator: true)
                                    .pop();
                              });
                            },
                          ),
                          SizedBox(width: 5.0),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(Icons.edit, color: Colors.white),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                            onTap: () {
                              ProductsLocalData.additionalImageId =
                                  ProductsLocalData
                                      .productOtherImagesList[index].id;
                              ProductsLocalData.singleOtherImage =
                                  ProductsLocalData
                                      .productOtherImagesList[index];
                              getImage();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: NetworkImage(
                        ProductsLocalData.productOtherImagesList[index].path),
                    fit: BoxFit.cover),
              ),
            ),
          );
        }),
      ),
      onTap: () {
        ProductsLocalData.additionalImageId = 0;
        ProductsLocalData.singleOtherImage = null;
        getImage();
      },
    );
  }

  Widget inflateAddImageTexts() {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('إضغط هنا لإضافة صور إضافية للمنتج',
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 18.0,
                  fontFamily: 'ArabicUiDisplay',
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 5.0),
          Text('يرجى العلم أنه ستتم إضافة صورة للمنتج رئيسية أولا إن لم توجد',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12.0,
                  fontFamily: 'ArabicUiDisplay',
                  fontWeight: FontWeight.w800)),
        ],
      ),
      onTap: () {
        ProductsLocalData.singleOtherImage = null;
        ProductsLocalData.additionalImageId = 0;
        getImage();
      },
    );
  }

  // Update & Display image part
  void getImage() {
    ImageDialog.showImageDialog(
        context, _keyLoader2, getImageFromGallery, getImageFromCamera);
  }

  Future getImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    File image = File(pickedFile.path);
    uploadImageToServer(
        ProductsLocalData.uploadFileServiceLink,
        ProductsLocalData.userLoggedInToken,
        image,
        image.path.toString(),
        'image');
  }

  Future getImageFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    File image = File(pickedFile.path);
    uploadImageToServer(
        ProductsLocalData.uploadFileServiceLink,
        ProductsLocalData.userLoggedInToken,
        image,
        image.path.toString(),
        'image');
  }

  void uploadImageToServer(String uploadLink, String userToken,
      File selectedFile, String path, String selectedType) {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _uploadSelectedImage
        .uploadImage(uploadLink, userToken, selectedFile, path, selectedType)
        .then((uploadResponse) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Navigator.of(_keyLoader2.currentContext, rootNavigator: true).pop();
      viewImageHandler(
          uploadResponse.path, uploadResponse.fileName, uploadResponse.path);
    });
  }

  void viewImageHandler(
      String returnedImage, String returnedFileName, String returnedPath) {
    if (mainImageStatus == false)
      updateMainImage(returnedFileName, returnedImage);
    else {
      if (ProductsLocalData.singleOtherImage != null &&
          ProductsLocalData.productOtherImagesList
                  .contains(ProductsLocalData.singleOtherImage) ==
              true) {
        productOtherImages.removeAt(ProductsLocalData.otherImagesIndex);
        updateOtherImagesList(returnedPath, returnedFileName);
      } else
        addNewOtherImageList(returnedFileName, returnedPath);
    }
  }

  updateMainImage(String returnedFileName, String returnedImage) {
    setState(() {
      ProductsLocalData.productImageStatus = true;
      mainImageStatus = ProductsLocalData.productImageStatus;
      ProductsLocalData.imageFileName = returnedFileName;
      mainProductImage = returnedImage;
      mainProductImageFileName = returnedFileName;
    });
  }

  updateOtherImagesList(String returnedPath, String returnedFileName) {
    final otherImage = ProductsLocalData.productOtherImagesList
        .firstWhere((item) => item.id == ProductsLocalData.additionalImageId);
    productOtherImages.add(returnedFileName);
    setState(() => otherImage.path = returnedPath);
  }

  addNewOtherImageList(String returnedFileName, String returnedPath) {
    setState(() {
      productOtherImages.add(returnedFileName);
      ProductsLocalData.imageListFileName = returnedFileName;
      ProductsLocalData.productOtherImagesList.add(new OtherImage(
          id: idAutoIncrement = idAutoIncrement + 1,
          name: returnedFileName,
          path: returnedPath));
    });
  }

  //Remove Image part
  void removeImageFromList() {
    productOtherDeletedImages.add(ProductsLocalData.imageListFileName);
    productOtherImages.removeAt(ProductsLocalData.otherImagesIndex);
    if (ProductsLocalData.productOtherImagesList.length == 1) {
      Navigator.of(_keyLoader3.currentContext, rootNavigator: true).pop();
      setState(() => ProductsLocalData.productOtherImagesList
          .removeAt(ProductsLocalData.currentImageListIndex));
      inflateAddImageTexts();
    } else {
      Navigator.of(_keyLoader3.currentContext, rootNavigator: true).pop();
      setState(() => ProductsLocalData.productOtherImagesList
          .removeAt(ProductsLocalData.currentImageListIndex));
    }
  }

  void onUpdateProductClicked() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    try {
      _getUpdateProductResponse
          .getUpdateResponse(
              ProductsLocalData.productUpdateServiceLink,
              ProductsLocalData.userLoggedInToken,
              ProductsLocalData.productDetails.id.toString(),
              _presenter.getTextFieldText(_productNameController,
                  ProductsLocalData.productDetails.name),
              ProductsLocalData.categoryId.toString(),
              _presenter.getTextFieldText(_productPriceController,
                  ProductsLocalData.productDetails.price),
              _presenter.getTextFieldText(_productDescriptionController,
                  ProductsLocalData.productDetails.description),
              _presenter
                  .getProductQuantityState(isQuantityToggleChecked)
                  .toString(),
              _presenter.getTextFieldText(_productQuantityController,
                  ProductsLocalData.productDetails.quantity.toString()),
              _presenter
                  .getProductDisplayState(isStateToggleChecked)
                  .toString(),
              mainProductImageFileName,
              productOtherImages,
              productOtherDeletedImages)
          .then((updateResponse) {
        ProductsLocalData.productUpdateState = true;
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Navigator.pop(context, updateResponse.product);
      });
    } catch (error) {
      print(error);
    }
  }

  void showToast() {
    Toast.show(ProductsLocalData.updateMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  void onBackPressed() {
    mainProductImage = '';
    productOtherImages.clear();
    ProductsLocalData.productUpdated = false;
    ProductsLocalData.productOtherImagesList.clear();
    setState(() {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    productOtherImages.clear();
    _productNameController.dispose();
    _productSectionController.dispose();
    _productPriceController.dispose();
    _productDescriptionController.dispose();
    _productQuantityController.dispose();
    super.dispose();
  }
}
