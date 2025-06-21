import 'package:flutter/material.dart';

class PageInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFCCCCFF),
        title: Text(
          'INFORMACIJE O APLIKACIJI',
          style: TextStyle(color: Color(0xFF440D68)),
        ),
        iconTheme: IconThemeData(color: Color(0xFF440D68)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Text(
            '''
MNOŽILICA

Aplikacija množilica izrađena je u sklopu prijediplomskog kolegija Završni rad na Fakultetu elektrotehnike i računarstva Sveučilišta u Zagrebu, ak. god. 2024./2025.

Aplikacija je razvijena kao pomoć djeci u učenju množenja kroz igru i interaktivne zadatke.

Implementacija: Karla Šoštar
Mentorstvo: prof. dr. sc. Željka Car i univ.mag.ing.comp. Ana Radović
  ''',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Color(0xFF440D68),
              height: 1.6,
            ),
          ),

        ),
      ),
    );
  }
}
