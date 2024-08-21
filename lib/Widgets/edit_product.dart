// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../Model/products_model.dart';

class EditProduct extends StatefulWidget {
  final ProductsModel productsModel;
  const EditProduct({super.key, required this.productsModel});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String uid = '';
  String description = '';
  String name = '';
  String category = '';
  String subCategory = '';
  String subSubCategory = '';
  String image1 = '';
  String image2 = '';
  String image3 = '';
  String unitname1 = '';
  String unitname2 = '';
  String unitname3 = '';
  String unitname4 = '';
  String unitname5 = '';
  String unitname6 = '';
  String unitname7 = '';
  num unitPrice1 = 0;
  num unitPrice2 = 0;
  num unitPrice3 = 0;
  num unitPrice4 = 0;
  num unitPrice5 = 0;
  num unitPrice6 = 0;
  num unitPrice7 = 0;
  num unitOldPrice1 = 0;
  num unitOldPrice2 = 0;
  num unitOldPrice3 = 0;
  num unitOldPrice4 = 0;
  num unitOldPrice5 = 0;
  num unitOldPrice6 = 0;
  num unitOldPrice7 = 0;
  num percantageDiscount = 0;
  String productId = '';
  String vendorId = '';
  String vendorName = '';
  String brandName = '';
  String marketID = '';
  String marketName = '';
  bool selected = true;
  dynamic _image1;
  dynamic _image2;
  dynamic _image3;
  bool? loading;
  int? quantity;
  int? returnDuration;
  //final _formKey = GlobalKey<FormState>();

