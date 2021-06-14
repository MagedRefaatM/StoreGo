import 'package:store_go/products/model/services/files/delete_selected_image.dart';
import 'package:store_go/products/model/services/files/upload_selected_image.dart';
import 'package:store_go/products/model/entities/product_category_response.dart';
import 'package:store_go/products/model/entities/new_product_other_image.dart';
import 'package:store_go/products/model/entities/delete_image_response.dart';
import 'package:store_go/products/model/services/products/save_product.dart';
import 'package:store_go/products/model/entities/upload_image_response.dart';
import 'package:store_go/products/model/data/products_local_data.dart';
import 'package:store_go/products/presenter/products_presenter.dart';
import 'package:store_go/dialogs/exit_add_product-dialog.dart';
import 'package:store_go/dialogs/delete_photo_dialog.dart';
import 'package:store_go/drawers//text_field_drawer.dart';
import 'package:store_go/dialogs/loading_dialog.dart';
import 'package:store_go/dialogs/image_dialog.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:store_go/drawers//text_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:io';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _productDescriptionController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _productSectionController = TextEditingController();
  final _getSaveProductResponse = GetSaveProductResponse();
  final _productPriceController = TextEditingController();
  final _productNameController = TextEditingController();
  final _deleteSelectedImage = DeleteSelectedImage();
  final _uploadSelectedImage = UploadSelectedImage();
  final _keyLoader2 = GlobalKey<State>();
  final _keyLoader3 = GlobalKey<State>();
  final _keyLoader = GlobalKey<State>();
  final _presenter = ProductsPresenter();
  final _picker = ImagePicker();

  final _categoriesList = ProductsLocalData.categoriesList;

  var singleNewOtherImage = NewProductOtherImage();

  List<SingleCategory> categoriesList = ProductsLocalData.categoriesList;
  List<NewProductOtherImage> newProductOtherImages = [];
  List<String> productOtherImagesNames = [];

  var mainProductImageFileName;
  var imageListFileName;
  var mainProductImage = '';
  var dropdownValue = ProductsLocalData.categoriesList[0].name;

  var currentIndex;
  var categoryId;
  var currentId;

  var isQuantityToggleChecked;
  var isStateToggleChecked;
  var isTextFieldEnabled;
  var mainImageStatus;

  ProductsLocalData localData;

  @override
  void initState() {
    localData = ProductsLocalData();
    isQuantityToggleChecked = true;
    isStateToggleChecked = false;
    isTextFieldEnabled = false;
    mainImageStatus = false;

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
                          SizedBox(height: 15.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 40.0),
                                TextDrawer(
                                    text: 'إضافة منتج',
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21.0),
                                GestureDetector(
                                    child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.grey[500],
                                        size: 40.0),
                                    onTap: () => ExitAddProductDialog
                                            .showExitAddProductDialog(context,
                                                () {
                                          Navigator.pop(context);
                                          Navigator.pop(context, false);
                                        }))
                              ]),
                          SizedBox(height: 20.0),
                          TextFieldDrawer(
                              textAlign: TextAlign.center,
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.name,
                              controller: _productNameController,
                              maxLines: 1,
                              borderRadius: 8.0,
                              hintFontSize: 15.0,
                              hintText: "اسم المنتج"),
                          SizedBox(height: 8.0),
                          Container(child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                            return InputDecorator(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: DropdownButtonHideUnderline(
                                      child: Center(
                                          child: DropdownButton<String>(
                                        hint: TextDrawer(
                                            text: "قسم المنتج",
                                            textAlign: TextAlign.center),
                                        isDense: true,
                                        isExpanded: false,
                                        value: dropdownValue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: _categoriesList
                                            .map((SingleCategory value) {
                                          return DropdownMenuItem<String>(
                                              value: value.name,
                                              onTap: () =>
                                                  categoryId = value.id,
                                              child: TextDrawer(
                                                  text: value.name,
                                                  textAlign: TextAlign.center));
                                        }).toList(),
                                      )),
                                    )));
                          })),
                          SizedBox(height: 8.0),
                          TextFieldDrawer(
                              textAlign: TextAlign.center,
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.number,
                              controller: _productPriceController,
                              maxLines: 1,
                              borderRadius: 8.0,
                              hintFontSize: 15.0,
                              hintText: "السعر"),
                          SizedBox(height: 8.0),
                          TextFieldDrawer(
                              textAlign: TextAlign.center,
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.multiline,
                              controller: _productDescriptionController,
                              maxLines: 4,
                              borderRadius: 8.0,
                              hintFontSize: 15.0,
                              hintText: "الوصف"),
                          SizedBox(height: 8.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                      child: TextFieldDrawer(
                                        textAlign: TextAlign.center,
                                        inputAction: TextInputAction.done,
                                        inputType: TextInputType.number,
                                        controller: _productQuantityController,
                                        enabled: isTextFieldEnabled,
                                        maxLines: 1,
                                        borderRadius: 8.0,
                                        hintFontSize: 15.0,
                                        hintText: "الكمية",
                                      ),
                                    ),
                                    flex: 3),
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
                                          isTextFieldEnabled =
                                              _presenter.editTextFieldStatus(
                                                  isTextFieldEnabled);
                                          _productQuantityController.clear();
                                        });
                                      },
                                    )),
                              ]),
                          SizedBox(height: 8.0),
                          Row(children: [
                            Expanded(
                                child: Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: TextDrawer(
                                          text: _presenter
                                              .getCurrentProductStatus(
                                                  isStateToggleChecked)
                                              .toString(),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[900],
                                          textAlign: TextAlign.end)),
                                  Expanded(
                                      flex: 1,
                                      child: TextDrawer(
                                          text: 'حالة العرض',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[900],
                                          textAlign: TextAlign.end))
                                ]),
                                flex: 3),
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
                                    })),
                          ]),
                          SizedBox(height: 8.0),
                          TextDrawer(
                              text: 'صورة المنتج الرئيسية',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900]),
                          SizedBox(height: 8.0),
                          ConstrainedBox(
                              child: Container(
                                  child: Stack(children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 5.0, top: 5.0),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Opacity(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Icon(Icons.remove,
                                                          color: Colors.white),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.red),
                                                    ),
                                                    onTap: () =>
                                                        DeleteProductImageDialog
                                                            .showDeleteProductImageDialog(
                                                                context,
                                                                _keyLoader3,
                                                                removeMainImage,
                                                                () {
                                                      Navigator.of(
                                                              _keyLoader3
                                                                  .currentContext,
                                                              rootNavigator:
                                                                  true)
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
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Icon(Icons.edit,
                                                          color: Colors.white),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.black),
                                                    ),
                                                    onTap: () {
                                                      mainImageStatus = false;
                                                      getImage();
                                                    }),
                                              ],
                                            )))
                                  ]),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          image: _presenter
                                              .loadingImageTypeHandler(
                                                  mainImageStatus,
                                                  'images/no_image.jpg',
                                                  mainProductImage),
                                          fit: BoxFit.cover))),
                              constraints: BoxConstraints(
                                  maxHeight: 140.0, maxWidth: 140.0)),
                          SizedBox(height: 8.0),
                          TextDrawer(
                              text: 'صور المنتج الإضافية (إختيارى)',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900]),
                          SizedBox(height: 8.0),
                          ConstrainedBox(
                              child: inflateAdditionalImagesList(),
                              constraints: BoxConstraints(
                                  minWidth: double.infinity, maxHeight: 270.0)),
                          SizedBox(height: 8.0),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 5.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: double.infinity),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Colors
                                                        .deepPurpleAccent))),
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.deepPurpleAccent)),
                                    onPressed: () => _presenter.validateProductAddition(
                                        mainImageStatus,
                                        _productNameController.text.toString(),
                                        _productPriceController.text.toString(),
                                        showToast,
                                        onSaveProductClicked),
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 12.0, bottom: 12.0),
                                        child: TextDrawer(text: 'إضافة منتج', color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w900))),
                              )),
                        ],
                      )),
                )),
          )),
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
                                  Navigator.of(context).pop();
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
    uploadImageToServer(localData.uploadFileServiceLink,
        localData.userLoggedInToken, image, image.path.toString(), 'image');
  }

  Future getImageFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    File image = File(pickedFile.path);
    uploadImageToServer(localData.uploadFileServiceLink,
        localData.userLoggedInToken, image, image.path.toString(), 'image');
  }

  void uploadImageToServer(String uploadLink, String userToken,
      File selectedFile, String path, String selectedType) {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _uploadSelectedImage
        .uploadImage(uploadLink, userToken, selectedFile, path, selectedType)
        .then((uploadResponse) => _presenter.uploadImageStatesHandler(
            ProductsLocalData.networkConnectionState,
            ProductsLocalData.imageUploadedState,
            () => successImageUpload(uploadResponse),
            () => failureImageUpload(),
            () => failureUploadConnection()));
  }

  successImageUpload(UploadImageResponse uploadResponse) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    viewImageHandler(
        uploadResponse.path, uploadResponse.fileName, uploadResponse.path);
  }

  failureImageUpload() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ProductsLocalData.additionMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  failureUploadConnection() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ProductsLocalData.additionMessage =
        'برجاء التأكد من وجود اتصال ثابت بالانترنت';
    showToast();
  }

  void viewImageHandler(
          String returnedImage, String returnedFileName, String returnedPath) =>
      _presenter.newProductImageHandler(
          mainImageStatus,
          () => updateMainImage(returnedFileName, returnedImage),
          () => updateOtherImagesList(returnedPath, returnedFileName));

  updateMainImage(String returnedFileName, String returnedImage) =>
      setState(() {
        mainImageStatus = true;
        mainProductImage = returnedImage;
        mainProductImageFileName = returnedFileName;
      });

  updateOtherImagesList(String returnedPath, String returnedFileName) {
    final otherNewImage =
        newProductOtherImages.firstWhere((item) => item.imageId == currentId);
    productOtherImagesNames.add(returnedFileName);
    setState(() {
      otherNewImage.imageName = returnedFileName;
      otherNewImage.imagePath = returnedPath;
      otherNewImage.imageState = true;
    });
  }

  //Remove Image part
  void removeMainImage() {
    Navigator.of(_keyLoader3.currentContext, rootNavigator: true ?? context)
        .pop();
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _deleteSelectedImage
        .getDeleteResponse(
            localData.deleteFileServiceLink,
            localData.userLoggedInAcceptLanguage,
            mainProductImageFileName,
            localData.userLoggedInToken)
        .then((deleteResponse) => _presenter.uploadImageStatesHandler(
            ProductsLocalData.networkConnectionState,
            ProductsLocalData.imageDeleteState,
            () => successMainImageDelete(deleteResponse),
            () => failureImageUpload(),
            () => failureUploadConnection()));
  }

  successMainImageDelete(DeleteResponseData deleteResponse) {
    Navigator.of(context).pop();
    mainImageStatus = false;
    setState(() => mainProductImage = deleteResponse.defaultImage);
  }

  void removeImageFromList() {
    productOtherImagesNames.removeAt(currentIndex);
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _deleteSelectedImage
        .getDeleteResponse(
            localData.deleteFileServiceLink,
            localData.userLoggedInAcceptLanguage,
            imageListFileName,
            localData.userLoggedInToken)
        .then((deleteResponse) => _presenter.uploadImageStatesHandler(
            ProductsLocalData.networkConnectionState,
            ProductsLocalData.imageDeleteState,
            () => successOtherImageDelete(deleteResponse),
            () => failureImageDelete(),
            () => failureUploadConnection()));
  }

  successOtherImageDelete(DeleteResponseData deleteResponse) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    setState(() {
      final otherNewImage =
          newProductOtherImages.firstWhere((item) => item.imageId == currentId);
      otherNewImage.imagePath = '';
      otherNewImage.imageName = 'images/no_image.jpg';
      otherNewImage.imageState = false;
    });
  }

  failureImageDelete() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ProductsLocalData.additionMessage = 'حدث خطأ ما برجاء إعادة المحاولة';
    showToast();
  }

  void onSaveProductClicked() {
    LoadingDialog.showLoadingDialog(context, _keyLoader);
    _getSaveProductResponse
        .getSaveResponse(
            localData.productSaveServiceLink,
            localData.userLoggedInToken,
            _productNameController.text.toString(),
            _presenter.productCategoryController(categoryId),
            _productPriceController.text.toString(),
            _presenter.descriptionTextController(_productDescriptionController),
            _presenter
                .getProductQuantityState(isQuantityToggleChecked)
                .toString(),
            _presenter.quantityTextController(
                _productQuantityController, isQuantityToggleChecked),
            _presenter.getProductDisplayState(isStateToggleChecked).toString(),
            mainProductImageFileName,
            productOtherImagesNames)
        .then((saveResponse) => _presenter.checkConnectionStatus(
            ProductsLocalData.networkConnectionState,
            () => successAddingNewProduct(),
            () => failureUploadConnection()));
  }

  successAddingNewProduct() {
    Navigator.of(context).pop();
    Navigator.pop(context, true);
  }

  void showToast() {
    Toast.show(ProductsLocalData.additionMessage, context,
        duration: 3, gravity: Toast.BOTTOM);
  }

  @override
  void dispose() {
    _productDescriptionController.dispose();
    _productQuantityController.dispose();
    _productSectionController.dispose();
    _productPriceController.dispose();
    _productNameController.dispose();
    productOtherImagesNames.clear();
    super.dispose();
  }
}
