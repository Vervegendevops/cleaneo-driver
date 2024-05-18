import 'dart:io';
import 'package:cleaneo_driver_app/Global/global.dart';
import 'package:cleaneo_driver_app/Screens/Driver_Onboarding/Verifying.dart';
import 'package:cleaneo_driver_app/end.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class VehPics extends StatefulWidget {
  const VehPics({Key? key}) : super(key: key);

  @override
  State<VehPics> createState() => _VehPicsState();
}

class _VehPicsState extends State<VehPics> {
  Future<void> postData() async {
    const String apiUrl = 'https://drycleaneo.com/CleaneoDriver/api/signup';

    // Load image files
    String imagePath = drivingLicense1!.path;
    File imageFile = File(imagePath);

    String imagePath2 = drivingLicense2!.path;
    File imageFile2 = File(imagePath2);

    String imagePath3 = aadharDetails1!.path;
    File imageFile3 = File(imagePath3);

    String imagePath4 = aadharDetails2!.path;
    File imageFile4 = File(imagePath4);

    String imagePath5 = panDetails1!.path;
    File imageFile5 = File(imagePath5);

    String imagePath6 = vehiclePictures1!.path;
    File imageFile6 = File(imagePath6);

    String imagePath7 = vehiclePictures2!.path;
    File imageFile7 = File(imagePath7);

    String imagePath8 = vehiclePictures3!.path;
    File imageFile8 = File(imagePath8);

    String imagePath9 = vehiclePictures4!.path;
    File imageFile9 = File(imagePath9);

    String imagePath10 = vehicleDocuments1!.path;
    File imageFile10 = File(imagePath10);

    String imagePath11 = vehicleDocuments2!.path;
    File imageFile11 = File(imagePath11);

    String imagePath12 = vehicleDocuments3!.path;
    File imageFile12 = File(imagePath12);

    String imagePath13 = vehicleDocuments4!.path;
    File imageFile13 = File(imagePath13);

    // JSON data
    Map<String, String> jsonFields = {
      "id": UserID,
      "name": Signupname,
      "phone": Signupphone,
      "email": Signupemail,
      "aadhar": aadhar,
      "pan": pan,
      "drivingLicense": expiry,
      "model": model,
      "year": year,
      "licensePlate": licensePlate,
      "registrationPlate": registrationPlate,
      "vehicleIdentificationNumber": vehicleIdentificationNumber,
      "chasisNumber": chasisNumber,
      "insuranceNumber": insuranceNumber,
      "insuranceExpiryDate": insuranceExpiryDate,
      "vehicleInspection": vehicleInspection,
      "vehicleInspectionExpiryDate": vehicleInspectionExpiryDate,
      "brand": brand,
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add JSON fields
      request.fields.addAll(jsonFields);

      // Add image file
      request.files.add(http.MultipartFile(
        'drivingLicense1',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'drivingLicense1.jpg',
      ));

      request.files.add(http.MultipartFile(
        'drivingLicense2',
        imageFile2.readAsBytes().asStream(),
        imageFile2.lengthSync(),
        filename: 'drivingLicense2.jpg',
      ));

      request.files.add(http.MultipartFile(
        'aadharDetails1',
        imageFile3.readAsBytes().asStream(),
        imageFile3.lengthSync(),
        filename: 'aadharDetails1.jpg',
      ));

      request.files.add(http.MultipartFile(
        'aadharDetails2',
        imageFile4.readAsBytes().asStream(),
        imageFile4.lengthSync(),
        filename: 'aadharDetails2.jpg',
      ));

      request.files.add(http.MultipartFile(
        'panDetails1',
        imageFile5.readAsBytes().asStream(),
        imageFile5.lengthSync(),
        filename: 'panDetails1.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehiclePictures1',
        imageFile6.readAsBytes().asStream(),
        imageFile6.lengthSync(),
        filename: 'vehiclePictures1.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehiclePictures2',
        imageFile7.readAsBytes().asStream(),
        imageFile7.lengthSync(),
        filename: 'vehiclePictures2.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehiclePictures3',
        imageFile8.readAsBytes().asStream(),
        imageFile8.lengthSync(),
        filename: 'vehiclePictures3.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehiclePictures4',
        imageFile9.readAsBytes().asStream(),
        imageFile9.lengthSync(),
        filename: 'vehiclePictures4.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehicleDocuments1',
        imageFile10.readAsBytes().asStream(),
        imageFile10.lengthSync(),
        filename: 'vehicleDocuments1.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehicleDocuments2',
        imageFile11.readAsBytes().asStream(),
        imageFile11.lengthSync(),
        filename: 'vehicleDocuments2.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehicleDocuments3',
        imageFile12.readAsBytes().asStream(),
        imageFile12.lengthSync(),
        filename: 'vehicleDocuments3.jpg',
      ));

      request.files.add(http.MultipartFile(
        'vehicleDocuments4',
        imageFile13.readAsBytes().asStream(),
        imageFile13.lengthSync(),
        filename: 'vehicleDocuments4.jpg',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle a successful response here
        var responseBody = await response.stream.bytesToString();
        print("Success: $responseBody");
        Navigator.push(context, MaterialPageRoute(builder: (_) => Verifying()));
      } else {
        // Handle errors or other status codes here
        print("Error: ${response.statusCode}");
        print("Response: ${await response.stream.bytesToString()}");
      }
    } catch (e) {
      print("Error: $e");
      // Handle network-related errors here
    }
  }

  TextEditingController storeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstinController = TextEditingController();
  XFile? _image1;
  XFile? _image2;
  XFile? _image3;
  XFile? _image4;
  XFile? _image5;
  XFile? _image6;
  XFile? _image7;
  XFile? _image8;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff006acb),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mQuery.size.height * 0.034),
            Padding(
              padding: const EdgeInsets.only(
                  top: 45, left: 16, right: 16, bottom: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: mQuery.size.width * 0.036,
                    ),
                    Text(
                      "Vehicle Picture & Documents",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'SatoshiBold',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: mQuery.size.height * 0.032,
                        ),
                        Row(
                          children: [
                            Text(
                              "Upload vehicle Pictures*",
                              style: TextStyle(
                                  fontFamily: 'SatoshiBold',
                                  fontSize: mQuery.size.height * 0.015),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _image1 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image1 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image1!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image1, 1),
                            _image2 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image2 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image2!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image2, 2),
                            _image3 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image3 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image3!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image3, 3),
                            _image4 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image4 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image4!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image4, 4),
                          ],
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.032,
                        ),
                        Row(
                          children: [
                            Text(
                              "Upload vehicle Documents*",
                              style: TextStyle(
                                  fontFamily: 'SatoshiBold',
                                  fontSize: mQuery.size.height * 0.015),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _image5 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image5 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image5!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image5, 5),
                            _image6 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image6 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image6!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image6, 6),
                            _image7 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image7 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image7!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image7, 7),
                            _image8 != null
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image8 =
                                            null; // Reset the image when tapped
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(File(_image8!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : buildImageContainer(mQuery, _image8, 8),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            print('dsvds');
                            if (Signupphone.isNotEmpty &&
                                Signupemail.isNotEmpty &&
                                Signupname.isNotEmpty &&
                                UserID.isNotEmpty &&
                                expiry.isNotEmpty &&
                                aadhar.isNotEmpty &&
                                pan.isNotEmpty &&
                                drivingLicense1 != null &&
                                drivingLicense2 != null &&
                                aadharDetails1 != null &&
                                aadharDetails2 != null &&
                                panDetails1 != null &&
                                brand.isNotEmpty &&
                                model.isNotEmpty &&
                                year.isNotEmpty &&
                                licensePlate.isNotEmpty &&
                                registrationPlate.isNotEmpty &&
                                vehicleIdentificationNumber.isNotEmpty &&
                                chasisNumber.isNotEmpty &&
                                insuranceNumber.isNotEmpty &&
                                insuranceExpiryDate.isNotEmpty &&
                                vehicleInspection.isNotEmpty &&
                                vehicleInspectionExpiryDate.isNotEmpty &&
                                vehiclePictures1 != null &&
                                vehiclePictures2 != null &&
                                vehiclePictures3 != null &&
                                vehiclePictures4 != null &&
                                vehicleDocuments1 != null &&
                                vehicleDocuments2 != null &&
                                vehicleDocuments3 != null &&
                                vehicleDocuments4 != null) {
                              postData();
                              // All variables are not empty, navigate to the next screen
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Verifying()),
                              // );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Please Check all the details.'),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(16.0),
                                ),
                              );
                            }
                            // At least one variable is empty, do nothing or show an error message
                          },
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                                color: const Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                "Finish",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'SatoshiBold'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.04,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImageContainer(
      MediaQueryData mQuery, XFile? imageFile, int index) {
    return GestureDetector(
      onTap: () async {
        final imageSource = await showModalBottomSheet<ImageSource>(
          backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text(
                      'Camera',
                      style: TextStyle(
                        fontFamily: 'SatoshiMedium',
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text(
                      'Gallery',
                      style: TextStyle(
                        fontFamily: 'SatoshiMedium',
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  ),
                ],
              ),
            );
          },
        );
        if (imageSource != null) {
          final XFile? pickedImage =
              await _imagePicker.pickImage(source: imageSource);

          setState(() {
            if (index == 1) {
              _image1 = pickedImage;
              vehiclePictures1 = _image1;
            } else if (index == 2) {
              _image2 = pickedImage;
              vehiclePictures2 = _image2;
            } else if (index == 3) {
              _image3 = pickedImage;
              vehiclePictures3 = _image3;
            } else if (index == 4) {
              _image4 = pickedImage;
              vehiclePictures4 = _image4;
            } else if (index == 5) {
              _image5 = pickedImage;
              vehicleDocuments1 = _image5;
            } else if (index == 6) {
              _image6 = pickedImage;
              vehicleDocuments2 = _image6;
            } else if (index == 7) {
              _image7 = pickedImage;
              vehicleDocuments3 = _image7;
            } else if (index == 8) {
              _image8 = pickedImage;
              vehicleDocuments4 = _image8;
            }
          });
        }
      },
      child: Container(
        width: mQuery.size.width * 0.19,
        // height: mQuery.size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: imageFile != null
              ? DecorationImage(
                  image: FileImage(File(imageFile.path)),
                  fit: BoxFit.cover,
                )
              : null, // Null if imageFile is null
        ),
        child: imageFile == null
            ? SvgPicture.asset(
                "assets/imagepicker.svg",
                height: mQuery.size.width * 0.19,
              )
            : null, // No child if imageFile is not null
      ),
    );
  }
}
