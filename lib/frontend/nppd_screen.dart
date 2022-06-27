import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';

class NPPDScreen extends StatefulWidget {
  const NPPDScreen({Key? key}) : super(key: key);

  @override
  State<NPPDScreen> createState() => _NPPDScreenState();
}

class _NPPDScreenState extends State<NPPDScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController dateDepartureController = TextEditingController();
  TextEditingController dateArrivalController = TextEditingController();
  TextEditingController intendController = TextEditingController();

  DateTime dateDeparture = DateTime.now();
  DateTime dateArrival = DateTime.now();

  @override
  void initState() {
    super.initState();

    setState(() {
      dateDepartureController.text = DateFormat('dd/MM/yyyy').format(dateDeparture);
      dateArrivalController.text = DateFormat('dd/MM/yyyy').format(dateArrival);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.primary,
        title: const Text(
          'NPPD',
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
                  'Data NPPD (Nota Permintaan Perjalanan Dinas)',
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
              '* Tambah Data NPPD',
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
              controller: destinationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Tujuan',
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
                  initialDate: dateDeparture,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2032),
                ).then((selectedDate) {
                  if(selectedDate != null) {
                    setState(() {
                      dateDeparture = selectedDate;
                      dateDepartureController.text = DateFormat('dd/MM/yyyy').format(dateDeparture);
                    });
                  }
                });
              },
              controller: dateDepartureController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Tanggal Berangkat',
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
                  initialDate: dateArrival,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2032),
                ).then((selectedDate) {
                  if(selectedDate != null) {
                    setState(() {
                      dateArrival = selectedDate;
                      dateArrivalController.text = DateFormat('dd/MM/yyyy').format(dateArrival);
                    });
                  }
                });
              },
              controller: dateArrivalController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Tanggal Kembali',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0,),
            child: TextField(
              controller: intendController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Maksud Perjalanan Dinas',
                ),
              ),
            ),
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