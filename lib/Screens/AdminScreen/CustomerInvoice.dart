import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';







class PdfPreviewPage extends StatefulWidget {


  final CustomerName;
  final CustomerNID;
  final CustomerFileNo;
  final CustomerPhoneNumber;
  final CustomerAddress;
  final BikeName;
  final BikeEngineNo;
  final BikeChassisNo;
  final BikeColor;
  final BikeSalePrice;
  final BikePaymentDue;
  final BikeCashInAmount;
  final BikeCondition;








 
  const PdfPreviewPage({Key? key, required this.CustomerName, required this.CustomerNID, required this.CustomerPhoneNumber, required this.CustomerFileNo, required this.CustomerAddress, required this.BikeName, required this.BikeEngineNo, required this.BikeChassisNo, required this.BikeSalePrice, required this.BikeCashInAmount, required this.BikePaymentDue, required this.BikeColor, required this.BikeCondition}) : super(key: key);

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Invoice", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: PdfPreview(
        build: (context) => makePdf(widget.CustomerName, widget.CustomerNID, widget.CustomerPhoneNumber, widget.CustomerFileNo, widget.CustomerAddress, widget.BikeName, widget.BikeEngineNo, widget.BikeChassisNo, widget.BikeSalePrice, widget.BikeCashInAmount, widget.BikePaymentDue, widget.BikeColor, widget.BikeCondition),
      ),
    );
  }
}














Future<Uint8List> makePdf(CustomerName, CustomerNID, CustomerPhoneNumber, CustomerFileNo, CustomerAddress, BikeName, BikeEngineNo, BikeChassisNo, BikeSalePrice, BikeCashInAmount, BikePaymentDue, BikeColor, BikeCondition) async {

final netImage = await networkImage('https://i.ibb.co/NWJfGks/Adobe-Scan-12-Oct-2023-2-1.jpg');


final pdf = pw.Document();


pdf.addPage(pw.Page(
  theme: pw.ThemeData.withFont(base: pw.Font.ttf(await rootBundle.load("lib/fonts/JosefinSans-BoldItalic.ttf")),),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(children: [


             pw.SizedBox(
                      height: 120,
                      
                
              ),



              pw.Center(child: pw.Container(

                 decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.only(
                            topRight: pw.Radius.circular(10.0),
                            topLeft: pw.Radius.circular(10.0),
                            bottomLeft: pw.Radius.circular(10.0),
                            bottomRight: pw.Radius.circular(10.0)),
                        color: PdfColors.blue600,
                      ),
                
                
                
                child: pw.Padding(padding: pw.EdgeInsets.all(13), child: pw.Text("DELIVERY CHALAN", style: pw.TextStyle(fontSize: 19, color: PdfColors.white))))),


               pw.SizedBox(
                      height: 10,
                      
                
              ),






                  pw.Row(
                    
                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [



                          pw.Column(
                              children: [


                



                                pw.Text("Delivery To: ${CustomerName}", style: const pw.TextStyle(fontSize: 18, )),
                                    pw.SizedBox(
                                            height: 5,
                                           
                                    ),
                                pw.Text("NID: ${CustomerNID}", style: const pw.TextStyle(fontSize: 12)),

                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),
                                pw.Text("File No: ${CustomerFileNo}", style: const pw.TextStyle(fontSize: 12)),

                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),
                                pw.Text("Phone No: ${CustomerPhoneNumber}", style: const pw.TextStyle(fontSize: 12)),
                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),
                                
                                pw.Text("Address: ${CustomerAddress}", style: const pw.TextStyle(fontSize: 12)),
                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),


                                 
                                
                              ],
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                            ),









                             pw.Column(
                              children: [
                             


                                  pw.Text("Model: ${BikeName}", style: const pw.TextStyle(fontSize: 12)),
                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),

                                  pw.Text("Made In India", style: const pw.TextStyle(fontSize: 12)),
                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),

                                  pw.Text("ENGINE NO: ${BikeEngineNo}", style: const pw.TextStyle(fontSize: 13)),
                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),

                                  pw.Text("CHASSIS NO: ${BikeChassisNo}", style: const pw.TextStyle(fontSize: 13)),
                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),
                                  
                                  pw.Text("Color: ${BikeColor}", style: const pw.TextStyle(fontSize: 12)),
                                  pw.SizedBox(
                                            height: 5,
                                           
                                    ),

                               
                                // pw.Text("Delivery Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}", style: const pw.TextStyle(fontSize: 13)),
                                
                              ],
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                            ),


                    
                        
                        
                        
                        ]
                  
                  
                  ),


              
              
             pw.SizedBox(
                      height: 10,
                      
                
              ),





            

                pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.blue200),
                      children: [


                      // The first row just contains a phrase 'INVOICE FOR PAYMENT'
                        // pw.TableRow(
                        // decoration: pw.BoxDecoration(color: PdfColors.blue100),
                          
                        //   children: [
                        //     pw.Padding(
                        //       child: pw.Text(
                        //         'MONEY RECEIPT',
                        //         style: pw.Theme.of(context).header4,
                        //         textAlign: pw.TextAlign.center,
                        //       ),
                        //       padding: pw.EdgeInsets.all(7),
                        //     ),
                        //   ],
                        // ),


                      pw.TableRow(
                        decoration: pw.BoxDecoration(color: PdfColors.blue100),
                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Bike Price',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${BikeSalePrice} tk',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),

                          ],
                        ),



                      pw.TableRow(
                        decoration: pw.BoxDecoration(color: PdfColors.grey100),
                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Cash In Amount',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${BikeCashInAmount} tk',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),



                        pw.TableRow(
                          decoration: pw.BoxDecoration(color: PdfColors.blue100),
                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Due Amount',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${BikePaymentDue} tk',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),



                      


                         pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Condition',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${BikeCondition} month',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),



                               pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.blue100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Delivery Date',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),













          ]),




                 pw.SizedBox(
                      height: 10,
                      
                
              ),




           pw.Image(netImage, height: 330, width: 510),



            pw.SizedBox(
                      height: 70,
                      
                
              ),



            pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              
              
              
              children: [

                  pw.Column(children: [

                    pw.Text("___________________________"),

                    pw.Text("Customer Signature"),


                  ]),



                        pw.Column(children: [

                    pw.Text("For and on behalf of",style: pw.TextStyle(fontSize: 12, color: PdfColors.black)),

                    pw.Text("A-ONE IMPEX",style: pw.TextStyle(fontSize: 19, color: PdfColors.blue700, )),


                  ])



              ]),







        ])); // Center
      }));



return pdf.save();
}