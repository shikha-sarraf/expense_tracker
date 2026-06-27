import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/add_expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen ({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {

  final List<Expense> _expenses =[
    Expense(title: 'Coffee', amount: 4.5, date: DateTime.now(), category: Category.food),
    Expense(title:'bus ticket',amount:2.0, date: DateTime.now(), category: Category.transport),
  ];

  void _addNewExpense(Expense expense) {
    setState((){
      _expenses.add(expense);
    });
  }
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      context: context,
      builder: (ctx) => AddExpense(onAddExpense: _addNewExpense),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text('Expenses')),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder:(context, index) {
          return Card(
            child:ListTile(
              title: Text(_expenses[index].title),
              trailing:Text('\$${_expenses[index].amount}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        child: Icon(Icons.add),
      ),
    );

  }

}