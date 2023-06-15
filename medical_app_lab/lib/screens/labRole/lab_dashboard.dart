
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app_lab/screens/labRole/lab_api_services.dart';
import 'package:medical_app_lab/screens/labRole/lab_book_test.dart';
import 'package:medical_app_lab/screens/labRole/lab_profile_view.dart';
import 'package:medical_app_lab/screens/labRole/lab_report_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/constants.dart';
import '../startScreen/get_started.dart';
class LabDashboard extends StatefulWidget {
  const LabDashboard({super.key});

  @override
  State<LabDashboard> createState() => _LabDashboardState();
}
String? access_token;
String? uid;
class _LabDashboardState extends State<LabDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController testNameController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController testNameEditController = TextEditingController();
  TextEditingController feeEditController = TextEditingController();
  TextEditingController employeeIdEditController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  TextEditingController testNotesController = TextEditingController();
 
  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token= prefs.getString('access_token');
    uid=prefs.getString('user_id');
    print(uid);
    print(access_token);
  }
  var method=['doorstep','lab','both'];
  String methodvalue='doorstep';
  var indexId=0;
  var technicianId;
  @override
  void initState() {
    getProfile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[350],
          appBar: AppBar(
            backgroundColor: Colors.grey[350],
            leading: IconButton(
              icon: Icon(
                Icons.menu_rounded,
                size: 40,
                 color: Colors.grey[600],
              ),
              onPressed: () {
                _scaffoldkey.currentState?.openDrawer();
              },
            ),
          ),
          key: _scaffoldkey,
          drawer: Drawer(
            child: ListView(
              // Remove padding
              padding: EdgeInsets.zero, 
              children: [
                // UserAccountsDrawerHeader(
                //   accountName: Text(uName.toString()),
                //   accountEmail: Text(email.toString()),
                //   currentAccountPicture: CircleAvatar(
                //     backgroundImage:CachedNetworkImageProvider(profilePicture.toString()) ,
                  
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.blue[900],
                //     // image: DecorationImage(
                //     //     fit: BoxFit.fill,
                //     //     image: CachedNetworkImageProvider(baseUrl+profilePic.toString())),
                //   ),
                // ),
                const SizedBox(height: 50,),
                 ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Profile'),
                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const LabProfileView())),
                ),
                // ListTile(
                //   leading: Icon(Icons.calendar_month),
                //   title: Text('Upcoming appointments'),
                //  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>UpcomingAppointments())),
                // ),
                // ListTile(
                //   leading: Icon(Icons.history),
                //   title: Text('History'),
                //  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>History())),
                // ),
                // ListTile(
                //   leading: Icon(Icons.payment_outlined),
                //   title: Text('Transaction'),
                //  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Transaction())),
                // ),
                SizedBox(height: MediaQuery.of(context).size.height / 3.5),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log out'),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    // var phone =
                    //     Provider.of<PhoneProvider>(context, listen: false);
                    // phone.phoneNumber('', '', '');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const GetStarted()),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal:10.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                  const Text('Lab technicians',
                  style: TextStyle(fontSize: 17),
                  ),
                   IconButton(
                     onPressed: () async {
                      List ids = [];
                      var result = await showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                       return WillPopScope(
                        onWillPop: () async {
                          Navigator.pop(context,'Refresh');
                           return true;
                        },
                         child: AlertDialog(
                         title: const Text('Add lab technician'),
                                             // content: Text('This is an example of an alert dialog.'),
                         actions: <Widget>[
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height/1.9,
                                width: MediaQuery.of(context).size.width/1.05,
                                child:FutureBuilder(
                                future: LabApiServices().listAllLabTechnician(uid, access_token),
                              builder: (BuildContext context, snapshot) {
                            if(snapshot.hasData){
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  print(technicianId.map((items)=>items.employeeId==snapshot.data!.data[index].employeeId));
                                 // print(technicianId.contains(snapshot.data!.data[index].employeeId));
                                 // print(technicianId.contains( snapshot.data!.data[index].employeeId));
                                 if(technicianId.map((items)=>items.employeeId==snapshot.data!.data[index].employeeId).contains(true)||
                                 ids.contains(snapshot.data!.data[index].employeeId)){
                                  return Container();
                                 } 
                                 else{
                                   return
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.9,
                                      child: Card(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Image.network(snapshot.data!.data[index].profilePic)),
                                              const SizedBox(width: 10,),
                                            Column(
                                             // mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data!.data[index].employeeName),
                                                 Text(snapshot.data!.data[index].employeePhone),
                                                  Text(snapshot.data!.data[index].employeeId),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                  //technicianId.contains( snapshot.data!.data[index].employeeId)?const SizedBox()
                                 // :
                                    ElevatedButton(
                                      onPressed: (){
                                       LabApiServices().addLabTechnician(uid, access_token, snapshot.data!.data[index].employeeName,
                                         snapshot.data!.data[index].employeePhone, snapshot.data!.data[index].employeeId).then((value) {
                                          ids.add(snapshot.data!.data[index].employeeId);
                                          setState(() {
                                            
                                          });
                                         });
                                      }, 
                                      child:  const Text("Add"))
                                  ],
                                );
                                 }
                                });
                                }
                                else{
                                  return const Center(child: CircularProgressIndicator(),);
                                }
                                }
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: (){
                                  
                                        Navigator.pop(context,'Refresh');
                                      }, 
                                    child: const Text('Ok')),
                                  ),
                                ],
                              )
                            ],
                          )
                         
                         ],
                                            ),
                       );
                   },);}
                   );
                   print(result);
                    if (result == 'Refresh') {
                   print('refresh');
                       setState(() {
                       });
                     }
                     },
                     icon: const Icon(Icons.add)),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: SizedBox(
                height: 150,
                 child: FutureBuilder(
                  future: LabApiServices().listLabTechnician(uid, access_token),
                  builder: (BuildContext context, snapshot) {
                    print('=======================================');
                    print(snapshot.data);
                    if(snapshot.hasData){
                      technicianId = snapshot.data!.data;
                        print('----------------------');
                        print(technicianId);
                       return ListView.builder(
                        scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // technicianId = snapshot.data!.data;
                        // print('----------------------');
                        // print(technicianId);
                       // labTechnicianId.insert(index, snapshot.data!.data[index].employeeId);
                         return InkWell(
                          onTap: () async {
                             var result = await showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                       return AlertDialog(
                         title: const Text('Delete lab technician'),
                        // content: Text('This is an example of an alert dialog.'),
                         actions: <Widget>[
                         ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                          onPressed: (){
                          LabApiServices().deleteLabTechnician(uid, access_token, snapshot.data!.data[index].id).then((value) {
                            
                            Navigator.pop(context,'Refresh');
                          });               
                          },
                          child: const Text('Delete'))
                         ],
                       );});
                     },
                     );
                     print(result);
                      if (result == 'Refresh') {
                     print('refresh');
                         setState(() {
                          
                         });
                            setState(() {
                              
                            });
                       }
                          },
                           child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Card(
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data!.data[index].username),
                                      Text(snapshot.data!.data[index].mobile),
                                      Text(snapshot.data!.data[index].employeeId)
                                    ],
                                  ),
                            ),
                          ),
                         );
                      },
                    );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }),
               ),
             ),
            const SizedBox(height: 10,),
            Divider(
                color: Colors.grey[400],
                thickness: 4.0,
              ),
             // const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    const Text('Lab tests',
                    style: TextStyle(fontSize: 17),
                    ),
                     IconButton(
                       onPressed: () async {
                        var result = await showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                       return AlertDialog(
                         title: const Text('Add lab tests'),
                        // content: Text('This is an example of an alert dialog.'),
                         actions: <Widget>[
                         
                          TextField(
                             controller: testNameController,
                             decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.person_outline),
                               hintText: 'Test name',
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(30)),
                                 borderSide: BorderSide(width: 3, color: Colors.grey),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(30)),
                                 borderSide: BorderSide(width: 3, color: Colors.grey),
                               ),
                             ),
                            ),
                            const SizedBox(height: 10,),
                            TextField(
                             controller: feeController,
                             keyboardType: TextInputType.number,
                             decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.numbers),
                               hintText: 'Fee',
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(30)),
                                 borderSide: BorderSide(width: 3, color: Colors.grey),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(30)),
                                 borderSide: BorderSide(width: 3, color: Colors.grey),
                               ),
                             ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                      height: 60,
                      //width: MediaQuery.of(context).size.width/1.5,
                       child:DropdownButton(
                          value: methodvalue,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),  
                          items: method.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              methodvalue = newValue!;
                              indexId=method.indexOf(newValue);
                              print("mode--$methodvalue");
                              print("index--$indexId");
                            });
                          },
                        )
                     ),
                            const SizedBox(height: 20,),
                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               TextButton(
                                 onPressed: (){
                                    Navigator.pop(context,'Refresh');
                                 }, 
                                 child: const Text('Cancel')),
                               TextButton(
                                 onPressed: (){
                                   LabApiServices().addLabTest(uid, access_token, testNameController.text,
                                    feeController.text,indexId+1 );
                                    testNameController.clear();
                                    feeController.clear();
                                    employeeIdController.clear();
                                    Navigator.pop(context,'Refresh');
                                 },
                                  child: const Text('Submit'))
                             ],
                            )
                         ],
                       );});
                     },
                     );
                     print(result);
                      if (result == 'Refresh') {
                     print('refresh');
                         setState(() {
                         });
                       }
                       },
                       icon: const Icon(Icons.add)),
                   ],
                 ),
              ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: SizedBox(
                height: 150,
                 child: FutureBuilder(
                  future: LabApiServices().listLabTest(uid, access_token),
                  builder: (BuildContext context, snapshot) {
                    print('-------------------------------');
                    if(snapshot.hasData){
                       return ListView.builder(
                        scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                         return InkWell(
                          onTap: () async {
                      print('id-------${index}');
                      testNameEditController.text = snapshot.data!.data[index].test;
                      feeEditController.text = snapshot.data!.data[index].consultingFee;
                      methodvalue = snapshot.data!.data[index].method;
                       String id = snapshot.data!.data[index].id;
                      indexId=method.indexOf(methodvalue);
                     
                      print('id-------${index}');
                      setState(() {
                        
                      });
                            var result = await showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                       return AlertDialog(
                           title: const Text('Edit lab tests'),
                          // content: Text('This is an example of an alert dialog.'),
                           actions: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.5,
                              child: Column(
                                children: [
                                  TextField(
                                     controller: testNameEditController,
                                     decoration: const InputDecoration(
                                      // prefixIcon: Icon(Icons.person_outline),
                                       hintText: 'Test name',
                                       enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                     ),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextField(
                                     controller: feeEditController,
                                     keyboardType: TextInputType.number,
                                     decoration: const InputDecoration(
                                      // prefixIcon: Icon(Icons.numbers),
                                       hintText: 'Fee',
                                       enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                     ),
                                    ),
                                    const SizedBox(height: 10,),
                                    SizedBox(
                                      height: 60,
                                     //width: MediaQuery.of(context).size.width/1.5,
                                child:DropdownButton(
                                  value: methodvalue,
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),  
                                  items: method.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      methodvalue = newValue!;
                                      indexId=method.indexOf(newValue);
                                      print("mode--$methodvalue");
                                      print("index--$indexId");
                                    });
                                  },
                                                    )
                                  ),
                                    const SizedBox(height: 20,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/1.5,
                                      child: ElevatedButton(
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                        onPressed: (){
                                           LabApiServices().deleteLabTest(uid, access_token,snapshot.data!.data[index].id).then((value) {
                                            Navigator.pop(context,'Refresh');
                                           });
                                            // testNameEditController.clear();
                                            // feeEditController.clear();
                                            
                                        },
                                       child: const Text('Delete')),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       TextButton(
                                         onPressed: (){
                                            Navigator.pop(context,'Refresh');
                                         }, 
                                         child: const Text('Cancel')),
                                       TextButton(
                                         onPressed: (){
                                           LabApiServices().updateLabTest(uid, access_token, testNameEditController.text,
                                            feeEditController.text,indexId+1 ,snapshot.data!.data[index].id);
                                            testNameEditController.clear();
                                            feeEditController.clear();
                                            Navigator.pop(context,'Refresh');
                                         },
                                          child: const Text('Submit'))
                                     ],
                                    ),
                                ],
                              ),
                            )
                           ],
                         
                       );});
                     },
                     );
                     print(result);
                      if (result == 'Refresh') {
                     print('refresh');
                         setState(() {
                         });
                       }
                          },
                           child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Card(
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data!.data[index].test),
                                      Text(snapshot.data!.data[index].consultingFee),
                                      Text(snapshot.data!.data[index].method)
                                    ],
                                  ),
                            ),
                                             ),
                         );
                      },
                    );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }),
               ),
             ),
             const SizedBox(height: 10,),
             Divider(
                color: Colors.grey[400],
                thickness: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    const Text('Book lab test',
                    style: TextStyle(fontSize: 17),),
                    IconButton(
                      onPressed: ()  async {
                        String refresh = await  Navigator.push(context, MaterialPageRoute(builder: (context)=>const BookLabTest()));
                        if(refresh == 'Refresh')
                        {
                          setState(() {
                            
                          });
                        }
                      }, 
                      icon: const Icon(Icons.add))
                  ],
                ),
              ),
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: SizedBox(
                height: 150,
                 child: FutureBuilder(
                  future: LabApiServices().getLabBookingList(uid, access_token),
                  builder: (BuildContext context, snapshot) {
                    print('-------------------------------');
                    if(snapshot.hasData){
                       return ListView.builder(
                        scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                         return InkWell(
                          onTap: () async {
                               var result = await showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                       return AlertDialog(
                         title: const Text('Lab booking'),
                        // content: Text('This is an example of an alert dialog.'),
                         content: 
                          SizedBox(
                            child: Column(
                               mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                        if(snapshot.data!.data[index].master.reportPath ==''){
                                         showDialog(
                                           context: context,
                                           builder: (BuildContext context) {
                                           return StatefulBuilder(
                                            builder: (BuildContext context, StateSetter setState) {
                                             return const AlertDialog(
                                               title: Text('Report'),
                                               content: Text('Report not added.'),
                        
                                             );});
                                             },
                                           );
                     
                                        }  
                                        else{
                                          //Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LabReportPdfView(pdf:baseUrl+snapshot.data!.data[index].master.reportPath )));
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>LabReportPdfView(pdf:baseUrl+snapshot.data!.data[index].master.reportPath )));
                                        }             
                                    },
                                     child: const Text('View report')),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                            var result = await showDialog(
                     context: context,
                     builder: (BuildContext context) {
                      int count = 0;
                      int limit = snapshot.data!.data[index].sub.length;
                      List subId = [];
                      List testResult = [];
                      List testNotes = [];
                      for (var i = 0; i < limit; i++) {
                        subId.add(snapshot.data!.data[index].sub[i].id);
                        testResult.add(snapshot.data!.data[index].sub[i].testResult);
                        testNotes.add(snapshot.data!.data[index].sub[i].testNotes);
                      }
                      resultController.text = testResult[count];
                      testNotesController.text = testNotes[count];
                       return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                       return AlertDialog(
                           title: const Text('Add report result'),
                          // content: Text('This is an example of an alert dialog.'),
                           actions: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.5,
                              child: Column(
                                children: [
                                 
                                  SizedBox(
                                     width: MediaQuery.of(context).size.width/1.5,
                                    child: Container(
                                      decoration:  BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(color: Colors.grey,width: 3)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(snapshot.data!.data[index].sub[count].test),
                                      ),
                                    ),
                                  ),
                                    const SizedBox(height: 10,),
                                    TextField(
                                     controller: resultController,
                                     keyboardType: TextInputType.number,
                                     decoration: const InputDecoration(
                                      // prefixIcon: Icon(Icons.numbers),
                                       hintText: 'result',
                                       enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                     ),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextField(
                                     controller: testNotesController,
                                     decoration: const InputDecoration(
                                      // prefixIcon: Icon(Icons.numbers),
                                       hintText: 'notes',
                                       enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(30)),
                                         borderSide: BorderSide(width: 3, color: Colors.grey),
                                       ),
                                     ),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                      count!=0? SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                           onPressed: (){
                                               count = count-1;
                                               resultController.text = testResult[count];
                                               testNotesController.text = testNotes[count];
                                            print(count);
                                             setState(() {
                                              });
                                           }, 
                                           child: const Text('Back')),
                                      )
                                         :const SizedBox(),
                                      count<limit-1?SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          onPressed: (){
                                            subId.removeAt(count);
                                            testResult.removeAt(count);
                                            testNotes.removeAt(count);
                                            subId.insert(count,snapshot.data!.data[index].sub[count].id);
                                            testResult.insert(count,resultController.text);
                                            testNotes.insert(count,testNotesController.text);
                                            print(subId);
                                            print(testResult);
                                            count = count+1;
                                            testNotesController.clear();
                                            resultController.clear();
                                            resultController.text = testResult[count];
                                            testNotesController.text = testNotes[count];
                                            print(count);
                                             setState(() {
                                              });
                                          }, 
                                          child: const Text('Next')),
                                      )
                                      :SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          onPressed: (){
                                             subId.removeAt(count);
                                            testResult.removeAt(count);
                                            testNotes.removeAt(count);
                                            subId.insert(count,snapshot.data!.data[index].sub[count].id);
                                            testResult.insert(count,resultController.text);
                                            testNotes.insert(count,testNotesController.text);
                                            testNotesController.clear();
                                            resultController.clear();
                                            LabApiServices().updateLabTestReport(uid, access_token,
                                             snapshot.data!.data[index].master.id, 
                                             subId.join(';').toString(), testResult.join(';').toString(),
                                              testNotes.join(';').toString()).then((value) {
                                                Navigator.pop(context,'Refresh');
                                              });
                                            // count = count+1;
                                            // print(count);
                                            //  setState(() {
                                            //   });
                                          }, 
                                          child: const Text('Submit')),
                                      )
                                     ],
                                    ),
                                ],
                              ),
                            )
                           ],
                         
                       );});
                     },
                     );              
                                        },
                                 child: const Text('Add/Edit report')),
                                ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                              onPressed: (){
                              LabApiServices().deleteLabBooking(uid, access_token, snapshot.data!.data[index].master.id).then((value) {
                                
                                Navigator.pop(context,'Refresh');
                              });               
                              },
                              child: const Text('Delete')),
                            )
                              ],
                            ),
                          ),
                             
                        
                       );});
                     },
                     );
                     print(result);
                      if (result == 'Refresh') {
                     print('refresh');
                         setState(() {
                         });
                       }
                          },
                           child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Card(
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(DateFormat('dd/MM/yyyy').format(snapshot.data!.data[index].master.createdDatetime)),
                                      Text(snapshot.data!.data[index].master.username,),
                                      //Text('Tests')
                                      Text(snapshot.data!.data[index].master.id),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(DateFormat.jm().format(snapshot.data!.data[index].master.createdDatetime)),
                                        ],
                                      )
                                    ],
                                  ),
                            ),
                           ),
                         );
                      },
                    );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }),
               ),
             ),
          ],
        ),
      ),
    );
  }
}