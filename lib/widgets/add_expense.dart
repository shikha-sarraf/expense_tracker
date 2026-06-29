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
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    
    if(title.isEmpty || amount == null || _selectedDate == null){
      return;
    }

    widget.onAddExpense(
      Expense(
        title: title,
        amount: amount,
        date: _selectedDate!,  // ← use selected date
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  

  Category _selectedCategory = Category.food;

  void _onCategoryChanged(Category? value) {
    if (value== null) return;
    setState((){
      _selectedCategory =value;
    });
  }

  DateTime? _selectedDate;

  void _openDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
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

          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values.map((category) =>
              DropdownMenuItem(
                value: category,
                child: Text(category.name),
              )
            ).toList(),
            onChanged: _onCategoryChanged,
          ),

          TextButton(
            onPressed: _openDatePicker,
            child: Text(
              _selectedDate == null
                ? 'Select Date'
                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
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