  Future<void> _uploadImage1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    ).then((value) {
      setState(() {
        loading = true;
      });
      return value;
    });

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      //String fileName = result.files.first.name;
      setState(() {
        _image1 = fileBytes;
      });

      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putData(fileBytes!);
      String url = await upload.ref.getDownloadURL().then((value) {
        if (_image1 != null) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: "Please wait for image to uplaod",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
        if (image1 != '') {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: "Image successfully uploded",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
        return value;
      });
      setState(() {
        image1 = url;
        loading = false;
      });
    }
  }

  Future<void> _uploadImage2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    ).then((value) {
      setState(() {
        loading = true;
      });
      return value;
    });

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      //String fileName = result.files.first.name;
      setState(() {
        _image2 = fileBytes;
      });

      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putData(fileBytes!);
      String url = await upload.ref.getDownloadURL().then((value) {
        if (_image2 != null) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: "Please wait for image to uplaod",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
        if (image2 != '') {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: "Image successfully uploded",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
        return value;
      });
      setState(() {
        image2 = url;
        loading = false;
      });
    }
  }

  Future<void> _uploadImage3() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    ).then((value) {
      setState(() {
        loading = true;
      });
      return value;
    });

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      //String fileName = result.files.first.name;
      setState(() {
        _image3 = fileBytes;
      });

      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putData(fileBytes);
      String url = await upload.ref.getDownloadURL().then((value) {
        if (_image3 != null) {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: "Please wait for image to uplaod",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
        if (image3 != '') {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            title: "Notification",
            message: "Image successfully uploded",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
        return value;
      });
      setState(() {
        image3 = url;
        loading = false;
      });
    }
  }

  List<String> categories = [];
  getCategories() {
    List<String> cat = [];
    FirebaseFirestore.instance.collection('Categories').get().then((value) {
      print('Length is ${value.docs.length}');
      return value.docs.forEach((element) {
        cat.add(element.data()['category']);
        setState(() {
          categories = cat;
        });
      });
    });
  }

  List<String> subCategories = [];
  getSubCategories() {
    if (widget.productsModel.category != '') {
      FirebaseFirestore.instance
          .collection('Sub Categories')
          .where('category', isEqualTo: widget.productsModel.category)
          .get()
          .then((value) {
        return value.docs.forEach((element) {
          subCategories.add(element.data()['name']);
        });
      });
      subCategories.clear();
    }
  }

  List<String> subCategoriesCollection = [];
  getsubCategoriesCollection() {
    if (subCategory != '' && widget.productsModel.category != '') {
      FirebaseFirestore.instance
          .collection('Sub categories collections')
          .where('category', isEqualTo: widget.productsModel.category)
          .where('sub-category', isEqualTo: subCategory)
          .get()
          .then((value) {
        return value.docs.forEach((element) {
          subCategoriesCollection.add(element.data()['name']);
        });
      });
      subCategoriesCollection.clear();
    }
  }

  bool uploading = false;
  updateProduct(ProductsModel products) {
    setState(() {
      uploading = true;
    });
    FirebaseFirestore.instance
        .collection('Products')
        .doc(widget.productsModel.uid)
        .update(products.toMap())
        .then((value) {
      setState(() {
        uploading = false;
      });
      Fluttertoast.showToast(
          msg: "Product Added Successfully...".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 14.0);
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    getCategories();
    getBrands();
    super.initState();
  }

  List<String> collections = [];
  String collection = '';
  getCollections(String category) {
    List<String> cat = [];
    FirebaseFirestore.instance
        .collection('Collections')
        .where('category', isEqualTo: category)
        .get()
        .then((value) {
      print('Length is ${value.docs.length}');
      collections.clear();
      return value.docs.forEach((element) {
        cat.add(element.data()['collection']);
        setState(() {
          collections = cat;
        });
      });
    });
  }

  List<String> brands = [];
  String brand = '';
  getBrands() {
    List<String> cat = [];
    FirebaseFirestore.instance
        .collection('Brands')
        // .where('category', isEqualTo: category)
        .get()
        .then((value) {
      print('Length is ${value.docs.length}');
      brands.clear();
      return value.docs.forEach((element) {
        cat.add(element.data()['collection']);
        setState(() {
          brands = cat;
        });
      });
    });
  }

  List<String> subCollections = [];
  String subCollection = '';
  getSubCollections(String category, String collection) {
    List<String> cat = [];
    FirebaseFirestore.instance
        .collection('Sub Collections')
        .where('category', isEqualTo: category)
        .where('collection', isEqualTo: collection)
        .get()
        .then((value) {
      print('Length is ${value.docs.length}');
      subCollections.clear();
      return value.docs.forEach((element) {
        cat.add(element.data()['subCollection']);
        setState(() {
          subCollections = cat;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: SingleChildScrollView(
            child: Padding(
          padding: MediaQuery.of(context).size.width >= 1100
              ? const EdgeInsets.only(left: 100, right: 100)
              : const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Edit product'),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.clear))
                ],
              ),
              const SizedBox(height: 20),
              const Text('Edit Product',
                  style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 20),
              const Row(children: [
                Text('Product Name:'),
              ]),
              const SizedBox(height: 10),
              TextFormField(
                onSaved: (value) {
                  setState(() {
                    name = value!;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field'.tr();
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.productsModel.name,
                  focusColor: Colors.grey,
                  filled: true,
                  fillColor: Colors.white10,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Description:').tr(),
              ]),
              const SizedBox(height: 10),
              TextFormField(
                  maxLines: 5,
                  onSaved: (value) {
                    setState(() {
                      description = value!;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: widget.productsModel.description,
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  )),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Return Duration In Days:').tr(),
              ]),
              const SizedBox(height: 10),
              TextFormField(
                // maxLines: 5,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,

                onSaved: (value) {
                  setState(() {
                    returnDuration = int.parse(value!);
                  });
                },
                onChanged: (value) {
                  setState(() {
                    returnDuration = int.parse(value);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field'.tr();
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.productsModel.returnDuration.toString(),
                  focusColor: Colors.grey,
                  filled: true,
                  fillColor: Colors.white10,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Category:').tr(),
              ]),
              const SizedBox(height: 10),
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                selectedItem: category,
                items: categories,
                validator: (v) => v == null ? "Required field".tr() : null,
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText:
                      category == '' ? widget.productsModel.category : '',
                )),
                onChanged: (value) {
                  setState(() {
                    category = value!;
                    collection = '';
                    brand = '';
                    subCollection = '';
                  });
                  getCollections(category);

                  subCollections.clear();
                },
              ),

              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Collection:').tr(),
              ]),
              const SizedBox(height: 10),
              DropdownSearch<String>(
                selectedItem: collection,
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: collections,
                validator: (v) => v == null ? "Required field".tr() : null,
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText:
                      category == '' ? widget.productsModel.collection : '',
                )),
                onChanged: (value) {
                  setState(() {
                    collection = value!;
                    subCollection = '';
                  });
                  getSubCollections(category, collection);
                },
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Sub Collection:').tr(),
              ]),
              const SizedBox(height: 10),
              DropdownSearch<String>(
                selectedItem: subCollection,
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: subCollections,
                validator: (v) => v == null ? "Required field".tr() : null,
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText:
                      category == '' ? widget.productsModel.subCollection : '',
                )),
                onChanged: (value) {
                  // getSubCollections(category, collection);
                  setState(() {
                    subCollection = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Brand:').tr(),
              ]),
              const SizedBox(height: 10),
              DropdownSearch<String>(
                selectedItem: brand,
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: brands,
                // validator: (v) => v == null ? "Required field".tr() : null,
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: category == '' ? widget.productsModel.brand : '',
                )),
                onChanged: (value) {
                  // getSubCollections(category, collection);
                  setState(() {
                    brand = value!;
                  });
                },
              ),

              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Price:').tr(),
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    setState(() {
                      unitPrice1 = int.parse(value!);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      unitPrice1 = int.parse(value);
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: widget.productsModel.unitPrice1.toString(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Initial Price:').tr(),
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    setState(() {
                      unitOldPrice1 = int.parse(value!);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      unitOldPrice1 = int.parse(value);
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: widget.productsModel.unitOldPrice1.toString(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Quantity:').tr(),
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    setState(() {
                      quantity = int.parse(value!);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      quantity = int.parse(value);
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: widget.productsModel.quantity.toString(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(children: [
                const Text('Product Discount (%):').tr(),
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    setState(() {
                      percantageDiscount = int.parse(value!);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      percantageDiscount = int.parse(value);
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText:
                        widget.productsModel.percantageDiscount.toString(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                const Text('Product Unit:').tr(),
              ]),
              const SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: TextFormField(
                  onSaved: (value) {
                    setState(() {
                      unitname1 = value!;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      unitname1 = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field'.tr();
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: widget.productsModel.unitname1.toString(),
                    focusColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white10,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(children: [
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Add on',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      .tr()
                ]),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(flex: 1, child: const Text('Unit').tr()),
                        Flexible(
                            flex: 1, child: const Text('Initial Price').tr()),
                        Flexible(flex: 1, child: const Text('Price').tr())
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitname2
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitname2 = value;
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitOldPrice2
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitOldPrice2 = int.parse(value);
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitPrice2
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitPrice2 = int.parse(value);
                                });
                              },
                            ))
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitname3
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitname3 = value;
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitOldPrice3
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitOldPrice3 = int.parse(value);
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitPrice3
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitPrice3 = int.parse(value);
                                });
                              },
                            ))
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitname4
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitname4 = value;
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitOldPrice4
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitOldPrice4 = int.parse(value);
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitPrice4
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitPrice4 = int.parse(value);
                                });
                              },
                              keyboardType: TextInputType.number,
                            ))
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitname5
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitname5 = value;
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitOldPrice5
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitOldPrice5 = int.parse(value);
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitPrice5
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitPrice5 = int.parse(value);
                                });
                              },
                            ))
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitname6
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitname6 = value;
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitOldPrice6
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitOldPrice6 = int.parse(value);
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitPrice6
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitPrice6 = int.parse(value);
                                });
                              },
                            ))
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitname7
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitname7 = value;
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitOldPrice7
                                      .toString()),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  unitOldPrice7 = int.parse(value);
                                });
                              },
                            )),
                        const SizedBox(width: 10),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: widget.productsModel.unitPrice7
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  unitPrice7 = int.parse(value);
                                });
                              },
                              keyboardType: TextInputType.number,
                            ))
                      ]),
                ),
                const SizedBox(height: 20),
              ]),
              const SizedBox(height: 20),
              _image1 == null
                  ? widget.productsModel.image1 == ''
                      ? const Icon(
                          Icons.image,
                          size: 120,
                          color: Colors.grey,
                        )
                      : Image.network(widget.productsModel.image1,
                          width: 120, height: 120)
                  : Image.memory(_image1!, width: 120, height: 120),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade800,
                          ),
                        ),
                        onPressed: () {
                          _uploadImage1();
                        },
                        child: const Text('Add Image 1',
                                style: TextStyle(color: Colors.white))
                            .tr()),
                  ],
                ),
              ),
              _image2 == null
                  ? widget.productsModel.image2 == ''
                      ? const Icon(
                          Icons.image,
                          size: 120,
                          color: Colors.grey,
                        )
                      : Image.network(widget.productsModel.image2,
                          width: 120, height: 120)
                  : Image.memory(_image2!, width: 120, height: 120),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade800,
                          ),
                        ),
                        onPressed: () {
                          _uploadImage2();
                        },
                        child: const Text('Add Image 2',
                                style: TextStyle(color: Colors.white))
                            .tr()),
                  ],
                ),
              ),
              _image3 == null
                  ? widget.productsModel.image3 == ''
                      ? const Icon(
                          Icons.image,
                          size: 120,
                          color: Colors.grey,
                        )
                      : Image.network(widget.productsModel.image3,
                          width: 120, height: 120)
                  : Image.memory(_image3!, width: 120, height: 120),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade800,
                          ),
                        ),
                        onPressed: () {
                          _uploadImage3();
                        },
                        child: const Text('Add Image 3',
                                style: TextStyle(color: Colors.white))
                            .tr()),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Text(
              //         'NB: You can add variant after adding the product successfully',
              //         style: TextStyle(fontWeight: FontWeight.bold)),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              loading == true || uploading == true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade800,
                            ),
                          ),
                          onPressed: null,
                          child: const Text('Update Product',
                                  style: TextStyle(color: Colors.white))
                              .tr()),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 45, 42, 42)),
                            onPressed: () {
                              updateProduct(ProductsModel(
                                returnDuration: returnDuration ??
                                    widget.productsModel.returnDuration,
                                subCollection: subCollection == ""
                                    ? widget.productsModel.subCollection
                                    : subCollection,
                                quantity:
                                    quantity ?? widget.productsModel.quantity,
                                totalRating: widget.productsModel.totalRating,
                                totalNumberOfUserRating: widget
                                    .productsModel.totalNumberOfUserRating,
                                productID: widget.productsModel.productID,
                                description: description == ''
                                    ? widget.productsModel.description
                                    : description,
                                //  marketID: '',
                                vendorName: widget.productsModel.vendorName,
                                uid: uid,
                                name: name == ''
                                    ? widget.productsModel.name
                                    : name,
                                category: category == ''
                                    ? widget.productsModel.category
                                    : category,
                                collection: subCategory == ''
                                    ? widget.productsModel.collection
                                    : collection,
                                brand: brand == ''
                                    ? widget.productsModel.brand
                                    : brand,
                                image1: image1 == ''
                                    ? widget.productsModel.image1
                                    : image1,
                                image2: image2 == ''
                                    ? widget.productsModel.image2
                                    : image2,
                                image3: image3 == ''
                                    ? widget.productsModel.image3
                                    : image3,
                                unitname1: unitname1 == ''
                                    ? widget.productsModel.unitname1
                                    : unitname1,
                                unitname2: unitname2 == ''
                                    ? widget.productsModel.unitname2
                                    : unitname2,
                                unitname3: unitname3 == ''
                                    ? widget.productsModel.unitname3
                                    : unitname3,
                                unitname4: unitname4 == ''
                                    ? widget.productsModel.unitname4
                                    : unitname4,
                                unitname5: unitname5 == ''
                                    ? widget.productsModel.unitname5
                                    : unitname5,
                                unitname6: unitname6 == ''
                                    ? widget.productsModel.unitname6
                                    : unitname6,
                                unitname7: unitname7 == ''
                                    ? widget.productsModel.unitname7
                                    : unitname7,
                                unitPrice1: unitPrice1 == 0
                                    ? widget.productsModel.unitPrice1
                                    : unitPrice1,
                                unitPrice2: unitPrice2 == 0
                                    ? widget.productsModel.unitPrice2
                                    : unitPrice2,
                                unitPrice3: unitPrice3 == 0
                                    ? widget.productsModel.unitPrice3
                                    : unitPrice3,
                                unitPrice4: unitPrice4 == 0
                                    ? widget.productsModel.unitPrice4
                                    : unitPrice4,
                                unitPrice5: unitPrice5 == 0
                                    ? widget.productsModel.unitPrice5
                                    : unitPrice5,
                                unitPrice6: unitPrice6 == 0
                                    ? widget.productsModel.unitPrice6
                                    : unitPrice6,
                                unitPrice7: unitPrice7 == 0
                                    ? widget.productsModel.unitPrice7
                                    : unitPrice7,
                                unitOldPrice1: unitOldPrice1 == 0
                                    ? widget.productsModel.unitOldPrice1
                                    : unitOldPrice1,
                                unitOldPrice2: unitOldPrice2 == 0
                                    ? widget.productsModel.unitOldPrice2
                                    : unitOldPrice2,
                                unitOldPrice3: unitOldPrice3 == 0
                                    ? widget.productsModel.unitOldPrice3
                                    : unitOldPrice3,
                                unitOldPrice4: unitOldPrice4 == 0
                                    ? widget.productsModel.unitOldPrice4
                                    : unitOldPrice4,
                                unitOldPrice5: unitOldPrice5 == 0
                                    ? widget.productsModel.unitOldPrice5
                                    : unitOldPrice5,
                                unitOldPrice6: unitOldPrice6 == 0
                                    ? widget.productsModel.unitOldPrice6
                                    : unitOldPrice6,
                                unitOldPrice7: unitOldPrice7 == 0
                                    ? widget.productsModel.unitOldPrice7
                                    : unitOldPrice7,
                                percantageDiscount: percantageDiscount == 0
                                    ? widget.productsModel.percantageDiscount
                                    : percantageDiscount,
                                vendorId: widget.productsModel.vendorId,
                              ));
                            },
                            child: const Text('Update Product',
                                    style: TextStyle(color: Colors.white))
                                .tr()),
                      ),
                    )
            ]),
          ),
        )));
  }
}
