import 'package:flutter/material.dart';
import 'package:sisuperdi_app/backend/class_data/auth_class.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/nppd_response.dart';
import 'package:sisuperdi_app/backend/functions/dialog_functions.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/services/nppd_services.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';
import 'package:sisuperdi_app/frontend/form_report_screen.dart';

class SPTScreen extends StatefulWidget {
  const SPTScreen({Key? key}) : super(key: key);

  @override
  State<SPTScreen> createState() => _SPTScreenState();
}

class _SPTScreenState extends State<SPTScreen> {
  List<NPPDResponseData> listNPPD = [];

  AuthClass? authClass;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((auth) {
      setState(() {
        authClass = auth;
      });
    });

    if(authClass != null) {
      if(authClass!.role == 'pegawai') {
        await NPPDServices().readNPPDByUser(authClass!.userId!).then((readResult) {
          List<NPPDResponseData> listTemp = [];

          if(readResult != null) {
            for(int i = 0; i < readResult.data!.length; i++) {
              listTemp.add(readResult.data![i]);
            }
          }

          setState(() {
            listNPPD = listTemp;
          });
        });
      } else {
        await NPPDServices().readAllNPPD().then((readResult) {
          List<NPPDResponseData> listTemp = [];

          if(readResult != null) {
            for(int i = 0; i < readResult.data!.length; i++) {
              listTemp.add(readResult.data![i]);
            }
          }

          setState(() {
            listNPPD = listTemp;
          });
        });
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.primary,
        title: const Text(
          'Data SPT',
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
                  Icons.saved_search,
                  size: 30.0,
                ),
              ),
              Expanded(
                child: Text(
                  'SPT',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          listNPPD.isNotEmpty ?
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listNPPD.length,
            itemBuilder: (BuildContext listContext, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              listNPPD[index].nama ?? 'Nama Tak Diketahui',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              listNPPD[index].maksud ?? 'Tujuan Tak Diketahui',
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Tgl Mulai: ${listNPPD[index].tglPergi ?? 'Tanggal Tak Diketahui'}",
                            ),
                            Text(
                              "Tgl Kembali: ${listNPPD[index].tglKembali ?? 'Tanggal Tak Diketahui'}",
                            ),
                          ],
                        ),
                      ),
                      authClass != null && authClass!.role != 'pegawai' ?
                      listNPPD[index].status == 'N' ?
                      ElevatedButton(
                        onPressed: () {
                          DialogFunctions(context: context, message: 'Konfirmasi Data NPPD, Anda yakin?').optionDialog(() async {
                            await NPPDServices().updateNPPDStatus(int.parse(listNPPD[index].idNppt!), 'Y').then((confirmResult) {
                              if(confirmResult) {
                                DialogFunctions(context: context, message: 'Sukses mengkonfirmasi Surat').okDialog(() {
                                  initLoad();
                                });
                              }
                            });
                          }, () {

                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0,),
                          child: Text(
                            'Konfirmasi',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ) :
                      const Padding(
                        padding: EdgeInsets.all(5.0,),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ) :
                      listNPPD[index].status == 'N' ?
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0,),
                          child: Text(
                            'Laporan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ) :
                      ElevatedButton(
                        onPressed: () {
                          RouteFunctions(context: context).moveScreen(FormReportScreen(npptId: int.parse(listNPPD[index].idNppt!),), (callback) {

                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: GlobalColor.btnColor,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0,),
                          child: Text(
                            'Laporan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
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