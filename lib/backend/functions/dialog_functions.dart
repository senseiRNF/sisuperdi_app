import 'package:flutter/material.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/destination_response.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/employee_response.dart';
import 'package:sisuperdi_app/backend/class_data/responseAPI/transportation_response.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';

class DialogFunctions {
  final BuildContext context;
  final String message;

  const DialogFunctions({
    required this.context,
    required this.message,
  });

  void okDialog(Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Perhatian',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                RouteFunctions(context: context).backOffScreen(null);
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      callback();
    });
  }

  void optionDialog(Function yes, Function no) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Perhatian',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                RouteFunctions(context: context).backOffScreen(false);
              },
              child: const Text(
                'Tidak',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                RouteFunctions(context: context).backOffScreen(true);
              },
              child: const Text(
                'Ya',
              ),
            ),
          ],
        );
      },
    ).then((result) {
      if(result != null) {
        if(result) {
          yes();
        } else {
          no();
        }
      }
    });
  }

  void listDestinationDialog(List<DestinationResponseData> listDestinationResponse, Function onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Pilih Tujuan',
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listDestinationResponse.length,
                  itemBuilder: (BuildContext listContext, int index) {
                    return ListTile(
                      onTap: () {
                        RouteFunctions(context: context).backOffScreen(
                          listDestinationResponse[index],
                        );
                      },
                      title: Text(
                        listDestinationResponse[index].tujuan ?? 'Tujuan Tak Diketahui',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((dynamic dialogResult){
      if(dialogResult != null) {
        onSelect(dialogResult);
      }
    });
  }

  void listTransportationDialog(List<TransportationResponseData> listTransportationResponse, Function onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Pilih Transportasi',
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listTransportationResponse.length,
                  itemBuilder: (BuildContext listContext, int index) {
                    return ListTile(
                      onTap: () {
                        RouteFunctions(context: context).backOffScreen(
                          listTransportationResponse[index],
                        );
                      },
                      title: Text(
                        listTransportationResponse[index].transportasi ?? 'Transportasi Tak Diketahui',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((dynamic dialogResult){
      if(dialogResult != null) {
        onSelect(dialogResult);
      }
    });
  }

  void listEmployeeDialog(List<EmployeeResponseData> listEmployeeResponse, Function onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Pilih Pegawai',
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listEmployeeResponse.length,
                  itemBuilder: (BuildContext listContext, int index) {
                    return ListTile(
                      onTap: () {
                        RouteFunctions(context: context).backOffScreen(
                          listEmployeeResponse[index],
                        );
                      },
                      title: Text(
                        listEmployeeResponse[index].nama ?? 'Nama Tak Diketahui',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((dynamic dialogResult){
      if(dialogResult != null) {
        onSelect(dialogResult);
      }
    });
  }
}