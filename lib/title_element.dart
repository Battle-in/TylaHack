import 'package:flutter/material.dart';

class TitleElement extends StatelessWidget {

  String title;

  TitleElement(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 40,
      child: Center(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
