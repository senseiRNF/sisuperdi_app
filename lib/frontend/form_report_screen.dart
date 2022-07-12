import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisuperdi_app/backend/class_data/auth_class.dart';
import 'package:sisuperdi_app/backend/class_data/report_class.dart';
import 'package:sisuperdi_app/backend/functions/dialog_functions.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/services/report_services.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';

class FormReportScreen extends StatefulWidget {
  final int npptId;

  const FormReportScreen({
    Key? key,
    required this.npptId,
  }) : super(key: key);

  @override
  State<FormReportScreen> createState() => _FormReportScreenState();
}

class _FormReportScreenState extends State<FormReportScreen> {
  AuthClass? authClass;

  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController workUnitController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  DateTime reportDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    setState(() {
      dateController.text = DateFormat('yyyy-MM-dd').format(reportDate);
    });

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((auth) {
      setState(() {
        authClass = auth;

        if(authClass != null) {
          nameController.text = authClass!.name ?? 'Nama Tak Diketahui';
          positionController.text = authClass!.position ?? 'Posisi Tak Diketahui';
          workUnitController.text = authClass!.workUnit ?? 'Unit Kerja Tak Diketahui';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.primary,
        title: const Text(
          'Input Laporan',
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0,),
            child: Text(
              '* Buat Laporan Perjalanan Dinas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: TextField(
              controller: nameController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Nama Pegawai',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: TextField(
              controller: positionController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Posisi',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: TextField(
              controller: workUnitController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Unit Kerja',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: TextField(
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: reportDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2032),
                ).then((selectedDate) {
                  if(selectedDate != null) {
                    setState(() {
                      reportDate = selectedDate;
                      dateController.text = DateFormat('dd/MM/yyyy').format(reportDate);
                    });
                  }
                });
              },
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Tanggal',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: TextField(
              controller: resultController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Hasil',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: ElevatedButton(
              onPressed: () {
                DialogFunctions(context: context, message: 'Simpan laporan, Anda yakin?').optionDialog(() async {
                  await ReportServices().writeReport(
                    ReportClass(
                      sptId: widget.npptId,
                      employeeId: authClass!.userId,
                      result: resultController.text,
                      day: DateFormat('EEEE').format(reportDate),
                      date: reportDate,
                    ),
                  ).then((writeResult) {
                    if(writeResult) {
                      DialogFunctions(context: context, message: 'Sukses membuat laporan').okDialog(() {
                        RouteFunctions(context: context).backOffScreen(null);
                      });
                    }
                  });
                }, () {

                });
              },
              style: ElevatedButton.styleFrom(
                primary: GlobalColor.btnColor,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0,),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0,),
            child: ElevatedButton(
              onPressed: () {
                RouteFunctions(context: context).backOffScreen(null);
              },
              style: ElevatedButton.styleFrom(
                primary: GlobalColor.primary,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0,),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
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