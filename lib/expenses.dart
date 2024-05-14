import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

// this widget must be full because in some of point we wanna start managing expenses
// for example add expenses and for that we update the list of UI
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final _listExpenses = ListExpenses();
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

/* Method for add item in the list  */
  void _addExpense(Expense expense) {
    setState(() {
      _listExpenses.registeredExpenses.add(expense);
    });
  }

/* Method to remove item from the list, in case delete 
accidentaly we show a message with Scaffold */
  void _removeExpense(Expense expense) {
    final expenseIndex = _listExpenses.registeredExpenses.indexOf(expense);
    setState(() {
      _listExpenses.registeredExpenses.remove(expense);
    });
    // ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense delete'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _listExpenses.registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* how much width we have available with mediaquery
    accedemos a metadatos en el momento de ejecucion del widget
    */
    final width = MediaQuery.of(context).size.width;
    /* Si no tenemos expenses mostramos un mensaje */
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );
    if (_listExpenses.registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _listExpenses.registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter expends tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _listExpenses.registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _listExpenses.registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
