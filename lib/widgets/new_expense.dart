import 'package:flutter/material.dart';
import 'package:calculator/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function (Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory=Category.leisure;

  void submitExpenseData(){
    final enteredAmount= double.tryParse(_amountController.text);
    final amountInvalid= enteredAmount == null || enteredAmount <=0;
    if(_titleController.text.trim().isEmpty || amountInvalid || _selectedDate == null){
      showDialog(context: context, builder: (ctx)=>
         AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure title, amount and date are valid'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(ctx);
            }, child: const Text('Okay'))
          ],
        )
      );

      return;
    }

    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickDate;
    });
  }
  // var _enteredTitle='';
  // void _saveTitleInput(String title){
  //   _enteredTitle=title;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // onChanged: _saveTitleInput,
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      label: Text('Amount'), prefix: Text('\$')),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Selected'
                      : dateFormatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              )),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value){
                    setState(() {
                      if(value==null){
                        return;
                      }
                      _selectedCategory=value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),

              ElevatedButton(
                  onPressed: () {
                    submitExpenseData();
                  },
                  child: const Text('Save Expanse'))
            ],
          )
        ],
      ),
    );
  }
}
