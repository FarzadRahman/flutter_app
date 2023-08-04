import 'package:calculator/widgets/expenses_list/expense_item.dart';
import 'package:calculator/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:calculator/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });

  }

  void removeExpenses(Expense expense){
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openExpenseOverlay(){
      showModalBottomSheet(context: context, builder: (ctx)=>  NewExpense(onAddExpense: addExpense,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions:  [IconButton(onPressed: _openExpenseOverlay, icon: const Icon(Icons.add))],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses,onRemoveExpense: removeExpenses,)),
        ],
      ),
    );
  }
}

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function (Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) =>
          Dismissible(
            onDismissed: (direction){
              onRemoveExpense(expenses[index]);
            },
              key: ValueKey(expenses[index]),
              child: ExpenseItem(expense: expenses[index])),

    );
  }
}
