import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';







class AccessoriesInvoice extends StatefulWidget {



  final CustomerPhoneNumber;
  final AccessoriesName;
  final AccessoriesSalePrice;
  final AccessoriesID;
  final SaleDate;
  final CustomerID;
  








 
  const AccessoriesInvoice({Key? key,   required this.CustomerPhoneNumber, required this.AccessoriesID, required this.AccessoriesName, required this.AccessoriesSalePrice, required this.CustomerID, required this.SaleDate }) : super(key: key);

  @override
  State<AccessoriesInvoice> createState() => _AccessoriesInvoiceState();
}

class _AccessoriesInvoiceState extends State<AccessoriesInvoice> {
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
        build: (context) => makePdf(widget.CustomerID, widget.CustomerPhoneNumber, widget.AccessoriesName, widget.AccessoriesSalePrice, widget.AccessoriesID, widget.SaleDate)
      ),
    );
  }
}














Future<Uint8List> makePdf( CustomerID, CustomerPhoneNumber, AccessoriesName, AccessoriesSalePrice,AccessoriesID,SaleDate) async {


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
                
                
                
                child: pw.Padding(padding: pw.EdgeInsets.all(13), child: pw.Text("MONEY RECEIPT", style: pw.TextStyle(fontSize: 19, color: PdfColors.white))))),


               pw.SizedBox(
                      height: 10,
                      
                
              ),







              
              
             pw.SizedBox(
                      height: 10,
                      
                
              ),





            

                pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.blue200),
                      children: [


                      pw.TableRow(
                        decoration: pw.BoxDecoration(color: PdfColors.grey100),
                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Customer Phone No',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${CustomerPhoneNumber}',
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
                                'Accessories Name',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${AccessoriesName}',
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
                                'Accessories Sale Price',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${AccessoriesSalePrice} tk',
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
                                'Date',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${SaleDate}',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),


          ]),




              pw.SizedBox(
                      height: 100,
                      
                
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