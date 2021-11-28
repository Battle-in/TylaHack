import 'package:flutter/material.dart';
import 'consts.dart';
import 'title_element.dart';
import 'package:http/http.dart' as http;

class LoginRegistration extends StatefulWidget {
  List citysRu = getCitysRu();
  String city = 'Москва';

  String login = '';
  String password = '';

  String regLogin = '';
  String regFirstPassw = '';
  String regSecondPassw = '';

  String firstName = '';
  String secondName = '';
  String age = '';
  String phoneNumber = '';

  final _formKey = GlobalKey<FormState>();

  @override
  _LoginRegistrationState createState() => _LoginRegistrationState();
}

class _LoginRegistrationState extends State<LoginRegistration> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child: Text('Вход'),),
                Tab(child: Text('Регистрация'),)
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Container(
                  width: 250,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        onChanged: (a){widget.login = a;},
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          labelText: 'login'
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (a){widget.password = a;},
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'password'
                        ),
                      ),
                      TextButton(onPressed: (){
                        enter();
                      }, child: Text('Вход'))
                    ],
                  ),
                )
              ),
              Center(
                child: Form(
                  key: widget._formKey,
                    child: ListView(
                      padding: EdgeInsets.only(top: 10, right: 20, left: 10),
                      children: [
                        TitleElement('Аккаунт'),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          validator: (value){
                            if (value!.length < 6){
                              return "Логин содержит меньше 6 символов";
                            }
                            return null;
                          },
                          onChanged: (a){widget.regLogin = a;},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'login'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          obscureText: true,
                          validator: (value){
                            if (value!.length < 6){
                              return "Пароль содержит меньше 6 символов";
                            }
                            return null;
                          },
                          onChanged: (a){widget.regFirstPassw = a;},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'password'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          obscureText: true,
                          validator: (value){
                            if(widget.regFirstPassw != value){
                              return 'Пароли не совпадают';
                            }
                            return null;
                          },
                          onChanged: (a){widget.regSecondPassw = a;},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'password again'
                          ),
                        ),
                        TitleElement("Немного о вас"),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, заполните поле';
                            }
                            return null;
                          },
                          onChanged: (a){widget.firstName = a;},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Имя'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, заполните поле';
                            }
                            return null;
                          },
                          onChanged: (a){widget.secondName = a;},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Фамилия'
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: DropdownButton(
                            isExpanded: true,
                            items: widget.citysRu.map((var item) =>
                                DropdownMenuItem(child: Text(item), value: item)).toList(),
                            onChanged: (value) {
                              setState(() {
                                print("selected $value");
                                widget.city = value.toString();
                              });
                            },
                            value: widget.city,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, заполните поле';
                            }
                            return null;
                          },
                          onChanged: (a){widget.age = a;},
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Возраст'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, заполните поле';
                            }
                            return null;
                          },
                          onChanged: (a){widget.phoneNumber = a;},
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Номер телефона'
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 60)),
                        InkWell(
                          onTap: (){
                            if(widget._formKey.currentState!.validate()){
                              registration();
                            }
                          },
                          child: Container(
                              child: Center(
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20)
                              ),
                                child: Center(
                                  child: Text('Регистрация', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                            ),
                          ),
                        )),
                        Padding(padding: EdgeInsets.only(top: 60)),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
  }

  Future<void> registration() async {
    Uri uri = Uri.parse('https://laboratory-msk.online/v1.0/register');
    var response = await http.post(uri, body: {
      'login' : widget.regLogin,
      'password' : widget.regFirstPassw,
      'name' : widget.firstName,
      'surname' : widget.secondName,
      'city' : widget.city,
      'district' : 'nety',
      'age' : widget.age,
      'phone' : widget.phoneNumber
    });
    if (response.statusCode >= 200 && response.statusCode < 300){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Вы успешно зарегистрированны'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Возникли проблемы в ходе регистрации')));
    }
  }

  Future<void> enter() async {
    Uri uri = Uri.parse('https://laboratory-msk.online/v1.0/login');
    var response = await http.post(uri, body: {
      'login' : widget.login,
      'password' : widget.password
    });
    print({
      'login' : widget.login,
      'password' : widget.password
    }.toString());
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300){
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Возникли проблемы при входе'))
      );
    }
  }
}
