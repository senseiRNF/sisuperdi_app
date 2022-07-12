import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisuperdi_app/backend/class_data/nppd_class.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/destination_response.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/employee_response.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/transportation_response.dart';
import 'package:sisuperdi_app/backend/functions/dialog_functions.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/services/destination_services.dart';
import 'package:sisuperdi_app/backend/services/employee_services.dart';
import 'package:sisuperdi_app/backend/services/nppd_services.dart';
import 'package:sisuperdi_app/backend/services/transportation_services.dart';
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
  TextEditingController transportationController = TextEditingController();
  TextEditingController intendController = TextEditingController();

  DateTime dateDeparture = DateTime.now();
  DateTime dateArrival = DateTime.now();

  List<DestinationResponseData> listDestination = [];
  List<TransportationResponseData> listTransportation = [];
  List<EmployeeResponseData> listEmployee = [];

  int? userId;
  int? destinationId;
  int? transportationId;

  @override
  void initState() {
    super.initState();

    setState(() {
      dateDepartureController.text = DateFormat('dd/MM/yyyy').format(dateDeparture);
      dateArrivalController.text = DateFormat('dd/MM/yyyy').format(dateArrival);
    });

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((auth) async {
      if(auth != null) {
        if(auth.role == 'pegawai') {
          setState(() {
            userId = auth.userId;
            nameController.text = auth.name ?? '';
          });

          await DestinationServices().readAllDestination().then((resultDestination) async {
            await TransportationServices().readAllTransportation().then((resultTransportation) {
              List<DestinationResponseData> listDestinationTemp = [];
              List<TransportationResponseData> listTransportationTemp = [];

              if(resultDestination != null && resultDestination.data != null) {
                for(int i = 0; i < resultDestination.data!.length; i++) {
                  listDestinationTemp.add(resultDestination.data![i]);
                }
              }

              if(resultTransportation != null && resultTransportation.data != null) {
                for(int i = 0; i < resultTransportation.data!.length; i++) {
                  listTransportationTemp.add(resultTransportation.data![i]);
                }
              }

              setState(() {
                listDestination = listDestinationTemp;
                listTransportation = listTransportationTemp;
              });
            });
          });
        } else {
          await DestinationServices().readAllDestination().then((resultDestination) async {
            await TransportationServices().readAllTransportation().then((resultTransportation) async {
              await EmployeeServices().readAllEmployee().then((resultEmployee) {
                List<DestinationResponseData> listDestinationTemp = [];
                List<TransportationResponseData> listTransportationTemp = [];
                List<EmployeeResponseData> listEmployeeTemp = [];

                if(resultDestination != null && resultDestination.data != null) {
                  for(int i = 0; i < resultDestination.data!.length; i++) {
                    listDestinationTemp.add(resultDestination.data![i]);
                  }
                }

                if(resultTransportation != null && resultTransportation.data != null) {
                  for(int i = 0; i < resultTransportation.data!.length; i++) {
                    listTransportationTemp.add(resultTransportation.data![i]);
                  }
                }

                if(resultEmployee != null && resultEmployee.data != null) {
                  for(int i = 0; i < resultEmployee.data!.length; i++) {
                    listEmployeeTemp.add(resultEmployee.data![i]);
                  }
                }

                setState(() {
                  listDestination = listDestinationTemp;
                  listTransportation = listTransportationTemp;
                  listEmployee = listEmployeeTemp;
                });
              });
            });
          });
        }
      }
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
              onTap: () {
                DialogFunctions(context: context, message: 'Pilih Pegawai').listEmployeeDialog(listEmployee, (selection) {
                  EmployeeResponseData response = selection;

                  setState(() {
                    userId = int.parse(response.idPegawai!);
                    nameController.text = response.nama ?? 'Nama Tak Diketahui';
                  });
                });
              },
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
              onTap: () {
                DialogFunctions(context: context, message: 'Pilih Tujuan').listDestinationDialog(listDestination, (selection) {
                  DestinationResponseData response = selection;

                  setState(() {
                    destinationId = int.parse(response.idTujuan!);
                    destinationController.text = response.tujuan ?? 'Tujuan Tak Diketahui';
                  });
                });
              },
              controller: destinationController,
              readOnly: true,
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
              onTap: () {
                DialogFunctions(context: context, message: 'Pilih Transportasi').listTransportationDialog(listTransportation, (selection) {
                  TransportationResponseData response = selection;

                  setState(() {
                    transportationId = int.parse(response.idTransportasi!);
                    transportationController.text = response.transportasi ?? 'Tujuan Tak Diketahui';
                  });
                });
              },
              controller: transportationController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0,),
                ),
                label: const Text(
                  'Transportasi',
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
                int daysBetween(DateTime from, DateTime to) {
                  from = DateTime(from.year, from.month, from.day);
                  to = DateTime(to.year, to.month, to.day);
                  return (to.difference(from).inHours / 24).round();
                }

                DialogFunctions(context: context, message: 'Simpan data, Anda yakin?').optionDialog(() async {
                  await NPPDServices().writeNPPD(
                    NPPDClass(
                      userId: userId,
                      destinationId: destinationId,
                      departureDate: dateDeparture,
                      arrivalDate: dateArrival,
                      duration: daysBetween(dateDeparture, dateArrival),
                      transportationId: transportationId,
                      intend: intendController.text,
                    ),
                  ).then((writeResult) {
                    if(writeResult) {
                      DialogFunctions(context: context, message: 'Sukses membuat NPPD').okDialog(() {
                        RouteFunctions(context: context).backOffScreen(null);
                      });
                    } else {
                      DialogFunctions(context: context, message: 'Tidak dapat membuat NPPD, silahkan coba lagi').okDialog(() {

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