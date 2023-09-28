import 'package:expensetrackermobileapp/controller/add_expense_controller.dart';
import 'package:expensetrackermobileapp/provider/change_selected_category.dart';
import 'package:expensetrackermobileapp/provider/date_selector_provider.dart';
import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:expensetrackermobileapp/validations/normal_text_form_validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final String title;
  final String date;
  final String amount;
  final String id;

  const EditScreen({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.id,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController newTitleController = TextEditingController();
  TextEditingController newAmountController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  List<String> category = [
    "Education",
    "Food",
    "Entertainment",
    "Insurance",
    "Others",
  ];
  @override
  void initState() {
    super.initState();
    newTitleController.text = widget.title;
    newAmountController.text = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    ChangeSelectedCategory selectedCategory =
        Provider.of<ChangeSelectedCategory>(context, listen: false);
    DateSelectorProvider dateSelectorProvider =
        Provider.of<DateSelectorProvider>(context, listen: false);
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  final message =
                      NormalTextFormValidation().validateNormalText(value!);
                  return message;
                },
                maxLength: 25,
                controller: newTitleController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.edit_document),
                  hintText: "Enter expense title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              TextFormField(
                validator: (value) {
                  final message =
                      NormalTextFormValidation().validateNormalText(value!);
                  return message;
                },
                keyboardType: TextInputType.number,
                controller: newAmountController,
                decoration: InputDecoration(
                    hintText: "Enter amount",
                    prefixIcon: const Icon(Icons.attach_money_outlined),
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
              const SizedBox(
                height: 20,
              ),
              Consumer<DateSelectorProvider>(
                builder: (context, value, child) {
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      leading: const Icon(Icons.date_range),
                      title: Text(value.currentDate),
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
                          value
                              .changeCurrentData(v.toString().substring(0, 10));
                        }).onError(
                          (error, stackTrace) {
                            ReusableSnackBar.showSnackBar(
                                context, "Date not Selected");
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.green,
                height: size.height * 0.06,
                shape: const StadiumBorder(),
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    AddExpenseController().updateExpense(
                        newTitleController.text,
                        newAmountController.text,
                        selectedCategory.selectedValue,
                        dateSelectorProvider.currentDate,
                        widget.id,
                        context);
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
