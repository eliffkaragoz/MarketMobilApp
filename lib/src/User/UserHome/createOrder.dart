import 'package:flutter/material.dart';
import 'package:flutter_final_odevi/src/Manager/ManagerHome/orderList.dart';
import 'package:flutter_final_odevi/src/User/UserHome/CreateOrder/ProductListForOrder.dart';

class createOrder extends StatefulWidget {
  createOrder({Key key}) : super(key: key);
  @override
  _createOrderState createState() => _createOrderState();
}

class _createOrderState extends State<createOrder>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CREATE ORDER"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "PRODUCTS",
            ),
            Tab(text: "MY ORDER"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ProductListForOrder(),
          orderList(),
        ],
      ),
    );
  }
}
