import 'package:flutter/material.dart';
import 'package:tip_calculator/widgets/bill_amount_field.dart';
import 'package:tip_calculator/widgets/person_counter.dart';
import 'package:tip_calculator/widgets/tip_slider.dart';

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
          Padding(
            padding: EdgeInsets.all(8.0), 
            child: 
              Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      "Total per person", 
                      style: style
                    ),
                    Text(
                      "\$$total", 
                      style: style.copyWith(fontSize: theme.textTheme.displaySmall?.fontSize)
                    ),
                  ],
                )
              ),
          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Split', style: theme.textTheme.titleMedium,),
                      PersonCounter(
                        theme: theme, 
                        personCount: _personCount, 
                        onDecrement: decrement, 
                        onIncrement: increment,
                      ),
                    ],
                  ),
                  // Tip Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip', style: theme.textTheme.titleMedium,),
                      Text('\$$totalT', style: theme.textTheme.titleMedium,)
                    ],
                  ),
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


