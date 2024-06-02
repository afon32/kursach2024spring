import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sql_test_app/pages/add_buy/add_buy_page_controller.dart';
import 'package:sql_test_app/utils/utils.dart';
import 'package:sql_test_app/widgets/app_bar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddBuyPage extends StatelessWidget {
  const AddBuyPage({super.key});

  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddBuyPageController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 73, 76, 83),
          appBar: appBar(context),
          body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                          child: Text(
                            'Введите дату и стоимость покупки',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Times New Roman',
                                fontSize: 17.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.black),
                            ),
                            child: SfDateRangePicker(
                              selectionTextStyle:
                                  TextStyle(color: Colors.white),
                              backgroundColor: Colors.green,
                              //todayHighlightColor: Colors.green,
                              onSelectionChanged: _.onSelectionChanged,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10.0, left: 10.0, bottom: 10.0, top: 20.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          controller: _.priceController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text(
                                'Стоимость',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              prefixIcon: Icon(
                                Icons.attach_money,
                                color: Colors.white,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Введите число' : null,
                        ),
                      ),
                    ])),
                Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0, top: 30.0),
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: MediaQuery.sizeOf(context).width * 0.2,
                        child: ElevatedButton(
                          style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.green),
                              ),
                            onPressed: () {
                              if (_.priceController.text.isEmpty) {
                                Utils.showRedSnackBar('Введите стоимость!');
                              } else {
                                _.getCategories(context);
                                Utils.showGreenSnackBar('Покупка добавлена!');
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Подтвердить', style: TextStyle(
                                                  color: Colors.white,
                                                 // fontFamily: 'Times New Roman',
                                                  fontSize: 25.0))))),
              ],
            ),
          ),)
        );
      },
    );
  }
}
