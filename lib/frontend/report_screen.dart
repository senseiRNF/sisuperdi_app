import 'package:flutter/material.dart';
import 'package:sisuperdi_app/backend/class_data/auth_class.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/report_response.dart';
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