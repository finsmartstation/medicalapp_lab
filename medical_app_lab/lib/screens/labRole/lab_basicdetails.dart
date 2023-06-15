import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app_lab/screens/labRole/lab_dashboard.dart';
import 'package:medical_app_lab/service/api_services.dart';
import 'package:medical_app_lab/utility/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lab_api_services.dart';

class LabBasicDetails extends StatefulWidget {
  const LabBasicDetails({Key? key}) : super(key: key);

  @override
  State<LabBasicDetails> createState() => _LabBasicDetailsState();
}

class _LabBasicDetailsState extends State<LabBasicDetails> {
  List<XFile>? _imageFileList;
  File? imageFile;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
    // print("File : ${value!.}");
  }
  
  
  Location location = Location();
  bool _serviceEnabled = false;
  bool nameEmpty = false;
  bool emailEmpty = false;
  String gender='';
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late Position position;
 // double long = 0.0;
  //double lat = 0.0;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String locality = '';
  String feature_name = '';
  String admin_area = '';
  String? access_token;
  String? uid;
  var imgUrl;
  bool profileStatus = false;
  bool nameStatus = false;
  bool emailStatus = false;

  String? profilePic;
  String long = "", lat = "";

  SetProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName',nameController.text.toString());
    prefs.setString('email', emailController.text.toString());
    prefs.setString('profilePicture', profilePic!);
    prefs.setString('latitude', lat.toString());
    prefs.setString('longitude', long.toString());
    prefs.setString('gender', gender);
     print("profile path =============");
    print(prefs.getString('profilePicture'));
  }
   getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token= prefs.getString('access_token');
    uid=prefs.getString('user_id');
    print(uid);
    print(access_token);
  }
   
  @override
  void initState() {
   getProfile();
    checkGps();
    super.initState();
  }

  checkGps() async {
      servicestatus = await Geolocator.isLocationServiceEnabled();
      if(servicestatus){
            permission = await Geolocator.checkPermission();
          
            if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) {
                    print('Location permissions are denied');
                }else if(permission == LocationPermission.deniedForever){
                    print("'Location permissions are permanently denied");
                }else{
                   haspermission = true;
                }
            }else{
               haspermission = true;
            }

            if(haspermission){
                setState(() {
                  //refresh the UI
                });

                getLocation();
            }
      }else{
        print("GPS Service is not enabled, turn on GPS location");
      }

      setState(() {
         //refresh the UI
      });
  }

  getLocation() async {
      position = await Geolocator.getCurrentPosition();
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
         //refresh UI
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //resizeToAvoidBottomInset: false,
        body:  SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.asset(profile_top_gs_Croped, fit: BoxFit.fill),
                ),
                Stack(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          imageFile == null
                              ? Container(
                                  width: 200,
                                  height: 200,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.blueAccent),
                                  ),
                                  child: const Image(
                                    height: 100,
                                    width: 100,
                                    image: NetworkImage(
                                        "https://cdn-icons-png.flaticon.com/512/147/147285.png"),
                                    // fit: BoxFit.fitHeight,
                                  ),
                                )
                              : Container(
                                  width: 200,
                                  height: 200,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.blueAccent),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(imageFile!),
                                  )),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: MediaQuery.of(context).size.width / 3.5,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            color: Colors.blue.shade900),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.grey,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Profile picture",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    color: Colors.white),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    _ImageButton(
                                                        ImageSource.camera);
                                                  },
                                                  icon: const Icon(Icons
                                                      .camera_alt_rounded),
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const Text("Camera"),
                                            ],
                                          ),
                                          Container(
                                            width: 40,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      color: Colors.white),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      _ImageButton(
                                                          ImageSource.gallery);
                                                    },
                                                    icon: const Icon(Icons.image),
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                const Text('Gallery')
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.camera_alt_rounded),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // Center(
                //   child: Text(
                //     verifyNewUserProfileData.verifyprofile,
                //     style: const TextStyle(color: Colors.red),
                //   ),
                // ),
                profileStatus?const Text(
                  "Required",
                  style: TextStyle(color: Colors.red),
                ):const SizedBox(),
                const SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: 'Name',
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(width: 3, color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(width: 3, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(width: 3, color: Colors.grey),
                        ),
                      ),
                      onChanged: (value) => nameController == null
                          ? setState(() {
                              nameEmpty = false;
                            })
                          : setState(
                              () {
                                nameEmpty = true;
                              },
                            )),
                ),

                nameStatus?const Text(
                  "Required",
                  style: TextStyle(color: Colors.red),
                ):const SizedBox(),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(width: 3, color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(width: 3, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(width: 3, color: Colors.grey),
                        ),
                      ),
                      onChanged: (value) => emailController == null
                          ? setState(() {
                              emailEmpty = false;
                            })
                          : setState(
                              () {
                                emailEmpty = true;
                              },
                            )),
                ),
                // Text(
                //   verifyNewUserProfileData.verifyemail,
                //   style: const TextStyle(color: Colors.red),
                // ),
                emailStatus?const Text(
                  "Required",
                  style: TextStyle(color: Colors.red),
                ):const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                
                // Text(
                //   verifyNewUserProfileData.verifygender,
                //   style: const TextStyle(color: Colors.red),
                // ),
                SizedBox(height: MediaQuery.of(context).size.height / 14),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                      onPressed: () {
                         if (nameController.text.isEmpty) {
                          nameStatus = true;
                          setState(() {
                            
                          });
                        } 
                        else{
                          nameStatus = false;
                          setState(() {
                            
                          });
                        }
                         if (emailController.text.isEmpty) {
                          emailStatus = true;
                          setState(() {
                            
                          });
                        } 
                        else{
                          emailStatus = false;
                          setState(() {
                            
                          });
                        }
                        if (imageFile == null) {
                          profileStatus = true;
                          setState(() {
                            
                          });
                        } 
                        else{
                           profileStatus = false;
                          setState(() {
                            
                          });
                        }
                        if (nameStatus &&
                            emailStatus &&
                            profileStatus) {
                          ApiService()
                              .file_upload(uid, access_token,
                                  imageFile!.path)
                              .then(
                            (value) {
                              if (value.statusCode == 200) {
                                value.stream
                                    .transform(utf8.decoder)
                                    .listen((event) {
                                  var path = jsonDecode(event);
                                  profilePic = path['file_path'];
                                
                                     
                                  print("path==");
                                  print(path);

                                  print(profilePic);
                                  LabApiServices().fillLabBasicDetails(uid.toString(), access_token.toString(),
                                         nameController.text, emailController.text, profilePic.toString()).then((value) {
                                          if(value.statusCode==200){
                                              var jsonData = jsonDecode(value.body)['data'];
                                              Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                   const LabDashboard())));
                                          }
                                         });
                                 

                                  //SetProfileData();
                                });
                                // profilePic=imgUrl;
                                // print("profile path ====");
                                // print(profilePic);
                              }
                            },
                          );
                            }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: Text(
                        'Update Profile',
                        style: TextStyle(
                            color: nameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 18),
                      )),
                )
              ],
            ),
          )
          );
  }

  _ImageButton(
    ImageSource source, {
    BuildContext? context,
  }) async {
    XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _setImageFileListFromFile(pickedFile);
        File img = File(pickedFile.path);
        
        setState(() {
          imageFile = img;
          print(imageFile.toString());
        });
      });
    }
  }
  
}
