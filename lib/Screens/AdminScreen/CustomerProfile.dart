import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tvs_app/Screens/AdminScreen/AfterSaleBike.dart';
import 'package:tvs_app/Screens/AdminScreen/AllAdmin.dart';
import 'package:tvs_app/Screens/AdminScreen/AllCustomer.dart';
import 'package:tvs_app/Screens/AdminScreen/AllPDF/DuePayMemo.dart';
import 'package:tvs_app/Screens/AdminScreen/AllPDF/NameChangeFrom.dart';
import 'package:tvs_app/Screens/AdminScreen/AllPDF/ServiceMemo.dart';
import 'package:tvs_app/Screens/AdminScreen/CustomerInvoice.dart';
import 'package:tvs_app/Screens/AdminScreen/EditCustomerInfo.dart';
import 'package:tvs_app/Screens/AdminScreen/EditPreviousCustomerInfo.dart';
import 'package:tvs_app/Screens/AdminScreen/HomeScreen.dart';
import 'package:tvs_app/Screens/AdminScreen/MyServices.dart';
import 'package:tvs_app/Screens/AdminScreen/SingleCustomerFile.dart';
import 'package:tvs_app/Screens/CommonScreen/ProductScreen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tvs_app/Screens/DeveloperFolder/InternetChecker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:uuid/uuid.dart';




class CustomerProfile extends StatefulWidget {


  final String CustomerID;
  





  const CustomerProfile({super.key, required this.CustomerID});

  @override
  State<CustomerProfile> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<CustomerProfile> {

   var uuid = Uuid();


TextEditingController DueAmountController = TextEditingController();

TextEditingController NewOwnerNameController = TextEditingController();

TextEditingController NewOwnerAddressController = TextEditingController();

TextEditingController NewOwnerFatherNameController = TextEditingController();

TextEditingController NewOwnerPhoneNoController = TextEditingController();

TextEditingController FeeAmountController = TextEditingController();

TextEditingController NewOwnerNIDController = TextEditingController();

TextEditingController ServiceNameController = TextEditingController();

TextEditingController ServiceAmountController = TextEditingController();





bool loading = true;







   // Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('customer');

Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("CustomerID", isEqualTo: widget.CustomerID);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      //  loading = false;
        getSaleData();
     });

    print(AllData);
}














  // Firebase All Customer Data Load

List  AllSaleData = [];
var BikeSaleDataLoad = "";



