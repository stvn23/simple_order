import 'package:flutter/material.dart';

// Runs the app.
void main() => runApp(const TipApp());

// Main app with title and theme.
class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TipPage(),
    );
  }
}

// Turns text into a number, or null if not valid.
double? parseBill(String input) => double.tryParse(input.trim());

// Finds the tip and total amount.
({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

// Screen for typing the bill and picking a tip.
class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController = TextEditingController();
  int _selectedPercent = 15; // Starts at 15%.

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rawInput = _billController.text.trim();
    final billValue = parseBill(rawInput);

    final String tipText;
    final String totalText;

    // Checks if the input is empty or bad.
    if (rawInput.isEmpty || billValue == null || billValue < 0) {
      tipText = 'Enter a valid amount';
      totalText = 'Enter a valid amount';
    } else {
      final result = computeTip(billValue, _selectedPercent);
      tipText = result.tip.toStringAsFixed(2);
      totalText = result.total.toStringAsFixed(2);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bill text box.
            TextField(
              controller: _billController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Bill Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tip Percentage',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Tip percent buttons.
            SegmentedButton<int>(
              segments: const [
                ButtonSegment<int>(value: 10, label: Text('10%')),
                ButtonSegment<int>(value: 15, label: Text('15%')),
                ButtonSegment<int>(value: 20, label: Text('20%')),
              ],
              selected: {_selectedPercent},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedPercent = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 30),
            // Shows tip and total.
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tip:', style: TextStyle(fontSize: 18)),
                        Text(
                          tipText,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 18)),
                        Text(
                          totalText,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
