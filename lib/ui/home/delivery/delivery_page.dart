import 'package:flutter/material.dart';
import 'package:instasend/view_models/delivery_model.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatefulWidget {

  @override
  _DeliveryPageState createState()
    => _DeliveryPageState();

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => DeliveryModel(),
      builder: (context, child) => DeliveryPage()
    );
  }

}

class _DeliveryPageState extends State<DeliveryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

}