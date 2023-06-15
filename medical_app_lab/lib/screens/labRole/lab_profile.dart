import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:medical_app_lab/screens/labRole/lab_api_services.dart';
import 'package:medical_app_lab/screens/labRole/lab_dashboard.dart';
import 'package:medical_app_lab/service/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LabProfile extends StatefulWidget {
  const LabProfile({Key? key}) : super(key: key);

  @override
  State<LabProfile> createState() => _LabProfileState();
}

class _LabProfileState extends State<LabProfile> {
  List<XFile>? _imageFileList;
  File? imageFile;
  File? logoFile;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
    // print("File : ${value!.}");
  }
  final ImagePicker _picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();  
  TextEditingController gstController = TextEditingController();
  TextEditingController ownershipController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  var pageIndex = 0;
  DateTime? selectedDate;
  //String formattedStartDate="Select Date";
  String formattedDate='';
  String logoImage="";
 // String? selectedStartDate;
  String? selectedEndDate;
  String profileImage ='';
  String establishedDate ='';
  String name = '';
  String email = '';
  String address = '';
  String state = '';
  String owner = '';
  String gst = '';
  String pincode = '';
  String contact = '';
  bool profileUploadStatus = false;
  bool logoUploadStatus = false;
 
  @override
  void initState() {
    super.initState();
  }
  Location location = Location();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  String long = "", lat = "";
  late Position position;
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
     // resizeToAvoidBottomInset: false,
       backgroundColor: Colors.grey[350],
      appBar: AppBar(
         backgroundColor: Colors.grey[350],
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
               // size: 30,
                 color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
        title: const Text(' Edit Profile',style: TextStyle(color: Colors.black),),
      ),
        body: FutureBuilder(
          future: LabApiServices().getLabProfileDetails(uid, access_token),
                builder: (BuildContext context, snapshot) {
                  if(snapshot.hasData){
                    if(nameController.text.isEmpty) {
                      nameController.text = snapshot.data!.data.basicDetails.username;
                      print('name');
                    }
                    if(emailController.text.isEmpty) {
                    emailController.text = snapshot.data!.data.basicDetails.email;
                    }
                    if(addressController.text.isEmpty) {
                    addressController.text = snapshot.data!.data.basicDetails.address;
                    }
                    if(stateController.text.isEmpty) {
                    stateController.text = snapshot.data!.data.basicDetails.state;
                    }
                    if(ownershipController.text.isEmpty) {
                    ownershipController.text = snapshot.data!.data.basicDetails.ownership;
                    }
                    if(gstController.text.isEmpty) {
                    gstController.text = snapshot.data!.data.basicDetails.gst;
                    }
                    establishedDate = snapshot.data!.data.basicDetails.establishedDate;
                    if(pincodeController.text.isEmpty) {
                    pincodeController.text = snapshot.data!.data.basicDetails.pincode;
                    }
                    if(contactController.text.isEmpty) {
                    contactController.text = snapshot.data!.data.basicDetails.emergencyContact;
                    }
                    profileImage = snapshot.data!.data.basicDetails.profilePic;
                    logoImage = snapshot.data!.data.basicDetails.logo;
                    print('esta--------$establishedDate');
                    print('format--------------$formattedDate');
              return GestureDetector(
             onHorizontalDragEnd: (DragEndDetails details) {
            // if (details.velocity.pixelsPerSecond.dx > 0) {
            //   // Swiped right
            //   setState(() {
            //   if(pageIndex!=0){
            //   pageIndex--;
            //   }
            //   });
            //  // print('Swiped right');
            // } else {
            //   // Swiped left
            //   setState(() {
            //   if(pageIndex!=2){
            //   pageIndex++;
            //   }
            //   });
            //   //print('Swiped left');
            // }
          },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    pageIndex==0?Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          Stack(
                            children: [
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    imageFile != null
                                        ? Container(
                                            width: 150,
                                            height: 150,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border:
                                                  Border.all(color: Colors.blueAccent),
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: FileImage(imageFile!),
                                            ))
                                            :snapshot.data!.data.basicDetails.profilePic ==''?
                                            Container(
                                            width: 150,
                                            height: 150,
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
                                            width: 150,
                                            height: 150,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border:
                                                  Border.all(color: Colors.blueAccent),
                                            ),
                                            child:  CircleAvatar(
                                              backgroundImage: NetworkImage(snapshot.data!.data.basicDetails.profilePic),
                                            )
                                          )
                                        
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
                                                                    ImageSource.camera,'profile');
                                                              },
                                                              icon: const Icon(Icons
                                                                  .camera_alt_rounded),
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                          const Text("Camera"),
                                                        ],
                                                      ),
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
                                                                    ImageSource.gallery,'profile');
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
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Name'),
                              ),
                            ],
                          ),
                           TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Email'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Address'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: addressController,
                            decoration: const InputDecoration(
                              hintText: 'Address',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          const SizedBox(height: 20,),
                         
                        ],
                      ),
                    ):const SizedBox(),
                    pageIndex==1?Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('State'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: stateController,
                            decoration: const InputDecoration(
                              hintText: 'State',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Ownership'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: ownershipController,
                            decoration: const InputDecoration(
                              hintText: 'Ownership',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Gst'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: gstController,
                            decoration: const InputDecoration(
                              hintText: 'Gst',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Established date'),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                            DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime.now(), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                setState(() {
                                 selectedDate=date; 
                                 print('selected--------${selectedDate.toString().substring(0,10)}');
                                 print('formatted ----$formattedDate');
                                  formattedDate =
                                  DateFormat('dd-MM-yyyy').format(selectedDate!);
                                  print(formattedDate);
                                  // formattedEndDate = formattedDate.toString().substring(0,10);
                                  // selectedEndDate=DateFormat('yyyy-MM-dd').format(selectedDate!).substring(0,10);
                                  //     print(formattedEndDate);
                                  //     print(formattedEndDate.toString());
                                });
                                
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                              },
                              child: Container(
                                    height: 65,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                                    border: Border.all(width:3,color: Colors.grey)),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text( formattedDate!=''?'  ${formattedDate.toString()}'
                                        :establishedDate !='0000-00-00'?establishedDate
                                        :'  Established date',
                                        style: const TextStyle(color: Colors.black54,fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ):const SizedBox(),
                    pageIndex==2?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Pincode'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: pincodeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Pincode',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Emergency contact'),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: contactController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Emergency contact',
                              focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                  ),
                               enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Logo'),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       title: const Text('Lab logo'),
                       content: logoFile!=null? SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(logoFile!))
                        :logoImage != ''?
                          SizedBox(
                            height: 100,
                          width: 100,
                            child: Image.network(logoImage))
                        
                        :const Text('Logo not added'),
                       actions: <Widget>[
                       ElevatedButton(
                          onPressed: (){
                          Navigator.pop(context);
                          }, 
                         child: const Text('Ok')),
                       ],
                     );
                   },
                   );
                                  },
                                  child: Container(
                                        height: 65,
                                        width: MediaQuery.of(context).size.width/1.8,
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                                        border: Border.all(width:3,color: Colors.grey)),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(logoImage!='' || logoFile!=null?'  Lab logo':'  Upload logo',
                                            style: const TextStyle(color: Colors.black54,fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),),
                                SizedBox(
                                   height: 50,
                                        width: MediaQuery.of(context).size.width/3,
                                  child: ElevatedButton(
                                    onPressed: (){
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
                                                      "Lab logo",
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
                                                                    ImageSource.camera,'logo');
                                                              },
                                                              icon: const Icon(Icons
                                                                  .camera_alt_rounded),
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                          const Text("Camera"),
                                                        ],
                                                      ),
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
                                                                    ImageSource.gallery,'logo');
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
                                    
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.upload),
                                      Text("upload")
                                    ],
                                   )),
                                )
                            ],
                          ),
                          
                        ],
                      ),
                    ):const SizedBox(),
                    
                  ],
                ),
                Column(
                  children: [
                    Container(
                       // height: 70.0,
                        width: MediaQuery
                      .of(context)
                      .size
                      .width,
                        color: Colors.grey[300],
                        child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        pageIndex==0?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.width / 4,
                                
                              ),
                              const SizedBox(
                                width: 40,
                                height: 40,
                                child: Card(child: Center(child: Text('1')),)),
                             const Text('....'),
                              const SizedBox(
                                width: 30,
                                height: 30,
                                child: Card(child: Center(child: Text('3')),)),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      pageIndex = 1;
                                    });
                                  },
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                     children: const [
                                       Text('Next',
                                        style: TextStyle(
                                      fontSize: 18),),
                                      Icon(Icons.arrow_forward)
                                     ],
                                   )),
                              )
                            ],
                          ):const SizedBox(),
                        pageIndex==1?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                  onPressed: (){
                                    pageIndex = 0;
                                    setState(() {
                                      
                                    });
                                  },
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                     children: const [
                                      Icon(Icons.arrow_back),
                                       Text('Back',
                                        style: TextStyle(
                                      fontSize: 18),),
                                       
                                     ],
                                   )),
                              ),
                              const SizedBox(
                                width: 30,
                                height: 30,
                                child: Card(child: Center(child: Text('1')),)),
                               const SizedBox(
                                width: 40,
                                height: 40,
                                child: Card(child: Center(child: Text('2')),)),
                              const SizedBox(
                                width: 30,
                                height: 30,
                                child: Card(child: Center(child: Text('3')),)),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                     pageIndex = 2;
                                    });
                                  },
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                     children: const [
                                       Text('Next',
                                        style: TextStyle(
                                      fontSize: 18),),
                                      Icon(Icons.arrow_forward)
                                     ],
                                   )),
                              )
                            ],
                          ):const SizedBox(),
                        pageIndex==2?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                  onPressed: (){
                                    pageIndex = 1;
                                    setState(() {
                                      
                                    });
                                  },
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                     children: const [
                                      Icon(Icons.arrow_back),
                                       Text('Back',
                                        style: TextStyle(
                                      fontSize: 18),),
                                       
                                     ],
                                   )),
                              ),
                              const SizedBox(
                                width: 30,
                                height: 30,
                                child: Card(child: Center(child: Text('1')),)),
                              const Text('....'),
                              const SizedBox(
                                width: 40,
                                height: 40,
                                child: Card(child: Center(child: Text('3')),)),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                  onPressed: (){
                                    if(nameController.text.isEmpty || emailController.text.isEmpty){
                                       showDialog(
                                         context: context,
                                         builder: (BuildContext context) {
                                           return  AlertDialog(
                                               title: const Text('Required'),
                                               content: const Text('Name and email are required field'),
                                               actions: <Widget>[
                                               ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                }, 
                                               child: const Text('Ok')),
                                               
                                             ],
                                         );
                                        },
                                       );
                                    }
                                    else{
                                      String profilePic ='';
                                      String logoPic ='';
                                      if(imageFile!=null && logoFile!=null) {
                                        print("==============Case 1====================");
                                        ApiService().file_upload(uid, access_token, imageFile!.path).then((value) {
                                          if (value.statusCode == 200) {
                                            value.stream
                                            .transform(utf8.decoder)
                                              .listen((event) {
                                              var path = jsonDecode(event);
                                            profilePic = path['file_path'];
                                             ApiService().file_upload(uid, access_token, logoFile!.path).then((value) {
                                           if (value.statusCode == 200) {
                                            value.stream
                                            .transform(utf8.decoder)
                                              .listen((event) {
                                              var path = jsonDecode(event);
                                            logoPic = path['file_path'];
                                            LabApiServices().fillLabProfile(uid, access_token, nameController.text, emailController.text, lat, long,
                                       profilePic, addressController.text, stateController.text, ownershipController.text,
                                        gstController.text,formattedDate==''?establishedDate:selectedDate.toString().substring(0,10), 
                                        pincodeController.text, logoPic, contactController.text).then((value) => 
                                         Navigator.pop(context,"Refresh"));
                                            });
                                             
                                          }
                                        });
                                            });
                                            
                                          }
                                        });
                                      }
                                      else if(imageFile!=null ) {
                                         print("==============Case 2====================");
                                         ApiService().file_upload(uid, access_token, imageFile!.path).then((value) {
                                           if (value.statusCode == 200) {
                                            value.stream
                                            .transform(utf8.decoder)
                                              .listen((event) {
                                              var path = jsonDecode(event);
                                              print(path);
                                            profilePic = path['file_path'];
                                            print(profilePic);
                                            LabApiServices().fillLabProfile(uid, access_token, nameController.text, emailController.text, lat, long,
                                       profilePic, addressController.text, stateController.text, ownershipController.text,
                                        gstController.text,formattedDate==''?establishedDate:selectedDate.toString().substring(0,10), 
                                        pincodeController.text, snapshot.data!.data.basicDetails.logoHalfPath, contactController.text).then((value) => 
                                         Navigator.pop(context,"Refresh"));
                                            });
                                             
                                          }
                                        });
                                      }
                                        else if(logoFile!=null ) {
                                           print("==============Case 3====================");
                                         ApiService().file_upload(uid, access_token, logoFile!.path).then((value) {
                                           if (value.statusCode == 200) {
                                            value.stream
                                            .transform(utf8.decoder)
                                              .listen((event) {
                                              var path = jsonDecode(event);
                                            logoPic = path['file_path'];
                                            LabApiServices().fillLabProfile(uid, access_token, nameController.text, emailController.text, lat, long,
                                       snapshot.data!.data.basicDetails.proHalfPath, addressController.text, stateController.text, ownershipController.text,
                                        gstController.text,formattedDate==''?establishedDate:selectedDate.toString().substring(0,10), 
                                        pincodeController.text, logoPic, contactController.text).then((value) => 
                                         Navigator.pop(context,"Refresh"));
                                            });
                                             
                                          }
                                        });
                                      }
                                      else{
                                         print("==============Case 4====================");
                                        LabApiServices().fillLabProfile(uid, access_token, nameController.text, emailController.text, lat, long,
                                       snapshot.data!.data.basicDetails.proHalfPath, addressController.text, stateController.text, ownershipController.text,
                                        gstController.text,formattedDate==''?establishedDate:selectedDate.toString().substring(0,10), 
                                        pincodeController.text, snapshot.data!.data.basicDetails.logoHalfPath, contactController.text).then((value) {
                                          Navigator.pop(context,"Refresh");
                                        });
                                      }
                                      
                                      // if(profileUploadStatus )
                                      // LabApiServices().fillLabProfile(uid, access_token, nameController.text, emailController.text, lat, long,
                                      //  profile, addressController.text, stateController.text, ownershipController.text,
                                      //   gstController.text,formattedDate==''?establishedDate:selectedDate.toString().substring(0,10), 
                                      //   pincodeController.text, logo, contactController.text);
                                    }
                                    setState(() {
                                    });
                                  },
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                     children: const [
                                       Text('Submit',
                                        style: TextStyle(
                                      fontSize: 18),),
                                     ],
                                   )),
                              )
                            ],
                          ):const SizedBox()
                      ],
                    ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          );}
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
          }
        ),
          
        );
  }

  _ImageButton(
    ImageSource source, String type,{
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
        if(type == 'profile') {
          setState(() {
          imageFile = img;
          print(imageFile.toString());
        });
        }
        if(type == 'logo'){
          setState(() {
            logoImage ='Logo added';
          logoFile = img;
          print(logoFile.toString());
        });
        }
      });
    }
  }
  
}
