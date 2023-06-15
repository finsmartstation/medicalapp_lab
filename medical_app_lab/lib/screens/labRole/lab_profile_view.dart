import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app_lab/screens/labRole/lab_api_services.dart';
import 'package:medical_app_lab/screens/labRole/lab_dashboard.dart';
import 'package:medical_app_lab/screens/labRole/lab_profile.dart';
import 'package:medical_app_lab/service/api_services.dart';
class LabProfileView extends StatefulWidget {
  const LabProfileView({super.key});

  @override
  State<LabProfileView> createState() => _LabProfileViewState();
}

class _LabProfileViewState extends State<LabProfileView> {
   List<XFile>? _imageFileList;
  File? imageFile;
  File? logoFile;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
    // print("File : ${value!.}");
  }
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Profile',style: TextStyle(color: Colors.black),),
        actions: [
         IconButton(
          onPressed: () async {
           String refresh= await Navigator.push(context, MaterialPageRoute(builder: (context)=>const LabProfile()));
            if(refresh=='Refresh'){
              setState(() {
                
              });
            }
          }, 
          icon: const Icon(Icons.edit,color: Colors.black,))
        ],
      ),
      body: FutureBuilder(
         future: LabApiServices().getLabProfileDetails(uid, access_token),
                builder: (BuildContext context, snapshot) {
                  if(snapshot.hasData){
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Stack(
                children: [
                  Center(
                    child:
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
                                            :snapshot.data!.data.basicDetails.profilePic ==''? Container(
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
                      :Container(
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
              imageFile!=null?InkWell(
                onTap: (){
                  showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       title: const Text('Update Profile picture'),
                      
                       actions: <Widget>[
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           ElevatedButton(
                              onPressed: (){
                                imageFile =null;
                                setState(() {
                                  
                                });
                              Navigator.pop(context);
                              }, 
                             child: const Text('Cancel')),
                           ElevatedButton(
                              onPressed: (){
                                String profilePic ='';
                                 ApiService().file_upload(uid, access_token, imageFile!.path).then((value) {
                                           if (value.statusCode == 200) {
                                            value.stream
                                            .transform(utf8.decoder)
                                              .listen((event) {
                                              var path = jsonDecode(event);
                                              print(path);
                                            profilePic = path['file_path'];
                                            print(profilePic);
                                            LabApiServices().updateLabProfile(uid, access_token, profilePic).then((value) {
                                              imageFile = null;
                                              setState(() {
                                                
                                              });
                                            });
                                            });
                                          }
                                        });
                              Navigator.pop(context);
                              }, 
                             child: const Text('Update')),
                         ],
                       ),
                       ],
                     );
                   },
                   );
                },
                child: const Text(
                  "Update profile picture",
                  style: TextStyle(color: Colors.blue,),))
              :const SizedBox(),
              const SizedBox(height: 10,),
               Row(
                 children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Name :")),
                   Container(
                       // height: 65,
                        width: MediaQuery.of(context).size.width/1.6,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width:3,color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.data.basicDetails.username,
                              style: const TextStyle(color: Colors.black54,fontSize: 16),
                                ),
                    ),
                  ),
                 ],
               ),
                const SizedBox(height: 10,),
               Row(
                 children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Email :")),
                   Container(
                       // height: 65,
                        width: MediaQuery.of(context).size.width/1.6,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width:3,color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.data.basicDetails.email,
                              style: const TextStyle(color: Colors.black54,fontSize: 16),
                                ),
                      
                    ),
                  ),
                 ],
               ),
                const SizedBox(height: 10,),
                 Row(
                 children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Phone :")),
                   Container(
                       // height: 65,
                        width: MediaQuery.of(context).size.width/1.6,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width:3,color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.data.basicDetails.mobile,
                              style: const TextStyle(color: Colors.black54,fontSize: 16),
                                ),
                      
                    ),
                  ),
                 ],
               ),
                const SizedBox(height: 10,),
               Row(
                 children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Address :")),
                   Container(
                       // height: 65,
                        width: MediaQuery.of(context).size.width/1.6,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width:3,color: Colors.grey)),
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.data.basicDetails.address,
                              maxLines: 5,
                                style: const TextStyle(color: Colors.black54,fontSize: 16),
                                ),
                            ),
                  ),
                 ],
               ),
               const SizedBox(height: 10,),
               Row(
                 children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Owner :")),
                   Container(
                       // height: 65,
                        width: MediaQuery.of(context).size.width/1.6,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width:3,color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.data.basicDetails.ownership,
                              style: const TextStyle(color: Colors.black54,fontSize: 16),
                                ),
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 10,),
               Row(
                 children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Contact :")),
                   Container(
                       // height: 65,
                        width: MediaQuery.of(context).size.width/1.6,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(width:3,color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data!.data.basicDetails.emergencyContact,
                              style: const TextStyle(color: Colors.black54,fontSize: 16),
                                ),
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 10,),
               Row(
                 children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Logo :")),
                   InkWell(
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
                        :snapshot.data!.data.basicDetails.logo != ''?
                          SizedBox(
                            height: 100,
                          width: 100,
                            child: Image.network(snapshot.data!.data.basicDetails.logo))
                        
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
                         // height: 65,
                          width: MediaQuery.of(context).size.width/2.5,
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width:3,color: Colors.grey)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Lab logo",
                                style: TextStyle(color: Colors.black54,fontSize: 16),
                                  ),
                      ),
                                     ),
                   ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
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
                     child: const Icon(Icons.upload))
                 ],
               ),
               const SizedBox(height: 10,),
               logoFile!=null?InkWell(
                onTap: (){
                  showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       title: const Text('Update Logo'),
                      
                       actions: <Widget>[
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           ElevatedButton(
                              onPressed: (){
                                imageFile =null;
                                setState(() {
                                  
                                });
                              Navigator.pop(context);
                              }, 
                             child: const Text('Cancel')),
                           ElevatedButton(
                              onPressed: (){
                                String logoPic ='';
                                 ApiService().file_upload(uid, access_token, logoFile!.path).then((value) {
                                           if (value.statusCode == 200) {
                                            value.stream
                                            .transform(utf8.decoder)
                                              .listen((event) {
                                              var path = jsonDecode(event);
                                              print(path);
                                            logoPic = path['file_path'];
                                            print(logoPic);
                                            LabApiServices().updateLabLogo(uid, access_token, logoPic).then((value) {
                                              logoFile = null;
                                              setState(() {
                                                
                                              });
                                            });
                                            });
                                          }
                                        });
                              Navigator.pop(context);
                              }, 
                             child: const Text('Update')),
                         ],
                       ),
                       ],
                     );
                   },
                   );
                },
                child: const Text(
                  "Update logo",
                  style: TextStyle(color: Colors.blue,),))
              :const SizedBox(),
            ],
          ),
        );}
        else{
          return const Center(child: CircularProgressIndicator(),);
        }}
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
            //logoImage ='Logo added';
          logoFile = img;
          print(logoFile.toString());
        });
        }
      });
    }
  
  }
}