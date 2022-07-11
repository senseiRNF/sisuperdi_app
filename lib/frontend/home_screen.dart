import 'package:flutter/material.dart';
import 'package:sisuperdi_app/backend/class_data/home_icon_class.dart';
import 'package:sisuperdi_app/backend/functions/dialog_functions.dart';
import 'package:sisuperdi_app/backend/functions/route_functions.dart';
import 'package:sisuperdi_app/backend/functions/shared_preferences.dart';
import 'package:sisuperdi_app/backend/variables/global.dart';
import 'package:sisuperdi_app/frontend/nppd_screen.dart';
import 'package:sisuperdi_app/frontend/receipt_screen.dart';
import 'package:sisuperdi_app/frontend/report_screen.dart';
import 'package:sisuperdi_app/frontend/splash_screen.dart';
import 'package:sisuperdi_app/frontend/spt_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeIcon> iconMenu = [];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    await SPrefs().readAuth().then((result) {
      if(result != null) {
        if(result.role == 'pegawai') {
          setState(() {
            iconMenu = [
              HomeIcon(
                imagePath: '${GlobalString.imagePath}/nppd-icon.png',
                onPress: () {
                  RouteFunctions(context: context).moveScreen(const NPPDScreen(), (callback) {

                  });
                },
              ),
              HomeIcon(
                imagePath: '${GlobalString.imagePath}/spt-icon.png',
                onPress: () {
                  RouteFunctions(context: context).moveScreen(const SPTScreen(), (callback) {

                  });
                },
              ),
              HomeIcon(
                imagePath: '${GlobalString.imagePath}/report-icon.png',
                onPress: () {
                  RouteFunctions(context: context).moveScreen(const ReportScreen(), (callback) {

                  });
                },
              ),
              HomeIcon(
                imagePath: '${GlobalString.imagePath}/receipt-icon.png',
                onPress: () {
                  RouteFunctions(context: context).moveScreen(const ReceiptScreen(), (callback) {

                  });
                },
              ),
            ];
          });
        } else {
          setState(() {
            iconMenu = [
              HomeIcon(
                imagePath: '${GlobalString.imagePath}/nppd-icon.png',
                onPress: () {
                  RouteFunctions(context: context).moveScreen(const NPPDScreen(), (callback) {

                  });
                },
              ),
              HomeIcon(
                imagePath: '${GlobalString.imagePath}/spt-icon.png',
                onPress: () {
                  RouteFunctions(context: context).moveScreen(const SPTScreen(), (callback) {

                  });
                },
              ),
            ];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: GlobalColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'SISUPERDI',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (result) async {
              if(result == 'logout') {
                DialogFunctions(context: context, message: 'Keluar dari sesi saat ini, Anda yakin?').optionDialog(() async {
                  await SPrefs().deleteAuth().then((authResult) {
                    if(authResult) {
                      RouteFunctions(context: context).replaceScreen(const SplashScreen());
                    }
                  });
                }, () {

                });
              }
            },
            itemBuilder: (BuildContext menuContext) => <PopupMenuEntry> [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    'Selamat Datang\nPegawai K3',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 120.0,
                  width: 200.0,
                  child: Image.asset(
                    '${GlobalString.imagePath}/logo-disnakertrans.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
              ),
              itemCount: iconMenu.length,
              itemBuilder: (BuildContext sliverContext, int index) {
                return InkWell(
                  onTap: () => iconMenu[index].onPress!(),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0,),
                  ),
                  child: Image.asset(
                    iconMenu[index].imagePath!,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}