import 'package:flutter/material.dart';

class Region2 extends StatefulWidget {
  const Region2({super.key});

  @override
  State<Region2> createState() => _Region2State();
}

class _Region2State extends State<Region2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(220, 195, 139, 1),
        title: Text(
          "Yetkazib berish shahrini tanlang",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 22, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCityButton("Toshkent shahri"),
            SizedBox(height: 50),
            _buildCityButton("Andijon shahri"),
            SizedBox(height: 50),
            _buildCityButton("Farg’ona shahri"),
            SizedBox(height: 50),
            _buildCityButton("Namangan shahri"),
            
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Powered by", style: TextStyle(color: Color.fromRGBO(67, 67, 67, 0.81), fontSize: 16, fontWeight: FontWeight.w500),),
                    const SizedBox(width: 5,),
                    GestureDetector(
                        onTap: (){},
                        child: const Text("NSD CORPORATION",style: TextStyle(color: Color.fromRGBO(130, 100, 242, 1), fontSize: 16, fontWeight: FontWeight.w500),)
                    ),
                  ],
                ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _buildCityButton(String cityName) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        cityName,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
