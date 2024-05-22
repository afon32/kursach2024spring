import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/add_buy/add_buy_page_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddBuyPage extends StatelessWidget {
  const AddBuyPage({super.key});

  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddBuyPageController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _.priceController,
                    cursorColor: Colors.blueAccent,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Стоимость покупки',
                        prefixIcon: Icon(Icons.mail),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        )),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value == null ? 'Введите число' : null,
                  ),
                ),
                SfDateRangePicker(
                  onSelectionChanged: _.onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.single,
                ),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: ElevatedButton(
                            onPressed: () {
                              _.getCategories(context);
                            },
                            child: const Text('Загрузка документов')))),
              ],
            ),
          ),
        );
      },
    );
  }
}
