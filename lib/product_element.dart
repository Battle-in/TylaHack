import 'dart:collection';

import 'package:dostavka/main.dart';
import 'package:dostavka/product_page.dart';
import 'package:flutter/material.dart';

class ProductElement extends StatefulWidget {
  int productCount = 0;

  var data;


  ProductElement(this.data);

  @override
  _ProductElementState createState() => _ProductElementState();
}

class _ProductElementState extends State<ProductElement> {
  String title = '';
  int promoProcent = 0;


  _ProductElementState(){
    //print('>>>>>>>>' + widget.data.toString());
    // print('///' + widget.data['title']);
    // promoProcent = widget.data['promoProcent'];
  }

  @override
  Widget build(BuildContext context) {
    int maxPrice = 0;
    int minPrice = 100000;
    for (int i = 0; i < widget.data['deliveryData'].length; i++){
      int tmp = int.parse(widget.data['deliveryData'][i]['price']);
      if (maxPrice < tmp){
        maxPrice = tmp;
      }
      if (minPrice > tmp){
        minPrice = tmp;
      }
    }
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProductPage(widget.data, widget.productCount, (a){widget.productCount = a;})));
      },
      child: widget.productCount == 0 ?
      Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        height: 220,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      //color: Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                  ),
                  height: 130,
                  width: 150,
                  child: Image.network(widget.data['img']),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(padding: EdgeInsets.only(top: 4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            //Icon(Icons.ac_unit, ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Column(
                              children: [
                                Text(' ̶1̶2̶3̶ ̶р̶', style: TextStyle(fontSize: 10),),
                                Text(maxPrice == minPrice ? minPrice.toString() : minPrice.toString() + '-' + maxPrice.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), overflow: TextOverflow.ellipsis,)
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                widget.productCount++;
                                GminPrice += minPrice;
                                GmaxPrice += maxPrice;
                                updatePrice();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 5, top: 11),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ) : //ELSE ТУТ
      Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        height: 220,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.black,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                  ),
                  height: 130,
                  width: 150,
                  child: Image.network(widget.data['img']),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                    color: Colors.orange
                  ),
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(left: 110, top: 90),
                  padding: EdgeInsets.only(left: widget.productCount < 100 ? 10 : 2, top: 10),
                  child: Text(widget.productCount < 100 ? widget.productCount.toString() : '+99', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data['title'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(padding: EdgeInsets.only(top: 11)),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 8)),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          ' ̶1̶2̶3̶ ̶р̶',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(maxPrice == minPrice ? minPrice.toString() : minPrice.toString() + '-' + maxPrice.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), overflow: TextOverflow.ellipsis,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 69,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    widget.productCount--;
                                    GminPrice -= minPrice;
                                    GmaxPrice -= maxPrice;
                                    updatePrice();
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: Icon(Icons.horizontal_rule),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    widget.productCount++;
                                    GminPrice += minPrice;
                                    GmaxPrice += maxPrice;
                                    updatePrice();
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
    );
  }
}
