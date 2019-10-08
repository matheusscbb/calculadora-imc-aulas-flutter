import 'package:flutter/material.dart';
import 'package:calculadora_imc/models/Pessoa.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  bool isFemale = true;
  String _result;
  Pessoa pessoa = Pessoa();


  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildRowGenderSwitch(
              isSwitched: isFemale,
              switchHandle: (value) {
                isFemale = value;
              }
          ),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  void calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;

    Pessoa pessoa = Pessoa(weight: weight, height: height, gender: isFemale);

    setState(() {
      _result = pessoa.calculateImc();
    });
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateImc();
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget buildTextResult() {
    print('ooooi: ');
    print(pessoa.materializeColorScale);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red[pessoa.materializeColorScale ?? 100]),
      ),
    );
  }

  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
  
  Widget buildSwitch({bool isSwitched, Function switchHandler}) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(switchHandler(value));
      },
      activeTrackColor: Colors.pink,
      activeColor: Colors.pinkAccent,
      inactiveTrackColor: Colors.blueAccent, 
      inactiveThumbColor: Colors.blue,
    );
  }

  Widget buildRowGenderSwitch({bool isSwitched, Function switchHandle}) {
    return Center(
      child: Row(
        children: <Widget> [
          Text('Masculino', textAlign: TextAlign.left),
          buildSwitch(isSwitched: isSwitched, switchHandler: switchHandle),
          Text('Feminino', textAlign: TextAlign.right)
        ]
      )
    );
  }
}
