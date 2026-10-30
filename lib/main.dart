import 'package:flutter/material.dart';
import 'package:tip_calculator/widgets/person_counter.dart';

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

  double _tipPercentage = 0.8;

  //methods

  void increment() {
    setState(() {
      _personCount++;
    });
  }
  void decrement() {
    setState(() {
      if (_personCount > 0) {
        _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                      "\$20.13", 
                      style: style.copyWith(fontSize: theme.textTheme.displaySmall?.fontSize)
                    ),
                  ],
                )
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                  TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      labelText: 'Input Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      print(value);
                    },
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
                      Text('\$20', style: theme.textTheme.titleMedium,)
                    ],
                  ),
                  // Slider Text
                  Text('${(_tipPercentage*100).round()}%', style: theme.textTheme.titleMedium,),
                  // Tip Slider
                  Slider(
                    min: 0.0,
                    max: 0.5,
                    label: '${(_tipPercentage*100).round()}%',
                    divisions: 5,
                    value: _tipPercentage, 
                    onChanged: (value) => { 
                      setState(() {                        
                      _tipPercentage = value;
                      })
                    }
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
