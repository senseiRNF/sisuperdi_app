import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/receipt_response.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/services/receipt_services.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  List<ReceiptResponseData> listReceipt = [];
  
  @override
  void initState() {
    super.initState();
    
    initLoad();
  }
  
  void initLoad() async {
    await SPrefs().readAuth().then((auth) async {
      if(auth != null) {
        await ReceiptServices().readReceiptByUser(auth.userId!).then((dioResult) {
          List<ReceiptResponseData> listTemp = [];
          
          if(dioResult != null && dioResult.data != null) {
            for(int i = 0; i < dioResult.data!.length; i++) {
              listTemp.add(dioResult.data![i]);
            }
            
            setState(() {
              listReceipt = listTemp;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.primary,
        title: const Text(
          'Data Kwitansi',
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
          listReceipt.isNotEmpty ?
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listReceipt.length,
            itemBuilder: (BuildContext listContext, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listReceipt[index].nama ?? 'Nama Tak Diketahui',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Dari: ${listReceipt[index].dari} -> ${listReceipt[index].untuk}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Lumpsum: Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(listReceipt[index].lumpsum ?? '0'))}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "Penginapan: Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(listReceipt[index].penginapan ?? '0'))}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "Transportasi: Rp.${NumberFormat('#,###', 'en_ID').format(int.parse(listReceipt[index].transportasi ?? '0'))}",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ) :
          const Padding(
            padding: EdgeInsets.only(top: 20.0,),
            child: Text(
              'Data Tidak Ditemukan',
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
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