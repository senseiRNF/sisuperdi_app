import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';

class FormReportScreen extends StatefulWidget {
  const FormReportScreen({Key? key}) : super(key: key);

  @override
  State<FormReportScreen> createState() => _FormReportScreenState();
}

class _FormReportScreenState extends State<FormReportScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController workUnitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  XFile? fileProof;

  @override
  void initState() {
    super.initState();
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
                      fontWeight: FontWeight.bold
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
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Keterangan',
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: 1,
            itemBuilder: (BuildContext listContext, int index) {
              return index == 0 ?
              Card(
                elevation: 5.0,
                child: InkWell(
                  onTap: () {

                  },
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0,),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0,),
                    child: Icon(
                      Icons.camera_alt,
                    ),
                  ),
                ),
              ) :
              Card(
                elevation: 5.0,
                child: InkWell(
                  onTap: () {

                  },
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0,),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0,),
                    child: Icon(
                      Icons.image,
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: ElevatedButton(
              onPressed: () {

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