import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app_lab/screens/labRole/lab_api_services.dart';
import 'package:medical_app_lab/screens/labRole/lab_dashboard.dart';
class BookLabTest extends StatefulWidget {
  const BookLabTest({super.key});

  @override
  State<BookLabTest> createState() => _BookLabTestState();
}

class _BookLabTestState extends State<BookLabTest> {
  FocusNode _patientNode =FocusNode();
  FocusNode _familyNode =FocusNode();
  FocusNode _testNode =FocusNode();
  FocusNode _technicianNode =FocusNode();
  FocusNode _doctorNode =FocusNode();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController familyMemberController = TextEditingController();
  TextEditingController labTestController = TextEditingController();
  TextEditingController labTechnicianController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController paymentStatusController = TextEditingController();
  var method=['doorstep','lab','both'];
  String methodvalue='doorstep';
  var indexId=0;
  String? labTechnicianId;
  String? labTestId;
  String? patientId;
  String? patientAccessToken;
  String? doctorId;
  String? familyMemberId;
  final List _selectedChips = [];
    List<Widget> _buildChips() {
    return _selectedChips.map((chip) {

      return InputChip(
        label: Text(chip['name']),
        onDeleted: () {
          setState(() {
            _selectedChips.remove(chip);
          });
          // if (widget.onChanged != null) {
          //   widget.onChanged(_selectedChips);
          // }
        },
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Book Test',style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
             // const Text("Patient name"),
              const SizedBox(height: 10,),
              TextField(
                  controller: patientNameController,
                  focusNode: _patientNode,
                  onChanged: (value) {
                    setState(() {
                      
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Patient name',
                    labelText: 'Patient name',
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
                const SizedBox(height: 5,),
                _patientNode.hasFocus?SizedBox(
              height: 120,
               child: Card(
                 child: FutureBuilder(
                  future: LabApiServices().getPatientList(uid, access_token),
                  builder: (BuildContext context, snapshot) {
                    print('-------------------------------===========');
                    print(snapshot);
                    print(snapshot.hasData);
                    if(snapshot.hasData){
                       return ListView.builder(
                        scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                         if(snapshot.data!.data[index].username.toString().toLowerCase().contains(
                            patientNameController.text.toString().toLowerCase())) {
                           return InkWell(
                            onTap: () {
                               patientNameController.text = snapshot.data!.data[index].username;
                              _patientNode.unfocus();
                              patientId = snapshot.data!.data[index].id;
                              patientAccessToken = snapshot.data!.data[index].accessToken;
                              setState(() {
                                
                              });
                            },
                             child: Card(
                             child:Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text('${snapshot.data!.data[index].username}'),
                                  Text(snapshot.data!.data[index].email,overflow: TextOverflow.ellipsis,)
                                // Text(snapshot.data!.data[index].consultingFee),
                                //  Text(snapshot.data!.data[index].method)
                               ],
                             ),
                           ),
                           );
                         }
                         else{
                          return const SizedBox();
                         }
                      },
                    );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }),
               ),)
                :const SizedBox(),
                // const SizedBox(height: 5,),
                // const Text("Family member"),
              const SizedBox(height: 10,),
              TextField(
                  controller: familyMemberController,
                  focusNode: _familyNode,
                  onChanged: (value) {
                    setState(() {
                      
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Family member',
                    labelText: 'Family member',
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
                 const SizedBox(height: 5,),
                  _familyNode.hasFocus?
                  patientId!=null &&patientAccessToken!=null? SizedBox(
              height: 120,
               child: Card(
                 child: FutureBuilder(
                  future: LabApiServices().getFamilyMemberList(patientId, patientAccessToken),
                  builder: (BuildContext context, snapshot) {
                    print('-------------------------------');
                    if(snapshot.hasData){
                       return ListView.builder(
                        scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                         if(snapshot.data!.data[index].username.toString().toLowerCase().contains(
                            familyMemberController.text.toString().toLowerCase())) {
                           return InkWell(
                            onTap: () {
                              familyMemberController.text = snapshot.data!.data[index].username;
                              _familyNode.unfocus();
                              familyMemberId = snapshot.data!.data[index].id;
                              setState(() {
                                
                              });
                            },
                             child: Card(
                             child:Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text('${snapshot.data!.data[index].username}'),
                                 // Text(snapshot.data!.data[index].email,overflow: TextOverflow.ellipsis,)
                                // Text(snapshot.data!.data[index].consultingFee),
                                //  Text(snapshot.data!.data[index].method)
                               ],
                             ),
                           ),
                           );
                         }
                         else{
                          return const SizedBox();
                         }
                      },
                    );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }),
               ),):const Center(child: Text("Add patient first"))
                :const SizedBox(),
                // Text("Lab test"),
              const SizedBox(height: 10,),
              Wrap(
                children: [
                  ..._buildChips(),
                  TextField(
                      controller: labTestController,
                      focusNode: _testNode,
                      onChanged: (value) {
                        setState(() {
                          
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Lab test',
                        labelText: 'Lab test',
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
                ],
              ),
                // const SizedBox(height: 5,),
                // const Text("Lab technician"),
                const SizedBox(height: 5,),
                _testNode.hasFocus?SizedBox(
              height: 120,
               child: Card(
                 child: FutureBuilder(
                  future: LabApiServices().listLabTest(uid, access_token),
                  builder: (BuildContext context, snapshot) {
                    print('-------------------------------');
                    if(snapshot.hasData){
                       return ListView.builder(
                        scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (BuildContext context, int index) {
                         if(snapshot.data!.data[index].test.toString().toLowerCase().contains(
                            labTestController.text.toString().toLowerCase())) {
                           return InkWell(
                            onTap: () {
                               labTestController.text = snapshot.data!.data[index].test;
                              _testNode.unfocus();
                              if(_selectedChips.map((items)=>items['id']==snapshot.data!.data[index].id).contains(true)){
                                 ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content: Text('Already Selected'),
                                  ));
                              }
                              else{
                                var data ={'name':snapshot.data!.data[index].test,'id': snapshot.data!.data[index].id};
                                _selectedChips.add(data);
                              }
                              print(_selectedChips);
                              labTestController.clear();
                              //labTestId = snapshot.data!.data[index].id;
                              setState(() {
                                
                              });
                            },
                             child: Card(
                             child:Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text('${snapshot.data!.data[index].test},'),
                                  Text(snapshot.data!.data[index].method),
                                //  Text(snapshot.data!.data[index].method)
                               ],
                             ),
                           ),
                           );
                         }
                         else{
                          return const SizedBox();
                         }
                      },
                    );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }),
               ),)
                :const SizedBox(),
              const SizedBox(height: 10,),
              TextField(
                  controller: labTechnicianController,
                  focusNode: _technicianNode,
                  onChanged: (value) {
                    setState(() {
                      
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Lab technician',
                    labelText: 'Lab technician',
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
                const SizedBox(height: 5,),
                _technicianNode.hasFocus?SizedBox(
                  height: 120,
                  child: Card(
                    child: FutureBuilder(
                    future: LabApiServices().listLabTechnician(uid, access_token),
                    builder: (BuildContext context, snapshot) {
                      print('=======================================');
                      print(snapshot.data);
                      if(snapshot.hasData){
                         return ListView.builder(
                          scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                         // labTechnicianId.insert(index, snapshot.data!.data[index].employeeId);
                         if(snapshot.data!.data[index].username.toString().toLowerCase().contains(
                          labTechnicianController.text.toString().toLowerCase())) {
                           return InkWell(
                            onTap: () {
                              labTechnicianController.text = snapshot.data!.data[index].username;
                              _technicianNode.unfocus();
                              labTechnicianId = snapshot.data!.data[index].id;
                              setState(() {
                                
                              });
                            },
                             child: Card(
                               child:Row(
                                 //mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text('${snapshot.data!.data[index].username},'),
                                   Text(snapshot.data!.data[index].mobile),
                                   //Text(snapshot.data!.data[index].employeeId)
                                 ],
                               ),
                              ),
                           );
                         }
                         else{
                          return const SizedBox();
                         }
                        },
                      );
                      }
                      else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    }),
                  ),
                )
                :const SizedBox(),
                // const SizedBox(height: 5,),
                // const Text("Doctor"),
              const SizedBox(height: 10,),
                TextField(
                  controller: doctorController,
                  focusNode: _doctorNode,
                  onChanged: (value) {
                    setState(() {
                      
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Doctor',
                    labelText: 'Doctor',
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
                const SizedBox(height: 5,),
                _doctorNode.hasFocus?SizedBox(
                  height: 120,
                  child: Card(
                    child: FutureBuilder(
                    future: LabApiServices().getDoctorsList(uid, access_token),
                    builder: (BuildContext context, snapshot) {
                      print('=======================================');
                      print(snapshot.hasData);
                      if(snapshot.hasData){
                         return ListView.builder(
                          scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                         // labTechnicianId.insert(index, snapshot.data!.data[index].employeeId);
                         if(snapshot.data!.data[index].doctorName.toString().toLowerCase().contains(
                          doctorController.text.toString().toLowerCase())) {
                           return InkWell(
                            onTap: () {
                              doctorController.text = snapshot.data!.data[index].doctorName;
                              _doctorNode.unfocus();
                              doctorId = snapshot.data!.data[index].doctorId;
                              setState(() {
                                
                              });
                            },
                             child: Card(
                               child:Row(
                                 //mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text('${snapshot.data!.data[index].doctorName}-'),
                                  Text(snapshot.data!.data[index].specialization),
                                   //Text(snapshot.data!.data[index].employeeId)
                                 ],
                               ),
                              ),
                           );
                         }
                         else{
                          return const SizedBox();
                         }
                        },
                      );
                      }
                      else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    }),
                  ),
                )
                :const SizedBox(),
                
                      const SizedBox(height: 10,),
                      TextField(
                             controller: paymentMethodController,
                             onChanged: (value) {
                                setState(() {
                      
                              });
                              },
                             decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.person_outline),
                               hintText: 'Payment method',
                               labelText: 'Payment method',
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
                             controller: paymentStatusController,
                             onChanged: (value) {
                                setState(() {
                      
                              });
                              },
                             decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.person_outline),
                               hintText: 'Payment status',
                               labelText: 'Payment status',
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
                             controller: transactionIdController,
                             onChanged: (value) {
                                setState(() {
                      
                              });
                              },
                             decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.person_outline),
                               hintText: 'Transaction id',
                               labelText: 'Transaction id',
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
                             controller: prescriptionController,
                             onChanged: (value) {
                                setState(() {
                      
                              });
                              },
                             decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.person_outline),
                               hintText: 'Doctor prescription',
                               labelText: 'Doctor prescription',
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
                             controller: notesController,
                             onChanged: (value) {
                                setState(() {
                      
                                });
                              },
                             decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.numbers),
                               hintText: 'Notes',
                               labelText: 'Notes',
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
                          const SizedBox(height: 5,),
                      const Text("Visit type"),
                      const SizedBox(height: 5,),
                      DropdownButton(
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
                      ),
                      const SizedBox(height: 30,),
                        Center(
                          child: SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed:(){
                                String testIds = _selectedChips.map((item) => item['id'].toString()).join(',');
                                LabApiServices().bookLabTest(uid, access_token, patientId, doctorId, testIds, familyMemberId,
                                 labTechnicianId, paymentMethodController.text, transactionIdController.text, paymentStatusController.text,
                                  indexId+1, prescriptionController.text, notesController.text).then((value){
                                  var data = jsonDecode(value.body);
                                  Navigator.pop(context,'Refresh');
                          });
                      },
                   child: const Text('Submit')),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}