import 'dart:convert';

import 'package:dostavka/list_product_elem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'title_element.dart';
import 'product_element.dart';
import 'login_registration.dart';
import 'cart_page.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        focusColor: Colors.orangeAccent
      ),
      initialRoute: '/login',
      routes: {
        '/home' : (context) => HomePage(),
        '/login' : (context) => LoginRegistration()
      },
      //home: HomePage(),
    );
  }
}

String userID = '';
String uuid = '';

int GminPrice = 0;
int GmaxPrice = 0;
Function updatePrice = (){};

class HomePage extends StatefulWidget {
  bool searchable = false;
  TextEditingController searchInput = TextEditingController();

  bool loaded = false;
  late List products;
  late List promoProducts;

  String search = '';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int additionalPoint = 0;

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    additionalPoint = 0;
    Size phoneSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        width: phoneSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(onPressed: (){}, child: Icon(Icons.person), backgroundColor: Colors.orange,),
            CartFloatingIconButton(),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.searchable ? IconButton(
            iconSize: 20,
            onPressed: (){
              setState(() {
                widget.searchable = false;
                widget.searchInput.clear();
              });
            }, icon: Icon(Icons.arrow_back_ios_sharp)) : Container(width: 0.1,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              //margin: EdgeInsets.only(top: 5, bottom: 5),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
              width: widget.searchable ? phoneSize.width * 0.78 : phoneSize.width * 0.90,
              height: 45,
              child: TextField(
                controller: widget.searchInput,
                onChanged: (a){
                  setState(() {
                    widget.search = a;
                  });
                },
                onTap: (){
                  setState(() {
                    widget.searchable = true;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Поиск продуктов"
                ),
              ),
            ),
          ],
        )
      ),
      body: widget.loaded ?
      !widget.searchable ?
      ListView(
        children: productList()
      ) :
      ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (context, items){
            if (widget.products[items]['title'].contains(widget.search)){
              return ListProductElem(widget.products[items]);
            } else {
              return Container();
            }
          }
          )
          :
          Center(
            child: CircularProgressIndicator(),
          )
    );
  }

  List<Widget> productList(){
    List<Widget> resElems = <Widget>[];
    int atRow = (widget.products.length * 140 / MediaQuery.of(context).size.width).toInt() - 1;
    print(atRow);
    List<Widget> elems = <Widget>[];

    for(int i = 0; i < (widget.products.length / atRow) && widget.products.length > additionalPoint; i++){
      for(int i = 0; i < atRow; i++){
        elems.add(ProductElement(widget.products[additionalPoint]));
        additionalPoint++;
      }
      resElems.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: elems));
      elems = <Widget>[];
    }

    List<Widget> res = [
      TitleElement('Акционные товары'),
      Container(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.promoProducts.length,
            itemBuilder: (context, index){
              return ProductElement(widget.promoProducts[index]);
            },
          )
      ),
      TitleElement('Продукты'),
    ];
    res.addAll(resElems);
    res.add(Padding(padding: EdgeInsets.only(top: 90),));
    return res;
  }
  
  Future<void> getData() async {
    Uri uri = Uri.parse('https://laboratory-msk.online/v1.0/getProductsFeed');
    var response = await http.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300){
      var temp = jsonDecode(response.body);

      setState(() {
        widget.loaded = true;
        widget.products = temp['data']['productData']['products'];
        widget.promoProducts = temp['data']['productData']['promoProducts'];
      });
    } else {
      print('bad req');
    }
  }
}


class CartFloatingIconButton extends StatefulWidget {

  @override
  _CartFloatingIconButtonState createState() => _CartFloatingIconButtonState();
}

class _CartFloatingIconButtonState extends State<CartFloatingIconButton> {

  @override
  void initState() {
    updatePrice = (){setState(() {

    });};
  }

  @override
  Widget build(BuildContext context) {
    //
    //
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(
          builder: (context) => CartPage()));},
      child: GminPrice == 0 ? FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.shopping_cart_rounded),
        onPressed: (){print('cart');},
      )
          : Container(
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10)
          ),
          height: 50,
          width: 100,
          child: Center(
            child: Text(GminPrice.toString() + '-' + GmaxPrice.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
          )
      ),
    );
  }


}

