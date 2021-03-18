import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_go/dialogs/delete_photo_dialog.dart';
import 'package:store_go/dialogs/exit_add_product-dialog.dart';
import 'package:store_go/dialogs/image_dialog.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:store_go/products/model/entities/new_product_other_image.dart';
import 'package:store_go/products/model/entities/product_category_response.dart';
import 'package:store_go/products/model/services/files/delete_selected_image.dart';
import 'package:store_go/products/model/services/files/upload_selected_image.dart';
import 'package:store_go/products/model/services/products/save_product.dart';
import 'package:store_go/products/presenter/products_presenter.dart';
import 'package:toast/toast.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int currentId;
  int currentIndex;
  int categoryId;

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

  DeleteSelectedImage _deleteSelectedImage;
  GetSaveProductResponse _getSaveProductResponse;
  UploadSelectedImage _uploadSelectedImage;
  ProductsPresenter _presenter;
  NewProductOtherImage singleNewOtherImage;

  List<SingleCategory> categoriesList = ProductsLocalData.categoriesList;
  List<NewProductOtherImage> newProductOtherImages = [];
  List<String> productOtherImagesNames = [];

  String dropdownValue = ProductsLocalData.categoriesList[0].name;
  String mainProductImage = '';
  String mainProductImageFileName;
  String imageListFileName;

  int additionalImageId;

  @override
  void initState() {
    _presenter = ProductsPresenter();
    _getSaveProductResponse = GetSaveProductResponse();
    _uploadSelectedImage = UploadSelectedImage();
    _deleteSelectedImage = DeleteSelectedImage();
    singleNewOtherImage = NewProductOtherImage();

    mainImageStatus = false;
    isQuantityToggleChecked = true;
    isStateToggleChecked = false;
    isTextFieldEnabled = false;

    newProductOtherImages = [
      NewProductOtherImage(
          imageId: 0,
          imageState: false,
          imageName: 'images/no_image.jpg',
          imagePath: ''),
      NewProductOtherImage(
          imageId: 1,
          imageState: false,
          imageName: 'images/no_image.jpg',
          imagePath: ''),
      NewProductOtherImage(
          imageId: 2,
          imageState: false,
          imageName: 'images/no_image.jpg',
          imagePath: ''),
      NewProductOtherImage(
          imageId: 3,
          imageState: false,
          imageName: 'images/no_image.jpg',
          imagePath: ''),
      NewProductOtherImage(
          imageId: 4,
          imageState: false,
          imageName: 'images/no_image.jpg',
          imagePath: ''),
      NewProductOtherImage(
          imageId: 5,
          imageState: false,
          imageName: 'images/no_image.jpg',
          imagePath: '')
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          ExitAddProductDialog.showExitAddProductDialog(context, () {
        Navigator.pop(context);
        Navigator.pop(context, false);
      }),
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
                        Text('إضافة منتج',
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
                              ExitAddProductDialog.showExitAddProductDialog(
                                  context, () {
                            Navigator.pop(context);
                            Navigator.pop(context, false);
                          }),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
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
                                        onTap: () => categoryId = value.id,
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
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      textAlign: TextAlign.center,
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
                                      Opacity(
                                        child: GestureDetector(
                                          child: Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(Icons.remove,
                                                color: Colors.white),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          ),
                                          onTap: () => DeleteProductImageDialog
                                              .showDeleteProductImageDialog(
                                                  context,
                                                  _keyLoader3,
                                                  removeMainImage, () {
                                            Navigator.of(
                                                    _keyLoader3.currentContext,
                                                    rootNavigator: true)
                                                .pop();
                                          }),
                                        ),
                                        opacity: _presenter
                                            .getMainImageDeleteButtonOpacity(
                                                mainImageStatus),
                                      ),
                                      SizedBox(width: 5.0),
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
                                image: _presenter.loadingImageTypeHandler(
                                    mainImageStatus,
                                    'images/no_image.jpg',
                                    mainProductImage),
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
                      child: inflateAdditionalImagesList(),
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
                            onPressed: () => _presenter.validateProductAddition(
                                mainImageStatus,
                                _productNameController.text.toString(),
                                _productPriceController.text.toString(),
                                showToast,
                                onSaveProductClicked),
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                              child: Text('إضافة منتج',
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
    return GridView.count(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      crossAxisCount: 3,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(newProductOtherImages.length, (index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Container(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0, top: 5.0),
                    child: Opacity(
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
                                currentId =
                                    newProductOtherImages[index].imageId;
                                currentIndex = index;
                                imageListFileName =
                                    newProductOtherImages[index].imageName;
                                DeleteProductImageDialog
                                    .showDeleteProductImageDialog(context,
                                        _keyLoader3, removeImageFromList, () {
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
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),
                              onTap: () {
                                singleNewOtherImage =
                                    newProductOtherImages[index];
                                currentId =
                                    newProductOtherImages[index].imageId;
                                productOtherImagesNames.removeAt(index);
                                getImage();
                              },
                            ),
                          ],
                        ),
                      ),
                      opacity: _presenter.getAdditionalImageDeleteButtonOpacity(
                          newProductOtherImages[index].imageState),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: _presenter.loadingImageTypeHandler(
                        newProductOtherImages[index].imageState,
                        newProductOtherImages[index].imageName,
                        newProductOtherImages[index].imagePath),
                    fit: BoxFit.cover),
              ),
            ),
            onTap: () {
              currentId = newProductOtherImages[index].imageId;
              getImage();
            },
          ),
        );
      }),
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
    else
      updateOtherImagesList(returnedPath, returnedFileName);
  }

  updateMainImage(String returnedFileName, String returnedImage) {
    setState(() {
      mainImageStatus = true;
      mainProductImage = returnedImage;
      mainProductImageFileName = returnedFileName;
    });
  }

  updateOtherImagesList(String returnedPath, String returnedFileName) {
    final otherNewImage =
        newProductOtherImages.firstWhere((item) => item.imageId == currentId);
    productOtherImagesNames.add(returnedFileName);
    setState(() {
      otherNewImage.imagePath = returnedPath;
      otherNewImage.imageState = true;
    });
  }

  //Remove Image part
  void removeMainImage() {
    Navigator.of(_keyLoader3.currentContext, rootNavigator: true).pop();
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _deleteSelectedImage
        .getDeleteResponse(
            ProductsLocalData.deleteFileServiceLink,
            ProductsLocalData.userLoggedInAcceptLanguage,
            mainProductImageFileName,
            ProductsLocalData.userLoggedInToken)
        .then((deleteResponse) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      mainImageStatus = false;
      setState(() => mainProductImage = deleteResponse.defaultImage);
    });
  }

  void removeImageFromList() {
    productOtherImagesNames.removeAt(currentIndex);
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _deleteSelectedImage
        .getDeleteResponse(
            ProductsLocalData.deleteFileServiceLink,
            ProductsLocalData.userLoggedInAcceptLanguage,
            imageListFileName,
            ProductsLocalData.userLoggedInToken)
        .then((deleteResponse) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Navigator.of(_keyLoader3.currentContext, rootNavigator: true).pop();
      setState(() {
        final otherNewImage = newProductOtherImages
            .firstWhere((item) => item.imageId == currentId);
        otherNewImage.imagePath = '';
        otherNewImage.imageName = 'images/no_image.jpg';
        otherNewImage.imageState = false;
      });
    });
  }

  void onSaveProductClicked() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    try {
      _getSaveProductResponse
          .getSaveResponse(
              ProductsLocalData.productSaveServiceLink,
              ProductsLocalData.userLoggedInToken,
              _productNameController.text.toString(),
              _presenter.productCategoryController(categoryId),
              _productPriceController.text.toString(),
              _presenter
                  .descriptionTextController(_productDescriptionController),
              _presenter
                  .getProductQuantityState(isQuantityToggleChecked)
                  .toString(),
              _presenter.quantityTextController(
                  _productQuantityController, isQuantityToggleChecked),
              _presenter
                  .getProductDisplayState(isStateToggleChecked)
                  .toString(),
              mainProductImageFileName,
              productOtherImagesNames)
          .then((saveResponse) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Navigator.pop(context, true);
      });
    } catch (error) {
      print(error);
    }
  }

  void showToast() {
    Toast.show(ProductsLocalData.additionMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  @override
  void dispose() {
    productOtherImagesNames.clear();
    _productNameController.dispose();
    _productSectionController.dispose();
    _productPriceController.dispose();
    _productDescriptionController.dispose();
    _productQuantityController.dispose();
    super.dispose();
  }
}
