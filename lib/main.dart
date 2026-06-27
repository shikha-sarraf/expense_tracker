import 'package:flutter/material.dart';
import 'models/expense.dart';
import 'widgets/expenses_screen.dart';

void main() {
  final testExpenses = [
    Expense(title: 'Coffee', amount: 4.5, date: DateTime.now(), category: Category.food),
    Expense(title: 'Bus ticket', amount: 2.0, date: DateTime.now(), category: Category.transport),
    Expense(title: 'Netflix', amount: 15.0, date: DateTime.now(), category: Category.entertainment),
  ];

  for (final expense in testExpenses) {
    print('${expense.title}: \$${expense.amount} (${expense.category})');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: ExpensesScreen(),
    );
  }
}