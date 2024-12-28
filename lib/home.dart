import 'package:flutter/material.dart';

class home extends StatefulWidget{
  @override
  _homeState createState() => _homeState();
}


class _homeState extends State<home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  Order _order = Order();

  String? _validateItemRequired(String? value) {
    return value == null || value.isEmpty ? 'Item Required' : null;
  }

  String? _validateItemCount(String? value) {
    int _valueAsInteger = value == null || value.isEmpty ? 0 : int.tryParse(value) ?? 0;
    return _valueAsInteger <= 0 ? 'At least one Item is Required' : null;
  }

  void _submitOrder() {
    if (_formStateKey.currentState?.validate() ?? false) {
      _formStateKey.currentState?.save();
      print('Order Item: ${_order.item}');
      print('Order Quantity: ${_order.quantity}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formStateKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Espresso',
                    labelText: 'Item',
                  ),
                  validator: (value) => _validateItemRequired(value),
                  onSaved: (value) => _order.item = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '3',
                    labelText: 'Quantity',
                  ),
                  validator: (value) => _validateItemCount(value),
                  onSaved: (value) => _order.quantity = int.tryParse(value ?? '0') ?? 0,
                ),
                Divider(height: 32.0,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  onPressed: _submitOrder, // Corrected method call
                  child: const Text('Save'), // Added button text
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Order {
  String item = '';
  int quantity = 0;

  Order({this.item = '', this.quantity = 0});
}