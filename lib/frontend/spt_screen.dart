import 'package:flutter/material.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';
import 'package:sisuperdi_app/frontend/form_report_screen.dart';

class SPTScreen extends StatefulWidget {
  const SPTScreen({Key? key}) : super(key: key);

  @override
  State<SPTScreen> createState() => _SPTScreenState();
}

class _SPTScreenState extends State<SPTScreen> {

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
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (BuildContext listContext, int index) {
              return ListTile(
                title: const Text(
                  'Rizal Cassidy - 0123456789',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Kunjungan & Rapat di Kantor Walikota Solo',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    RouteFunctions(context: context).moveScreen(const FormReportScreen(), (callback) {

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
              );
            },
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