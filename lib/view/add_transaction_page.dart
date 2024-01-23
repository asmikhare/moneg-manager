import 'package:expensetrackermobileapp/controller/add_expense_controller.dart';
import 'package:expensetrackermobileapp/provider/change_selected_category.dart';
import 'package:expensetrackermobileapp/provider/date_selector_provider.dart';
import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:expensetrackermobileapp/validations/normal_text_form_validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<String> category = [
    "Education",
    "Food",
    "Entertainment",
    "Insurance",
    "Others",
  ];
  String? first;
  @override
  void initState() {
    super.initState();
    first = category.first;
  }

  @override
  Widget build(BuildContext context) {
    ChangeSelectedCategory selectedCategory =
        Provider.of<ChangeSelectedCategory>(context, listen: false);
    var size = MediaQuery.sizeOf(context);
    DateSelectorProvider dateSelectorProvider =
        Provider.of<DateSelectorProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Add Transaction"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: globalKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 25,
                  validator: (value) {
                    final message =
                        NormalTextFormValidation().validateNormalText(value!);
                    return message;
                  },
                  controller: titleController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description),
                    labelText: "Enter the title of expense",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final message =
                        NormalTextFormValidation().validateNormalText(value!);
                    return message;
                  },
                  controller: amountController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.currency_rupee_outlined),
                      labelText: "Enter amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<ChangeSelectedCategory>(
                    builder: (context, value, child) {
                      return DropdownButton(
                        iconSize: 20,
                        icon: const Icon(Icons.arrow_downward_outlined),
                        padding: const EdgeInsets.only(left: 10),
                        value: value.selectedValue,
                        isExpanded: true,
                        items: category.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (selectedItem) {
                          value.changeCategory(selectedItem!);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Consumer<DateSelectorProvider>(
                    builder: (context, value, child) {
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      leading: const Icon(Icons.date_range),
                      title: Text(dateSelectorProvider.currentDate),
                      onTap: () async {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(
                            DateTime.now().year + 1,
                          ),
                        ).then((v) {
                          dateSelectorProvider.changeCurrentData(
                            v.toString().substring(0, 10),
                          );
                        }).onError((error, stackTrace) {
                          ReusableSnackBar.showSnackBar(
                              context, "Date not Selected");
                        });
                      },
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  elevation: 3,
                  height: size.height * 0.07,
                  minWidth: size.width,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      try {
                        AddExpenseController().addExpenseDetails(
                          titleController.text.trim(),
                          amountController.text.trim(),
                          selectedCategory.selectedValue,
                          dateSelectorProvider.currentDate,
                          context,
                          titleController,
                          amountController,
                        );
                      } catch (e) {
                        ReusableSnackBar.showSnackBar(
                            context, "An error occured");
                      }
                    }
                  },
                  child: const Text(
                    "Add Expense",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
