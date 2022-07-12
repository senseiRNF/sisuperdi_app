import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:sisuperdi_app/backend/class_data/auth_class.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/report_response.dart';
import 'package:sisuperdi_app/backend/functions/dialog_functions.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/services/report_services.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  AuthClass? authClass;

  List<ReportResponseData> listReport = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((auth) async {
      setState(() {
        authClass = auth;
      });

      await ReportServices().readReportByUser(authClass!.userId!).then((readResult) {
        List<ReportResponseData> listTemp = [];

        if(readResult != null && readResult.data != null) {
          for(int i = 0; i < readResult.data!.length; i++) {
            listTemp.add(readResult.data![i]);
          }
        }

        setState(() {
          listReport = listTemp;
        });
      });
    });
  }

  void generatePDF(ReportResponseData dataResponse) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                "Laporan Perjalan Dinas",
                style: pw.TextStyle(
                  fontSize: 20.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Divider(),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Text(
                "Tanggal: ${dataResponse.tanggal!}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                "Nama: ${dataResponse.nama!}",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.SizedBox(
                height: 20.0,
              ),
              pw.Text(
                "Hasil",
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                dataResponse.hasil!,
                style: const pw.TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: pw.TextAlign.left,
              ),
            ],
          );
        },
      ),
    );

    var status = await Permission.storage.status;

    if(status.isGranted) {
      final directory = Directory('/storage/emulated/0/Download');

      final file = File("${directory.path}/example.pdf");

      await file.writeAsBytes(await pdf.save()).then((result) {
        DialogFunctions(context: context, message: 'Sertifikat berhasil di unduh').okDialog(() {

        });
      });
    } else {
      await Permission.storage.request().then((permissionResult) async {
        if(permissionResult.isGranted) {
          final directory = (await getApplicationDocumentsDirectory()).path;

          final file = File("$directory/example.pdf");
          await file.writeAsBytes(await pdf.save()).then((result) {
            DialogFunctions(context: context, message: 'Sertifikat berhasil di unduh').okDialog(() {

            });
          });
        } else {
          DialogFunctions(context: context, message: 'Tidak dapat melanjutkan, diperlukan izin untuk mengakses penyimpanan').okDialog(() {

          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.primary,
        title: const Text(
          'Data Laporan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () {
            RouteFunctions(context: context).backOffScreen(null);
          },
          customBorder: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(10.0,),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(10.0,),
                child: Icon(
                  Icons.attach_email_outlined,
                  size: 30.0,
                ),
              ),
              Expanded(
                child: Text(
                  'Input Laporan',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          listReport.isNotEmpty ?
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listReport.length,
            itemBuilder: (BuildContext listContext, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0,),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listReport[index].nama ?? 'Nama Tak Diketahui',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              listReport[index].tanggal ?? 'Tanggal Tak Diketahui',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              listReport[index].hasil ?? 'Hasil Tak Diketahui',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          DialogFunctions(context: context, message: 'Mengunduh laporan menjadi PDF, Anda yakin?').optionDialog(() {
                            generatePDF(listReport[index]);
                          }, () {

                          });
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0,),
                          child: Icon(
                            Icons.print,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ) :
          const Text(
            'Data Tidak Ditemukan',
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}