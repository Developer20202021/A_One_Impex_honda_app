import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';





class VehicleRegistrationForm extends StatefulWidget {

  final List SaleInfo;

  
  const VehicleRegistrationForm({super.key, required this.SaleInfo});

  @override
  State<VehicleRegistrationForm> createState() => _VehicleRegistrationFormState();
}

class _VehicleRegistrationFormState extends State<VehicleRegistrationForm> {


  TextEditingController NameController = TextEditingController();
  TextEditingController FatherNameController = TextEditingController();
  TextEditingController MotherNameController = TextEditingController();
  TextEditingController HusbandNameController = TextEditingController();
  TextEditingController PresentAddressController = TextEditingController();
  TextEditingController PermanentAddressController = TextEditingController();
  TextEditingController SEXController = TextEditingController();
  TextEditingController CellPhoneNoController = TextEditingController();
  TextEditingController NationalityController = TextEditingController();
  TextEditingController DateOfBirthController = TextEditingController();
  TextEditingController NIDNoController = TextEditingController();
  TextEditingController eTINNoController = TextEditingController();
  TextEditingController GuardianNameController = TextEditingController();
  TextEditingController VehicleRegistrationNoController = TextEditingController();
  TextEditingController YearOfMFGOfVehicleController = TextEditingController();
  TextEditingController PrevRegistrationNoController = TextEditingController();
  TextEditingController BankNameforFeeTaxDepositController = TextEditingController();



  bool loading = false;


  void getSaleData(){

    print(widget.SaleInfo);
  }



  @override
  void initState() {
    // TODO: implement initState




      getSaleData();


    super.initState();
  }







   

  @override
  Widget build(BuildContext context) {


    NameController.text = widget.SaleInfo[0]["CustomerName"];
    FatherNameController.text = widget.SaleInfo[0]["CustomerFatherName"];
    MotherNameController.text = widget.SaleInfo[0]["CustomerMotherName"];
    NIDNoController.text = widget.SaleInfo[0]["CustomerNID"];
    PresentAddressController.text = widget.SaleInfo[0]["CustomerAddress"];
    PermanentAddressController.text = widget.SaleInfo[0]["CustomerAddress"];
    CellPhoneNoController.text = widget.SaleInfo[0]["CustomerPhoneNumber"];
    





    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("OWNERS PARTICULARS/SPECIMEN SIGNATURE",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF1A1A3F),
          secondRingColor: Theme.of(context).primaryColor,
          thirdRingColor: Colors.white,
          size: 100,
        ),
      ):SingleChildScrollView(

        child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name(BLOCK LETTER)',
            
                          hintText: 'Name(BLOCK LETTER)',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: NameController,
                    ),

                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fathers Name',
            
                          hintText: 'Fathers Name',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: FatherNameController,
                    ),


                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mothers Name',
            
                          hintText: 'Mothers Name',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: MotherNameController,
                    ),


                     SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Husbands Name',
            
                          hintText: 'Husbands Name',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: HusbandNameController,
                    ),

                     SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Present Address',
            
                          hintText: 'Present Address',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: PresentAddressController,
                    ),


                     SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Permanent Address',
            
                          hintText: 'Permanent Address',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: PermanentAddressController,
                    ),


                     SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'SEX',
            
                          hintText: 'SEX',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: SEXController,
                    ),


                     SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Cell Phone No',
            
                          hintText: 'Cell Phone No',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: CellPhoneNoController,
                    ),


                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nationality',
            
                          hintText: 'Nationality',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: NationalityController,
                    ),


                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Date Of Birth',
            
                          hintText: 'Date Of Birth',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: DateOfBirthController,
                    ),




                     SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'NID No',
            
                          hintText: 'NID No',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: NIDNoController,
                    ),


                     SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'e-TIN No',
            
                          hintText: 'e-TIN No',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: eTINNoController,
                    ),



                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Guardian Name',
            
                          hintText: 'Guardian Name',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: GuardianNameController,
                    ),


                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Vehicle Registration No',
            
                          hintText: 'Vehicle Registration No',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: VehicleRegistrationNoController,
                    ),


                    //  SizedBox(height: 20,),


                    // TextField(
                    //   
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Engine No',
            
                    //       hintText: 'Engine No',
                    //       //  enabledBorder: OutlineInputBorder(
                    //       //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //       //   ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                    //         ),
                    //         errorBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //               width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    //         ),
                          
                          
                    //       ),
                    //   controller: EngineNoController,
                    // ),


                    // SizedBox(height: 20,),


                    // TextField(
                    //   
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Chassis No',
            
                    //       hintText: 'Chassis No',
                    //       //  enabledBorder: OutlineInputBorder(
                    //       //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //       //   ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                    //         ),
                    //         errorBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //               width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    //         ),
                          
                          
                    //       ),
                    //   controller: ChassisNoController,
                    // ),



                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Year Of MFG Of Vehicle',
            
                          hintText: 'Year Of MFG Of Vehicle',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: YearOfMFGOfVehicleController,
                    ),


                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Prev Registration No',
            
                          hintText: 'Prev Registration No',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: PrevRegistrationNoController,
                    ),



                    SizedBox(height: 20,),


                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Bank Name for Fee/Tax Deposit',
            
                          hintText: 'Bank Name for Fee/Tax Deposit',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: BankNameforFeeTaxDepositController,
                    ),





                    
              
         
           
                    
            ],
          ),
        ),
        ),
      
      
    );
  }
}