Future<void> getSaleData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
  // setState(() {
  //   loading = true;
  // });


  CollectionReference _collectionBikeSaleRef =
    FirebaseFirestore.instance.collection('BikeSaleInfo');

    Query BikeSaleDataQuery = _collectionBikeSaleRef.where("CustomerID", isEqualTo: widget.CustomerID);
    QuerySnapshot BikeSaleDataQuerySnapshot = await BikeSaleDataQuery.get();

    // Get data from docs and convert map to List
     AllSaleData = BikeSaleDataQuerySnapshot.docs.map((doc) => doc.data()).toList();

       if (AllSaleData.length == 0) {
      setState(() {
        BikeSaleDataLoad = "0";
        // AllSaleData.insert(AllSaleData.length,0);
        loading = false;
      });
       
     } else {

      setState(() {
      
       AllSaleData = BikeSaleDataQuerySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }

    print(AllSaleData);
}









bool online = true;
Future getInternetValue() async{

bool onlineData =await getInternetConnectionChecker().getInternetConnection() ;

setState(() {
  online = onlineData;
  
});


}


late var timer;







@override
  void initState() {

 if (mounted) {
   var period = const Duration(seconds:1);
   timer = Timer.periodic(period,(arg) {
                  getInternetValue();
    });
   
 }
    // TODO: implement initState
    
    getData();

    // getSaleData();
    super.initState();
  }



  @override
void dispose() {
  timer.cancel();
  super.dispose();
}



  Future refresh() async{


    setState(() {
            loading = true;
            
           getData();
          //  getSaleData();

    });

  }
















  @override
  Widget build(BuildContext context) {



    var ServiceID = uuid.v4();
    


 

    return  Scaffold(
      backgroundColor: Colors.white,


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () async{



                   FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                    }
                  });





                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {

     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));


                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));




                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),),
      ),
      
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Customer Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child:loading?LinearProgressIndicator()
        : online==false?Center(child: Text("No Internet Connection", style: TextStyle(fontSize: 24, color: Colors.red),)):SingleChildScrollView(
      
                child: Padding(
                  padding:  EdgeInsets.only(left:kIsWeb?205:5, right: kIsWeb?205:5, bottom: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      
                      Center(
                        child:  ClipOval(
                          child: Image.network(
                            AllData[0]["CustomerImageUrl"]==""?"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoocHKiIUok-RD7VaxEivcDEwGLdbsMO5JL66hM1Z12x9t6kEvwqKoUNvDeRBc6H9dh4g&usqp=CAU":"${AllData[0]["CustomerImageUrl"]}",
                            width: 200,
                            height: 150,
                          ),
                        ),
                      ),
              
               SizedBox(
                        height: 20,
                      ),
      
      
                  Table(
                       border: TableBorder(
                       horizontalInside:
                  BorderSide(color: Colors.white, width: 10.0)),
                      textBaseline: TextBaseline.ideographic,
                        children: [
      
                  
                  
      
                        TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  
                                  
                                  Container(
                                    
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AllData[0]["CustomerName"].toString()}", style: TextStyle(fontSize: 15.0),),
                                    )),
                                
                                ]),
      
      
      
      
                        TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Father Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerFatherName"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
      
      
      
                        TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mother Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerMotherName"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
                        TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Email", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerEmail"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
      
                         TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerAddress"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
      
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Phone Number", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerPhoneNumber"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
      
      
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("NID", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerNID"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
      
                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Guarantor1 Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerGuarantor1Name"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
                          TableRow(children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Guarantor1 Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerGuarantor1Address"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Guarantor1 Phone Number", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerGuarantor1PhoneNumber"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Guarantor2 Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerGuarantor2Name"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Guarantor2 Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerGuarantor2Address"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Guarantor2 Phone Number", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerGuarantor2PhoneNumber"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Guarantor2 NID", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerGuarantor2NID"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                                
      
                           TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Customer Type", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  )),
                                  Container(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${AllData[0]["CustomerType"]}", style: TextStyle(fontSize: 15.0),),
                                  )),
                                
                                ]),
                         
                          
      
      
                   
      
                      
      
                         
                    
                       
                        ],
                      ),


                    SizedBox(height: 15,),




                    for(int i = 0; i<AllSaleData.length; i++)

                     BikeSaleDataLoad == "0" ?Text("No Data Available"):Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 230, 250),
      
                  border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: ListTile(
                      
                   
                        
                              title: Text("${AllSaleData[i]["BikeName"]}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              trailing: 
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      // your logic
                                    },
                                    itemBuilder: (BuildContext bc) {
                                      return  [


                            
                            PopupMenuItem(
                              child: Text("আমার সার্ভিস", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                              onTap: () {


                      Navigator.push(
                        context,MaterialPageRoute(builder: (context) => MyServiceHistory(SaleID: AllSaleData[i]["SaleID"])),
                      );
                                
                              },
                              value: '/hello',
                            ),



                              

                     

                            PopupMenuItem(
                                child: Text("সার্ভিস যুক্ত করুন", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                                            value: '/about',
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";
                                                  String Title ="নিচে সার্ভিসের নাম লিখবেন";

                                                  String LabelText ="সার্ভিসের নাম লিখবেন";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title:  Column(
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                  "${Title}", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                                                            ),

                                                            
                                                    

                                
                                                          ],
                                                        ),
                                                        content: SingleChildScrollView(
                                                          
                                                          child:  Column(
                                                            children: [
              
              Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '${LabelText}',

                      hintText: '${LabelText}',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: ServiceNameController,
                  ),
                ),


                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                      SizedBox(
                              height: 20,
                            ),

                    

                    Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'সার্ভিস ফি(৳)',

                      hintText: 'সার্ভিস ফি(৳)',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: ServiceAmountController,
                  ),
                ),






                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),


                                                  ElevatedButton(
                                                          onPressed:
                                                            () async {

            setState((){

              loading = true;

            });


            var updateData =
                      {
                        "ServiceID": ServiceID,
                        "CustomerID":"${widget.CustomerID}",
                        "ServiceName":ServiceNameController.text.trim().toLowerCase(),
                        "FileNo":AllSaleData[i]["BikeDeliveryNo"],
                        "ServiceAmount":ServiceAmountController.text.trim().toLowerCase(),
                        "BikeID":AllSaleData[i]["BikeID"],
                        "SaleID":AllSaleData[i]["SaleID"],
                        "CustomerAddress":AllSaleData[i]["CustomerAddress"],
                        "CustomerName":AllSaleData[i]["CustomerName"],
                        "CustomerPhoneNumber":AllSaleData[i]["CustomerPhoneNumber"],
                        "year":"${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "DateTime":DateTime.now().toIso8601String(),
                        "CollectorName":"",
                        "CollectorEmail":""
                        };

                  final StudentInfo = FirebaseFirestore.instance.collection('ServiceInfo').doc(ServiceID);
                  
                  StudentInfo.set(updateData).then((value) =>setState(() {
                                        

                          Navigator.push(
                        context,MaterialPageRoute(builder: (context) => ServiceMemoPDFPreview(CreditData: [updateData],)),
                      );

                                final snackBar = SnackBar(
                                        
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                        titleFontSize: 12,
                                        title: 'successfull',
                                        message: 'Hey Thank You. Good Job',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                                ),
                                            );

                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                       setState(() {
                        loading = false;
                             });
                            }))
                      .onError((error,stackTrace) =>setState(() {
                        final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                        title: 'Something Wrong!!!!',
                        message: 'Try again later...',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                            ),
                        );

                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                      setState(() {
                            loading = false;
                               });
                      }));




                                                                  },
                                                                  child: const Text(
                                                                      "Save"),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),




















                                      PopupMenuItem(
                                          child: Text("All Owners"),
                                          onTap: () {


                                      
                    showDialog(
                      context: context,
                      builder: (context) {
                       
                        bool payLoading = false;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                            title: Text('Show Owner'),
                            content:AllSaleData[i]["AllOwners"].isEmpty?Center(child: Text("Only One Owner available..."),):SingleChildScrollView(
                              child: Column(
                                children: [


                                  Text("All Owners"),

                                  SizedBox(height: 2,),


                    for(int x = 0; x<AllSaleData[i]["AllOwners"].length; x++)
                                 x==(int.parse(AllSaleData[i]["AllOwners"].length.toString())-1)? Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Material(
                                    elevation: 20.0,
                                    shadowColor: Colors.blueGrey,
                                     child: ListTile(
                                      textColor: Colors.green,
                                        title: Text("Owner Name: ${AllSaleData[i]["AllOwners"][x]["NewCustomerName"]}"),

                                        trailing: ElevatedButton(onPressed: () {


                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  NameChangePDFView(NameChangeData: [AllSaleData[i]["AllOwners"][x]])),
                                        );




                                        }, child: Text("Print")),
                                     
                                        subtitle: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                     
                                            Text("Owner Name: ${AllSaleData[i]["AllOwners"][x]["NewCustomerName"]}"),
                                     
                                     
                                            Text("Owner Phone No: ${AllSaleData[i]["AllOwners"][x]["NewCustomerPhoneNumber"]}"),
                                     
                                     
                                            Text("Owner Father Name: ${AllSaleData[i]["AllOwners"][x]["NewCustomerFatherName"]}"),
                                     
                                            
                                     
                                     
                                            Text("Previous Owner Name: ${AllSaleData[i]["AllOwners"][x]["PreviousCustomerName"]}"),
                                     
                                            Text("Previous Owner Phone No: ${AllSaleData[i]["AllOwners"][x]["PreviousCustomerPhoneNumber"]}"),
                                     
                                            Text("Previous Owner Address: ${AllSaleData[i]["AllOwners"][x]["PreviousCustomerAddress"]}"),
                                     
                                            Text("OwnerShipChangeFee: ${AllSaleData[i]["AllOwners"][x]["FeeAmount"]}"),
                                     
                                     
                                            Text("Owner Change Date: ${AllSaleData[i]["AllOwners"][x]["PaymentDate"]}"),
                                     
                                     
                                     
                                     
                                          ],
                                        ),
                                     
                                      ),
                                   ),
                                 ):ListTile(
                                    trailing: ElevatedButton(onPressed: (){

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  NameChangePDFView(NameChangeData: AllSaleData[i]["AllOwners"][x])),
                                        );


                                    }, child: Text("Print")),
                                    title: Text("Owner Name: ${AllSaleData[i]["AllOwners"][x]["NewCustomerName"]}"),

                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text("Owner Name: ${AllSaleData[i]["AllOwners"][x]["NewCustomerName"]}"),


                                        Text("Owner Phone No: ${AllSaleData[i]["AllOwners"][x]["NewCustomerPhoneNumber"]}"),


                                        Text("Owner Father Name: ${AllSaleData[i]["AllOwners"][x]["NewCustomerFatherName"]}"),

                                        


                                        Text("Previous Owner Name: ${AllSaleData[i]["AllOwners"][x]["PreviousCustomerName"]}"),

                                        Text("Previous Owner Phone No: ${AllSaleData[i]["AllOwners"][x]["PreviousCustomerPhoneNumber"]}"),

                                        Text("Previous Owner Address: ${AllSaleData[i]["AllOwners"][x]["PreviousCustomerAddress"]}"),

                                        Text("OwnerShipChangeFee: ${AllSaleData[i]["AllOwners"][x]["FeeAmount"]}"),


                                        Text("Owner Change Date: ${AllSaleData[i]["AllOwners"][x]["PaymentDate"]}"),




                                      ],
                                    ),

                                  )



                              




                                ])));});});




                                            
                                          },
                                          value: '/hello',
                                        ),


                                        PopupMenuItem(
                                          onTap: () {

                                       showDialog(
                      context: context,
                      builder: (context) {
                       
                        bool payLoading = false;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                            actions: [
                              ElevatedButton(onPressed: () async{


                          setState((){

                            payLoading = true;

                          });


                final docUser = FirebaseFirestore.instance.collection("OwnerShipChange");



                
                      var OwnerShipChangeData ={


                        "FileNo":AllSaleData[i]["BikeDeliveryNo"],
                        "PreviousCustomerFatherName":AllSaleData[i]["CustomerFatherName"],
                        "PreviousCustomerNID":AllSaleData[i]["CustomerNID"],
                        "PreviousCustomerName":AllSaleData[i]["CustomerName"],
                        "PreviousCustomerAddress":AllSaleData[i]["CustomerAddress"],
                        "PreviousCustomerPhoneNumber":AllSaleData[i]["CustomerPhoneNumber"],
                        "NewCustomerName":NewOwnerNameController.text.trim().toString().toLowerCase(),
                        "NewCustomerPhoneNumber":NewOwnerPhoneNoController.text.trim().toString(),
                        "OldSaleID":AllSaleData[i]["SaleID"],
                        "NewCustomerAddress":NewOwnerAddressController.text.trim().toLowerCase().toString(),
                        "NewCustomerFatherName":NewOwnerFatherNameController.text.trim().toLowerCase().toString(),
                        "NewCustomerNID":NewOwnerNIDController.text.trim().toString(),
                        "FeeAmount": FeeAmountController.text.trim().toString(),
                        "PaymentDateTime": DateTime.now().toIso8601String(),
                        "PaymentDate":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                        "PaymentMonth":"${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                        "PaymentYear":"${DateTime.now().year.toString()}",
                       
                     


                              };

                  await docUser.add(OwnerShipChangeData).then((value) =>  setState(() async{


                    final docCustomerInfo = FirebaseFirestore.instance.collection("BikeSaleInfo").doc(AllSaleData[i]["SaleID"]);


                    List AllOwners = AllSaleData[i]["AllOwners"];

                    AllOwners.insert(AllOwners.length,OwnerShipChangeData);


                    var jsonUpdateData = {
                      "CustomerName":NewOwnerNameController.text.trim().toLowerCase().toString(),
                      "CustomerFatherName":NewOwnerFatherNameController.text.trim().toLowerCase().toString(),
                      "CustomerAddress":NewOwnerAddressController.text.trim().toLowerCase().toString(),

                      "CustomerPhoneNumber":NewOwnerPhoneNoController.text.trim().toString(),

                      "CustomerNID":NewOwnerNIDController.text.trim().toString(),

                      "AllOwners":AllOwners,

                       "NameChangeUpdated":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}"

                    

                    };




             await docCustomerInfo.update(jsonUpdateData).then((value) =>  setState(() async{




              payLoading = false;

              getSaleData();


                              Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  NameChangePDFView(NameChangeData: [OwnerShipChangeData])),
                                        );


              // Navigator.pop(context);









  })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: const Text('Customer Payment Add Successful!!!'),
            backgroundColor: (Colors.green),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));










                        var customerMsg = "Dear Customer, From A-ONE IMPEX আপনার বিক্রিত ১ টি গাড়ির Ownership পরিবর্তন হয়েছে। ধন্যবাদ";



                        final CustomerSmsResponse = await http
                            .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllSaleData[i]["CustomerPhoneNumber"]}&message=${customerMsg}'));

                       try {

                         if (CustomerSmsResponse.statusCode == 200) {
                          // If the server did return a 200 OK response,
                          // then parse the JSON.
                          
                          print(jsonDecode(CustomerSmsResponse.body));
                        
                        } else {
                          // If the server did not return a 200 OK response,
                          // then throw an exception.
                          throw Exception('Failed to load album');
                        }
                         
                       } catch (e) {
                         
                       }



                        
                 var NewOwnerMsg = "Dear New Owner, From A-ONE IMPEX OwnerShip is Changed Successfully. Thank you.";



                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${NewOwnerPhoneNoController.text.trim()}&message=${NewOwnerMsg}'));

                            try {
                                if (response.statusCode == 200) {
                                  // If the server did return a 200 OK response,
                                  // then parse the JSON.
                                  print(jsonDecode(response.body));
              
                                
                                } else {
                                  // If the server did not return a 200 OK response,
                                  // then throw an exception.
                                  throw Exception('Failed to load album');
                                }
                              
                            } catch (e) {
                              
                            }








   








                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DuePayPDFPreview(PaymentData:[paymentData],)));

                  // Navigator.pop(context);




  })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: const Text('Customer Payment Add Successful!!!'),
            backgroundColor: (Colors.green),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));



                              }, child: Text("Change")),



                              ElevatedButton(onPressed: (){

                                 Navigator.pop(context);


                              }, child: Text("Cancel"))



                              ],
                            title: Text('Name Chnage'),
                            content:payLoading==true?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
                              child: Column(
                                children: [


                                
                      TextField(
                      
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Owner Name:',
            
                          hintText: 'New Owner Name:',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                        controller: NewOwnerNameController,
                    
                    ),

                    SizedBox(height: 4,),



                     TextField(
                      
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Owner Father Name:',
            
                          hintText: 'New Owner Father Name:',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),

                        controller: NewOwnerFatherNameController,
                    
                    ),

                    SizedBox(height: 4,),



                     TextField(
                      
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Owner Phone No:',
            
                          hintText: 'New Owner Phone No:',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      
                      controller: NewOwnerPhoneNoController,
                    
                    ),

                    SizedBox(height: 4,),



                    TextField(
                      
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Owner Address:',
            
                          hintText: 'New Owner Address:',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),

                      controller: NewOwnerAddressController,
                    
                    ),

                    SizedBox(height: 4,),



                    TextField(
                      
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Owner NID',
            
                          hintText: 'New Owner NID',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),

                      controller: NewOwnerNIDController,
                    
                    ),

                    SizedBox(height: 4,),



                    TextField(
                      
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ownership Change Fee',
            
                          hintText: 'Ownership Change Fee',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),

                      
                      controller: FeeAmountController,
                    
                    ),

                    SizedBox(height: 4,),






                                ])));});});

      
                                          },
                                          child: Text("OwnerShipChange"),
                                          value: '/hello',
                                        ),



                                        PopupMenuItem(
                                          onTap: () {

                                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => AfterSaleBike(SalesData: [AllSaleData[i]])));
      
                                          },
                                          child: Text("Print All Invoice"),
                                          value: '/hello',
                                        ),

                                        AllSaleData[i]["BikePaymentDue"]=="0"?
                                        PopupMenuItem(
                                          onTap: () {


                                    
                               
                                  
      
                                          },
                                          child: Text("Paid"),
                                          value: '/hello',
                                        ):
                                        PopupMenuItem(
                                          onTap: () async{



                                           
                                

                           showDialog(
                      context: context,
                      builder: (context) {
                       
                        bool payLoading = false;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                            title: Text('Pay Now'),
                            content:payLoading==true?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
                              child: Column(
                                children: [

                                  Center(
                                    child: Row(children: [

                                      Image.asset('lib/images/payment-method.png', fit: BoxFit.cover, width: 50,height: 50,),

                                  SizedBox(
                                    width: 6,
                                  ),

                                      Text("Pay Now Due:${AllSaleData[i]["BikePaymentDue"]}৳")
                                  
                                    ],),
                                  ),


                                  SizedBox(
                                    height: 14,
                                  ),

                    
                    


                      

                      SizedBox(
                                    height: 14,
                                  ),

                    
                    
                    TextField(
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name: ${AllSaleData[i]["CustomerName"]}',
            
                          hintText: 'Name: ${AllSaleData[i]["CustomerName"]}',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                    
                    ),



                     SizedBox(
                                    height: 14,
                                  ),

                    
                    
                    TextField(
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone No: ${AllSaleData[i]["CustomerPhoneNumber"]}',
            
                          hintText: 'Phone No: ${AllSaleData[i]["CustomerPhoneNumber"]}',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                    
                    ),



                    SizedBox(
                                    height: 14,
                                  ),

                    
                    
                    TextField(
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Total Due: ${AllSaleData[i]["BikePaymentDue"]}৳',
            
                          hintText: 'Total Due: ${AllSaleData[i]["BikePaymentDue"]} ৳',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                    
                    ),



                    
                     SizedBox(
                                    height: 14,
                                  ),


                    
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Payment',
            
                          hintText: 'Payment',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: DueAmountController,
                    ),



                      SizedBox(
                            height: 14,
                            ),





                                ],
                              ),

                            ),
                            actions: [
                              ElevatedButton(
                                
                                onPressed: () {

                                  Navigator.pop(context);
                                },
                                child: Text('CANCEL'),
                              ),
                              ElevatedButton(
                                
                                onPressed: () async{

                                  setState((){

                                    payLoading = true;

                                  });

                            final docUser = FirebaseFirestore.instance.collection("BikeSaleInfo").doc(AllSaleData[i]["SaleID"]);

                              final UpadateData ={
                                
                                "BikePaymentDue":(double.parse(AllSaleData[i]["BikePaymentDue"].toString())-double.parse(DueAmountController.text.trim().toString())).toString(),
                                "TotalCashIn":(double.parse(AllSaleData[i]["TotalCashIn"].toString()) + double.parse(DueAmountController.text.trim().toString())).toString(),

                                "CustomerType":(double.parse(AllSaleData[i]["BikePaymentDue"].toString())-double.parse(DueAmountController.text.trim().toString()))<=0?"Paid":"Due",
                                "LastUpdated":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}"
                         
                                
                                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) =>    
                   setState(() async{



                    final docCustomerInfo = FirebaseFirestore.instance.collection("customer").doc(widget.CustomerID);


                    final UpadateCustomerData ={

                          

                                "CustomerType":(double.parse(AllData[0]["BikePaymentDue"].toString())-double.parse(DueAmountController.text.trim().toString()))<=0?"Paid":"Due",
                         
                                
                                };


                  


                   await docCustomerInfo.update(UpadateCustomerData).then((value) =>  setState(() async{






                    

                    // Navigator.pop(context);

                    var adminEmail ="";
                    var adminName = "";

                    FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) {
                            if (user != null) {


                              setState(() {
                                adminEmail = user.email!;
                                adminName = user.displayName!;
                              });
                              



                            }
                          });





            final docUser = FirebaseFirestore.instance.collection("DuePaymentAddInfo");




                      final jsonData ={
                        "CustomerName":AllSaleData[i]["CustomerName"],
                        "FileNo":AllSaleData[i]["BikeDeliveryNo"],
                        "CustomerNID":AllSaleData[i]["CustomerNID"],
                        "CustomerID":widget.CustomerID,
                        "CustomerPhoneNumber":AllSaleData[i]["CustomerPhoneNumber"],
                        "Amount": DueAmountController.text.trim().toString(),
                        "PaymentDateTime": DateTime.now().toIso8601String(),
                        "PaymentDate":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                        "PaymentMonth":"${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                        "PaymentYear":"${DateTime.now().year.toString()}",
                        "adminEmail":adminEmail,
                        "adminName":adminName,
                        "BikePaymentDue":(double.parse(AllSaleData[i]["BikePaymentDue"].toString())-double.parse(DueAmountController.text.trim().toString())).toString(),

                        
                      };


                    await docUser.add(jsonData).then((value) =>  setState(() async{




                              var paymentData ={


                        "FileNo":AllSaleData[i]["BikeDeliveryNo"],
                        "CustomerNID":AllSaleData[i]["CustomerNID"],
                        "CustomerName":AllSaleData[i]["CustomerName"],
                        "CustomerID":widget.CustomerID,
                        "CustomerPhoneNumber":AllSaleData[i]["CustomerPhoneNumber"],
                        "Amount": DueAmountController.text.trim().toString(),
                        "PaymentDateTime": DateTime.now().toIso8601String(),
                        "PaymentDate":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                        "PaymentMonth":"${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                        "PaymentYear":"${DateTime.now().year.toString()}",
                        "adminEmail":adminEmail,
                        "adminName":adminName,
                        "BikePaymentDue":(double.parse(AllSaleData[i]["BikePaymentDue"].toString())-double.parse(DueAmountController.text.trim().toString())).toString(),


                              };






                        var customerMsg = "Dear Customer From A One Impex Showroom ${AllSaleData[i]["CustomerNID"]} Account No এ ${DueAmountController.text.trim()}৳ কিস্তি পরিশোধ করেছেন। ধন্যবাদ";



                        final CustomerSmsResponse = await http
                            .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllSaleData[i]["CustomerPhoneNumber"]}&message=${customerMsg}'));

                       try {

                         if (CustomerSmsResponse.statusCode == 200) {
                          // If the server did return a 200 OK response,
                          // then parse the JSON.
                          
                          print(jsonDecode(CustomerSmsResponse.body));
                        
                        } else {
                          // If the server did not return a 200 OK response,
                          // then throw an exception.
                          throw Exception('Failed to load album');
                        }
                         
                       } catch (e) {
                         
                       }



                        
                 var AdminMsg = "A One Impex Showroom NID:${AllSaleData[i]["CustomerNID"]} ${DueAmountController.text.trim().toString()}৳ কিস্তি পরিশোধ করেছেন।${adminEmail} Admin টাকা জমা নিয়েছেন।";



                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=01721915550&message=${AdminMsg}'));

                            try {
                                if (response.statusCode == 200) {
                                  // If the server did return a 200 OK response,
                                  // then parse the JSON.
                                  print(jsonDecode(response.body));
              
                                
                                } else {
                                  // If the server did not return a 200 OK response,
                                  // then throw an exception.
                                  throw Exception('Failed to load album');
                                }
                              
                            } catch (e) {
                              
                            }



                  setState((){
                    payLoading = false;
                  });


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DuePayPDFPreview(PaymentData:[paymentData],)));

                  // Navigator.pop(context);




  })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: const Text('Customer Payment Add Successful!!!'),
            backgroundColor: (Colors.green),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));







  })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: const Text('Customer Payment Add Successful!!!'),
            backgroundColor: (Colors.green),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));







                   })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                              content: const Text('Something Wrong'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));



                                },
                                child: Text('Save'),
                              ),
                            ],
                          );});});



                          // Alert End 


                                    
                               
                                      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AfterSaleBike(SalesData: [AllSaleData[i]])));
      
                                          },
                                          child: Text("Payment Add"),
                                          value: '/hello',
                                        ),
                                        PopupMenuItem(
                                          onTap: ()async {

                                      // try {

                                      //         CollectionReference _collectionRef =
                                      //           FirebaseFirestore.instance.collection('BikeSaleInfo');
                                      //               _collectionRef.doc(AllSaleData[i]["SaleID"]).delete().then(
                                      //       (doc) => setState((){


                                      //     AwesomeDialog(
                                      //       showCloseIcon: true,

                                      //       btnOkOnPress: () {
                                      //         Navigator.pop(context);
                                      //       },
                                        
                                      //       context: context,
                                      //       dialogType: DialogType.success,
                                      //       animType: AnimType.rightSlide,
                                      //       body: SingleChildScrollView(
                                      //         child: Text("Delete Successfull"))).show();




                                      //       }),
                                      //       onError: (e) => print("Error updating document $e"),
                                      //     );
                                        
                                      // } catch (e) {


                                      //   AwesomeDialog(
                                      //       showCloseIcon: true,

                                      //       btnOkOnPress: () {
                                      //         Navigator.pop(context);
                                      //       },
                                        
                                      //       context: context,
                                      //       dialogType: DialogType.success,
                                      //       animType: AnimType.rightSlide,
                                      //       body: SingleChildScrollView(
                                      //         child: Text("${e}"))).show();
                                        
                                      // }
                                            
                                          },
                                          child: Text("Delete"),
                                          value: '/about',
                                        ),
                                     
                                      ];
                                    },
                                  ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("NID:${AllSaleData[i]["CustomerNID"]}"),
                                  Text("Name:${AllSaleData[i]["CustomerName"]}"),
                                  Text("Phone Number:${AllSaleData[i]["CustomerPhoneNumber"]}"),
                  
                                  Text("Date: ${AllSaleData[i]["BikeSaleDate"]}"),

                                   Text("Eng No: ${AllSaleData[i]["BikeEngineNo"]}"),
                                   Text("Chassis No: ${AllSaleData[i]["BikeChassisNo"]}"),

                                   Text("DeliveryNo: ${AllSaleData[i]["BikeDeliveryNo"]}"),

                                   Text("Sale Price: ${AllSaleData[i]["BikeSalePrice"]}", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),),

                                   Text("Buying Price: ${AllSaleData[i]["BikeBuyingPrice"]}", style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),),


                                   Text("Profit: ${(double.parse(AllSaleData[i]["BikeSalePrice"].toString())-double.parse(AllSaleData[i]["BikeBuyingPrice"].toString()))}", style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),),



                                  //  BikeConditionMonth
