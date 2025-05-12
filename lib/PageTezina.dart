import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageTezina extends StatefulWidget {
  const PageTezina({Key? key}) : super(key: key);

  @override
  State<PageTezina> createState() => _PageTezinaState();
}

class _PageTezinaState extends State<PageTezina> {
  Set<String> _selectedSets = {'1,2,4', '5,10', '3,6,9', '7,8'};
  bool _timedMode = false;

  final Map<String, List<int>> _numberSets = {
    '1,2,4': [1, 2, 4],
    '5,10': [5, 10],
    '3,6,9': [3, 6, 9],
    '7,8': [7, 8],
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedSets = prefs.getStringList('numbersSets') ?? _numberSets.keys.toList();
    bool timed = prefs.getBool('timedMode') ?? false;
    setState(() {
      _selectedSets = savedSets.toSet();
      _timedMode = timed;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('numbersSets', _selectedSets.toList());
    await prefs.setBool('timedMode', _timedMode);
  }

  void _saveAndExit() async {
    await _saveSettings();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCCCCFF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF440D68)),
        title: const Text('ODABERI TEŽINU', style: TextStyle(color: Color(0xFF440D68), fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Odaberi grupe brojeva za vježbanje:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF440D68)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ..._numberSets.keys.map((set) => _buildOption(set)).toList(),
                const SizedBox(height: 10),
                Divider(thickness: 1.5, color: Color(0xFFCCCCFF)),
                SwitchListTile(
                  title: Text('Vremenski izazov (1 min)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF440D68))),
                  value: _timedMode,
                  activeColor: Color(0xFF440D68),
                  onChanged: (val) {
                    setState(() => _timedMode = val);
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _saveAndExit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFCCCCFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              child: const Text('Pohrani promjene', style: TextStyle(color: Color(0xFF440D68), fontWeight: FontWeight.bold, fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String set) {
    bool isSelected = _selectedSets.contains(set);

    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? _selectedSets.remove(set) : _selectedSets.add(set);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFCCCCFF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFF440D68), width: 2),
        ),
        child: Center(
          child: Text(
            set,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF440D68),
            ),
          ),
        ),
      ),
    );
  }

}
