import 'package:flutter/material.dart';
import 'package:tip_calculator/widgets/bill_amount_field.dart';
import 'package:tip_calculator/widgets/person_counter.dart';
import 'package:tip_calculator/widgets/tip_row.dart';
import 'package:tip_calculator/widgets/tip_slider.dart';
import 'package:tip_calculator/widgets/total_per_person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),        
        useMaterial3: true
      ),
      home: TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const new({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  int _personCount = 1;

  double _tipPercentage = 0.2;
  double _billTotal = 0.0;

  //methods
  double totalTip() {
    return (_billTotal*_tipPercentage);
  }

  double totalPerPerson() {
    return (totalTip() + _billTotal) / _personCount;
  }

  void increment() {
    setState(() {
      _personCount++;
    });
  }

  void decrement() {
    setState(() {
      if (_personCount > 1) {
        _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double total = totalPerPerson();
    double totalT = totalTip();
    final style = theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(theme: theme, style: style, total: total),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: 100,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  BillAmountField(
                    onChanged: (String value) => setState(() {
                      _billTotal = double.parse(value);
                    }),
                    billAmount: _billTotal.toString(),
                  ),
                  // Split Bill Area
                  PersonCounter(
                    theme: theme, 
                    personCount: _personCount, 
                    onDecrement: decrement, 
                    onIncrement: increment,
                  ),
                  // Tip Section
                  TipRow(theme: theme, totalT: totalT),
                  // Slider Text
                  Text('${(_tipPercentage*100).round()}%', style: theme.textTheme.titleMedium,),
                  // Tip Slider
                  TipSlider(
                    tipPercentage: _tipPercentage,
                    onChanged: (double value) => { 
                      setState(() {                        
                        _tipPercentage = value;
                      })
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
