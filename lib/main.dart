import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vodoravno/PagePostavke.dart';
import 'package:vodoravno/PageTablica.dart';

import 'Broj1.dart';
import 'Broj3.dart';
import 'Page124.dart';
import 'Page369.dart';
import 'Page510.dart';
import 'Page78.dart';
import 'PageBrojevi.dart';
import 'PageInfo.dart';
import 'PageIzazov.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String _difficulty = 'Teško'; // default

  @override
  void initState() {
    super.initState();
    _loadDifficulty();
  }

  Future<void> _loadDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _difficulty = prefs.getString('difficulty') ?? 'Teško';
    });
  }

  bool _isGroupEnabled(String label) {
    switch (_difficulty) {
      case 'Lako':
        return label == '1,2,4';
      case 'Srednje':
        return ['1,2,4', '5,10', '3,6,9'].contains(label);
      case 'Teško':
      default:
        return true;
    }
  }

  Widget ovalButton(BuildContext context, String label, Widget targetPage, {bool enabled = true}) {
    return ElevatedButton(
      onPressed: enabled
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? Color(0xFFCCCCFF) : Colors.grey.shade300,
        foregroundColor: Color(0xFF440D68),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        textStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        elevation: 4,
        minimumSize: Size(200, 120),
      ),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/pictures/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Title
              const Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "MNOŽILICA",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF440D68),
                    ),
                  ),
                ),
              ),

              // Info icon
              Positioned(
                top: 20,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Color(0xFFCCCCFF),
                  radius: 50,
                  child: IconButton(
                    icon: Icon(Icons.info_outline, color: Color(0xFF440D68)),
                    iconSize: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageInfo()),
                      );
                    },
                  ),
                ),
              ),

              // Settings icon
              Positioned(
                top: 20,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Color(0xFFCCCCFF),
                  radius: 50,
                  child: IconButton(
                    icon: Icon(Icons.settings, color: Color(0xFF440D68)),
                    iconSize: 60,
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PagePostavke()),
                      );
                      _loadDifficulty(); // refresh difficulty after returning
                    },
                  ),
                ),
              ),

              // Left button: Brojevi
              Positioned(
                left: 40,
                top: MediaQuery.of(context).size.height * 0.2,
                child: ovalButton(context, "Brojevi", Broj1()),
              ),

              Positioned(
                left: 40,
                bottom: MediaQuery.of(context).size.height * 0.05,
                child: ovalButton(context, "Tablica", PageTablica()),
              ),

              // Right button: Izazov
              Positioned(
                right: 40,
                bottom: MediaQuery.of(context).size.height * 0.05,
                child: ovalButton(context, "Izazov", PageIzazov()),
              ),

              // Center buttons (2x2 grid)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ovalButton(context, "1,2,4", Page124(), enabled: _isGroupEnabled("1,2,4")),
                        SizedBox(width: 80),
                        ovalButton(context, "5,10", Page510(), enabled: _isGroupEnabled("5,10")),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ovalButton(context, "3,6,9", Page369(), enabled: _isGroupEnabled("3,6,9")),
                        SizedBox(width: 80),
                        ovalButton(context, "7,8", Page78(), enabled: _isGroupEnabled("7,8")),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
