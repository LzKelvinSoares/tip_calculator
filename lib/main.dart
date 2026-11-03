import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tip_calculator/widgets/bill_amount_field.dart';
import 'package:tip_calculator/widgets/person_counter.dart';
import 'package:tip_calculator/widgets/providers/TipCalculatorModel.dart';
import 'package:tip_calculator/widgets/tip_row.dart';
import 'package:tip_calculator/widgets/tip_slider.dart';
import 'package:tip_calculator/widgets/total_per_person.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TipCalculatorModel(),
    child: const MyApp()
  ));
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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final model = Provider.of<TipCalculatorModel>(context);
    final style = theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(theme: theme, style: style, total: model.totalPerPerson),
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
                      model.updateBillTotal(double.parse(value));
                    }),
                    billAmount: model.billTotal.toString(),
                  ),
                  // Split Bill Area
                  PersonCounter(
                    theme: theme, 
                    personCount: model.personCount, 
                    onDecrement: model.decrement, 
                    onIncrement: model.increment,
                  ),
                  // Tip Section
                  TipRow(theme: theme, totalT: model.totalTip),
                  // Slider Text
                  Text('${(model.tipPercentage*100).round()}%', style: theme.textTheme.titleMedium,),
                  // Tip Slider
                  TipSlider(
                    tipPercentage: model.tipPercentage,
                    onChanged: (double value) => { 
                      model.updateTipPercentage(value)
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
