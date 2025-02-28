import 'package:flutter/material.dart';
import 'package:stroy_baza/presentation/pages/orders_screen.dart';
import 'package:stroy_baza/presentation/widgets/map_widget.dart';


class ShopListScreen extends StatefulWidget {
  @override
  _ShopListScreenState createState() => _ShopListScreenState();
  static const routeName='/shop-list-screen';
}

class _ShopListScreenState extends State<ShopListScreen> {
  bool isMap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD1B07A),
        title: Text(isMap?"Xarita" :"Do'konlar", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0, // 0 qilamiz
        actions: [
          IconButton(
            icon: Icon(Icons.map, color: Colors.black),
            onPressed: () {
              setState(() {
                isMap = true;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.list, color: Colors.black),
            onPressed: () {
              setState(() {
                isMap = false;
              });
            },
          ),
          SizedBox(width: 10)
        ],
      ),
      body:isMap?MapWidget(): _buildList(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, OrdersScreen.routeName);
      },child: Icon(Icons.navigate_next),),
    );
  }

  Widget _buildList(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Ro'yxat",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.brown, size: 30),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Andijon Shahri, Qaysidir ko'cha, 10-a\nuy",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 230,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 223, 2, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Shu yerdan olaman",
                  style: TextStyle(color: Colors.black,fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

}
