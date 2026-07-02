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

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    final totalAmount = _expenses.fold(0.0, (sum, expense) => sum + expense.amount);

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_expenses.isNotEmpty) {
      mainContent = Expanded(
        child: ListView.builder(
          itemCount: _expenses.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(_expenses[index].id),
              onDismissed: (direction) {
                _removeExpense(_expenses[index]);
              },
              child: Card(
                child: ListTile(
                  title: Text(_expenses[index].title),
                  subtitle: Text('${_expenses[index].category.name} • ${_expenses[index].date.day}/${_expenses[index].date.month}/${_expenses[index].date.year}'),
                  trailing: Text('\$${_expenses[index].amount}'),
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Total: \$$totalAmount'),
            ),
          ),
          mainContent,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        child: Icon(Icons.add),
      ),
    );

  }

}