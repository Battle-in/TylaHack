import 'package:flutter/material.dart';
import 'main.dart';

class ProductPage extends StatefulWidget {

  var data;
  int productCount;
  Function setProductCount;

  ProductPage(this.data, this.productCount, this.setProductCount);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.data['title']),),
      body: ListView(
        children: createContent(),
      ),
    );
  }

  List<Widget> createContent(){
    var minPrice = 0;
    var maxPrice = 0;
    for (int i = 0; i < widget.data['deliveryData'].length; i++){
      int tmp = int.parse(widget.data['deliveryData'][i]['price']);
      if (maxPrice < tmp){
        maxPrice = tmp;
      }
      if (minPrice > tmp){
        minPrice = tmp;
      }
    }
    Size size = MediaQuery.of(context).size;
    List<Widget> res = <Widget>[
      Container(
        height: 300,
        width: size.width,
        child: Image.network(widget.data['img']),
      ),
      Container(
        padding: EdgeInsets.only(left: 20),
        height: 100,
        width: size.width,
        color: Colors.orange,
        child: Center(
          child: Text(widget.data['title'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        ),
      ),
      Padding(padding: EdgeInsets.only(top: 20)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(onPressed: (){
            setState(() {
              widget.productCount--;
              GminPrice -= minPrice;
              GmaxPrice -= maxPrice;
              updatePrice();
              widget.setProductCount(widget.productCount);widget.setProductCount(widget.productCount);
            });
          }, child: Icon(Icons.horizontal_rule, color: Colors.black,), backgroundColor: Colors.orange,),
          Container(
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(widget.productCount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            ),
          ),
          FloatingActionButton(onPressed: (){
            setState(() {
              widget.productCount++;
              GminPrice += minPrice;
              GmaxPrice += maxPrice;
              addToCart(widget.data['productId']);
              widget.setProductCount(widget.productCount);
            });
          }, child: Icon(Icons.add, color: Colors.black,), backgroundColor: Colors.orange,)
        ],
      )
    ];

    for(int i = 0; i < widget.data['deliveryData'].length; i++){
      Color color;
      if (widget.data['deliveryData'][i]['title'] == 'Перекресток'){
        color = Colors.green;
      } else if (widget.data['deliveryData'][i]['title'] == 'Сбермаркет'){
        color = Colors.lightGreenAccent;
      } else if (widget.data['deliveryData'][i]['title'] == 'Самокат'){
        color = Colors.pinkAccent;
      } else if (widget.data['deliveryData'][i]['title'] == 'Яндекс.Лавка'){
        color = Colors.cyan;
      } else {
        color = Colors.grey;
      }

      res.add(Container(
        margin: EdgeInsets.only(left: 10, top: 15, right: 10,),
        padding: EdgeInsets.only(left: 15, right: 15),
        height: 70,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 7)),
                Row(
                  children: [
                    Container(
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                      ),
                      child: Image.network(widget.data['deliveryData'][i]['img'], scale: 1.4,),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(widget.data['deliveryData'][i]['title'], style: TextStyle(fontSize: 25,),),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 6, left: 10),
                  child: Text(widget.data['deliveryData'][i]['TimeAvg']),
                )
              ],
            ),
            Text(widget.data['deliveryData'][i]['price'] + " ₽", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
          ],
        ),
      ));
    }

    res.add(Container(

    ));

    return res;
  }
}