// BikeDeliveryNo
                                   Text("Condition: ${AllSaleData[i]["BikeConditionMonth"]} month"),

                                   Text("Color: ${AllSaleData[i]["BikeColor"]}"),


                                   Text("Cash In: ${AllSaleData[i]["BikeBillPay"]} "),

                                   Text("Total CashIn: ${AllSaleData[i]["TotalCashIn"].toString()}",style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),),
                                ],
                              ),
                        
                        
                        
                            ),
                  ),
                ),




      
      
      
      
      
      
      
      
                      SizedBox(height: 15,),
      
      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
      
                          Container(width: 150, child:TextButton(onPressed: (){
      
      
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleCustomerFile( CustomerID: widget.CustomerID,)));
      
      
                           
      
      
      
      
      
                          }, child: Text("All Files", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
                  backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                ),),),
                        ],
                      )
      
      
      
      
                     
      
      
      
              
              
              
              
              
                    ],
                  ),
                ),
              ),
      ),
        
        floatingActionButton: FloatingActionButton(
      onPressed: (){




          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditCustomerInfo(CustomerNID: AllData[0]["CustomerNID"] , CustomerAddress:  AllData[0]["CustomerAddress"], CustomerName: AllData[0]["CustomerName"] , CustomerPhoneNumber: AllData[0]["CustomerPhoneNumber"]  , CustomerEmail: AllData[0]["CustomerEmail"] , CustomerFatherName: AllData[0]["CustomerFatherName"] , CustomerMotherName:  AllData[0]["CustomerMotherName"], CustomerGuarantor1Name:  AllData[0]["CustomerGuarantor1Name"], CustomerGuarantor1PhoneNumber:  AllData[0]["CustomerGuarantor1PhoneNumber"], CustomerGuarantor1Address:  AllData[0]["CustomerGuarantor1Address"], CustomerGuarantor2Name:  AllData[0]["CustomerGuarantor2Name"], CustomerGuarantor2PhoneNumber:  AllData[0]["CustomerGuarantor2PhoneNumber"], CustomerGuarantor2NID:  AllData[0]["CustomerGuarantor2NID"], CustomerGuarantor2Address: AllData[0]["CustomerGuarantor2Address"] , CustomerGuarantor1NID: AllData[0]["CustomerGuarantor1NID"], CustomerID: AllData[0]["CustomerID"], CustomerImageUrl: AllData[0]["CustomerImageUrl"],)),
                      );











      },
        tooltip: 'Edit',
        child: const Icon(Icons.edit),
      ), 
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
