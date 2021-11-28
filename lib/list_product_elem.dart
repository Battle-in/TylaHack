import 'package:dostavka/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListProductElem extends StatelessWidget {

  var data;
  int productCount = 0;

  ListProductElem(this.data);

  @override
  Widget build(BuildContext context) {
    int maxPrice = 0;
    int minPrice = 100000;
    for (int i = 0; i < data['deliveryData'].length; i++){
      int tmp = int.parse(data['deliveryData'][i]['price']);
      if (maxPrice < tmp){
        maxPrice = tmp;
      }
      if (minPrice > tmp){
        minPrice = tmp;
      }
    }
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(data, productCount, (a){})));},
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        height: 80,
                        width: 60,
                        child: FittedBox(
                          child: Image.network(data['img']),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 200,
                        child: Text(data['title']),
                      ),
                    ],
                  ),
                ),
                Text(maxPrice == minPrice ? minPrice.toString() : minPrice.toString() + '-' + maxPrice.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17), overflow: TextOverflow.ellipsis,),
                Padding(padding: EdgeInsets.only(right: 10))
              ],
            )
          ],
        ),
      ),
    );
  }
}


