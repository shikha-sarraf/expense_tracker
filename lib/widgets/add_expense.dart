import 'package:flutter/material.dart';
import'../models/expense.dart';

class AddExpense extends StatefulWidget{
  const AddExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense>{

  final _titleController =TextEditingController();
  final _amountController =TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveExpense(){
    final title =_titleController.text;
    final amount = double.tryParse(_amountController.text);
    if(title.isEmpty || amount == null){
      return;
    }

    widget.onAddExpense(
      Expense(
        title: title,
        amount: amount,
        date: DateTime.now(),
        category: Category.other,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text('Title')),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(label: Text('Amount')),
            keyboardType: TextInputType.number,
          ),
          Row(
            children:[
              ElevatedButton(
                onPressed: _saveExpense,
                child: Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
