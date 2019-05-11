import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home()
));

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  TextEditingController celsiusController = TextEditingController();
  TextEditingController fahrenheintController = TextEditingController();
  TextEditingController kelvinController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Reseta os campos
  void _resetFields(){
    celsiusController.text = "";
    fahrenheintController.text = "";
    kelvinController.text = "";
  }

  void _converter(){
    if((double.parse(celsiusController.text) == 0)&&(double.parse(kelvinController.text) == 0)){
      double fahrenheint = double.parse(fahrenheintController.text);
      double celsius = (fahrenheint - 32)* 5/9;
      double kelvin = (fahrenheint - 32)* 5/9 + 273;
      celsiusController.text = celsius.toStringAsFixed(2);
      kelvinController.text = kelvin.toStringAsFixed(2);
    } else if((double.parse(celsiusController.text) == 0)&&(double.parse(fahrenheintController.text) == 0)){
      double kelvin = double.parse(kelvinController.text);
      double celsius = kelvin - 273;
      double fahrenheint = (kelvin - 273)* 9/5 + 32;
      fahrenheintController.text = fahrenheint.toStringAsFixed(2);
      celsiusController.text = celsius.toStringAsFixed(2);
    } else if((double.parse(fahrenheintController.text) == 0)&&(double.parse(kelvinController.text) == 0)) {
      double celsius = double.parse(celsiusController.text);
      double fahrenheint = celsius * 1.8 + 32.0;
      double kelvin = celsius + 273;
      fahrenheintController.text = fahrenheint.toStringAsFixed(2);
      kelvinController.text = kelvin.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Conversor de Temperatura"),
      centerTitle: true,
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _resetFields,
        ),
      ],
    );

    Image imgLogo = Image.asset("assets/images/logo.png", height: 120, width: 120,);

    //Icon icon = Icon(Icons.wb_sunny, size: 80, color: Colors.blue,);

    TextStyle styleDecoration = TextStyle(color: Colors.blueAccent, fontSize:20);
    TextStyle styleField = TextStyle(color: Colors.blueAccent);

    RaisedButton raisedButton = RaisedButton(
      onPressed: (){
        if (_formKey.currentState.validate()){
          _converter();
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Text("Calcular"),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      textColor: Colors.white70,
      color: Colors.blueAccent,
    );

    Container containerBtn = Container(
      height: 40.0,
      child: raisedButton,
    );

    Padding padding = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: containerBtn,
    );

    TextFormField tempCelsius = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Graus Celsius",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
          border: OutlineInputBorder(),
          suffixText: "ºC",
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: celsiusController,
      validator: (value){
        if(value.isEmpty){
          return "Informe um valor";
        }
      },
    );

    TextFormField tempFahrenheint = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Graus Fahrenheint",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
          border: OutlineInputBorder(),
          suffixText: "ºF",
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: fahrenheintController,
      validator: (value){
        if(value.isEmpty){
          return "Informe um valor";
        }
      },
    );

    TextFormField tempKelvin = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Graus Kelvin",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
          border: OutlineInputBorder(),
          suffixText: "K",
      ),
      textAlign: TextAlign.center,
      style: styleField,
      controller: kelvinController,
      validator: (value){
        if(value.isEmpty){
          return "Informe um valor";
        }
      },
    );


    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //icon, tempCelsius, tempFahrenheint, tempKelvin, padding
        imgLogo, tempCelsius, Divider(), tempFahrenheint, Divider(), tempKelvin, padding
      ],
    );

    Form form = Form(
      child: column,
      key: _formKey,
    );

    SingleChildScrollView singleChildScrollView = SingleChildScrollView(
      child: form,
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
    );

    Scaffold scaffold = Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: singleChildScrollView,
    );

    return scaffold;
  }
}