import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "";
  String _output = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = ""; // +, -, X, or /
  bool nextNum = false;
  String expression = "";
  String firstOperand = "";



  buttonPressed(String buttonText){

    if (buttonText == "CLEAR") {
      _output = "";
      expression = "";
      num1 = 0.0;
      num2 = 0.0;
      operand = ""; // +, -, X, or /
      nextNum = false;
      firstOperand = "";
    }else if (buttonText == "DEL"){
    if (_output.length > 0) {
      _output = _output.substring(0, output.length - 1);

      if (nextNum){
        expression += _output;
      }else {
        expression = _output;
      }
    }
    }else if (buttonText == "+" || buttonText == "-" || buttonText == "X" || buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      nextNum = true;


      if (firstOperand == "") {
        firstOperand = operand;
        expression += " " + operand + " ";
      }else{
        int firstSpace = expression.indexOf(" ");
        expression = expression.substring(0, firstSpace+1) + operand  + expression.substring(firstSpace+2, expression.length);
        num1 = double.parse(expression.substring(0, firstSpace+1));
      }




    }else if (buttonText == "."){
      if(_output.contains(".")){
        print("Already has a decimal");
        return;
      }else{

        _output = _output + buttonText;
        expression += buttonText;


      }
    }else if (buttonText == "="){
      num2 = double.parse(output);
      expression += " = ";

      if (operand == "+"){
        _output = (num1 + num2).toString();
      }
      if (operand == "-"){
        _output = (num1 - num2).toString();
      }
      if (operand == "X"){
        _output = (num1 * num2).toString();
      }
      if (operand == "/"){
        _output = (num1 / num2).toString();
      }
      print(num1.toString()+ " " +operand+ " "+ num2.toString());
      num1 = 0.0;
      num2 = 0.0;
      operand = "";



    }else{

      if (nextNum){
        _output = "";
        _output = _output + buttonText;
        nextNum = false;
        expression += buttonText;
      }else{
        _output = _output + buttonText;
        expression += _output.substring(_output.length-1, _output.length);
      }



    }


    setState(() {
      if ( _output.contains(".") && _output.substring(_output.indexOf("."), _output.length).length >8) {
        _output =  _output.substring(0,1)+_output.substring(_output.indexOf("."), _output.indexOf(".") + 9);
      }
        output = _output;

    });

  }

  Widget createButtonsVertical(String buttonText){
    Color buttonColor;
    Color textColor;
    if (buttonText == "+" || buttonText == "-" || buttonText == "X" || buttonText == "/"){
      buttonColor = Colors.white54;
      textColor = Colors.black;
    }else if (buttonText == "="){
      buttonColor = Colors.orange;
      textColor = Colors.white;
    }else{
      buttonColor = Colors.white;
      textColor = Colors.black;
    }
    if (buttonText == operand){
      buttonColor = Colors.black26;
      textColor = Colors.white;
    }
    return new Expanded( // Buttons takes up all vertical space
      child: new RaisedButton(
        padding: new EdgeInsets.all(24.0),
        child: new Text(buttonText,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: textColor
            )),
        onPressed: () =>
            buttonPressed(buttonText)
        ,
        color: buttonColor,
      ),
    );
  }

  Widget createButtonsHorizontal(String buttonText){
    Color buttonColor;
    Color textColor;
    if (buttonText == "+" || buttonText == "-" || buttonText == "X" || buttonText == "/"){
      buttonColor = Colors.white54;
      textColor = Colors.black;
    }else if (buttonText == "="){
      buttonColor = Colors.orange;
      textColor = Colors.white;
    }else{
      buttonColor = Colors.white;
      textColor = Colors.black;
    }
    if (buttonText == operand){
      buttonColor = Colors.black26;
      textColor = Colors.white;
    }
    return new Expanded( // Buttons takes up all vertical space
      child: new RaisedButton(
        padding: new EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 0.0
        ),

        child: new Text(buttonText,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: textColor
            )),
        onPressed: () =>
            buttonPressed(buttonText)
        ,
        color: buttonColor,
      ),
    );
  }

  _buildVerticalLayout(){
    return new Container(
        child: new Column(children: <Widget>[
          new Container(
              alignment: Alignment.centerRight ,
              padding: new EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0
              ),
              child: new Text(expression, style: new TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold
              ))),
      new Container(
          alignment: Alignment.centerRight ,
          padding: new EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0
          ),
          child: new Text(output, style: new TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold
          ))),

          new Expanded(child: new Divider(
              color: Colors.white
          ),
          ),

          Column(
            children: <Widget>[
              new Row(
                  children: [
                    createButtonsVertical("7"),
                    createButtonsVertical("8"),
                    createButtonsVertical("9"),
                    createButtonsVertical("/")
                  ]),
              new Row(
                  children: [
                    createButtonsVertical("4"),
                    createButtonsVertical("5"),
                    createButtonsVertical("6"),
                    createButtonsVertical("X")
                  ]),
              new Row(
                  children: [
                    createButtonsVertical("1"),
                    createButtonsVertical("2"),
                    createButtonsVertical("3"),
                    createButtonsVertical("-")
                  ]),
              new Row(
                  children: [
                    createButtonsVertical("."),
                    createButtonsVertical("0"),
                    createButtonsVertical("00"),
                    createButtonsVertical("+")
                  ]),
              new Row(
                  children: [
                    createButtonsVertical("CLEAR"),
                    createButtonsVertical("DEL"),
                    createButtonsVertical("=")
                  ]),


            ],
          )
        ],
        ));
  }

  _buildHorizontalLayout(){
    return new Container(
        child: new Column(children: <Widget>[
          new Container(
              alignment: Alignment.centerRight ,
              padding: new EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12.0
              ),
              child: new Text(output, style: new TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold
              ))),

          new Expanded(child: new Divider(
              color: Colors.white
          ),
          ),

          Column(
            children: <Widget>[
              new Row(
                  children: [
                    createButtonsHorizontal("7"),
                    createButtonsHorizontal("8"),
                    createButtonsHorizontal("9"),
                    createButtonsHorizontal("/")
                  ]),
              new Row(
                  children: [
                    createButtonsHorizontal("4"),
                    createButtonsHorizontal("5"),
                    createButtonsHorizontal("6"),
                    createButtonsHorizontal("X")
                  ]),
              new Row(
                  children: [
                    createButtonsHorizontal("1"),
                    createButtonsHorizontal("2"),
                    createButtonsHorizontal("3"),
                    createButtonsHorizontal("-")

                  ]),
              new Row(
                  children: [
                    createButtonsHorizontal("."),
                    createButtonsHorizontal("0"),
                    createButtonsHorizontal("00"),
                    createButtonsHorizontal("+")
                  ]),
              new Row(
                  children: [
                    createButtonsHorizontal("CLEAR"),
                    createButtonsHorizontal("DEL"),
                    createButtonsHorizontal("=")
                  ]),


            ],
          )
        ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),

        body: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildVerticalLayout()
                : _buildHorizontalLayout();
          },
        ));

  }
}
