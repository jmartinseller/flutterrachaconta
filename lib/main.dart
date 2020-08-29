import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _vrconta = TextEditingController();
  final _Qtpessoas = TextEditingController();
  final _prgarcon = TextEditingController();
  var _infoText = "Preencha as informações!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _vrconta.text = "";
    _Qtpessoas.text = "";
    setState(() {
      _infoText = "Preencha as informações!";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor da Conta", _vrconta),
              _editText("Quantidade de Pagantes", _Qtpessoas),
              _editText("Porcentagem do Garçon", _prgarcon),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.purpleAccent ,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.purple,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.purple,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR O VALOR

  void _calculate(){
    setState(() {
      double valor = double.parse(_vrconta.text);
      double qtpessoas = double.parse(_Qtpessoas.text) ;
      double prgarcon = double.parse(_prgarcon.text)/100;
      double vrgarcon = prgarcon*valor;
      double vruni = (valor/qtpessoas)+ (vrgarcon/qtpessoas);
      double total = valor + vrgarcon;
      String vruniStr = vruni.toStringAsPrecision(4);
      String vrprogarcon = vrgarcon.toStringAsPrecision(4);
      String vrtotal = total.toStringAsPrecision(4);
      _infoText = "Valor Para Cada Um: $vruniStr"
      "\nValor Para o Garçon: $vrprogarcon"
      "\nValor Total da Conta: $vrtotal";


    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.purpleAccent, fontSize: 25.0),
    );
  }
}
