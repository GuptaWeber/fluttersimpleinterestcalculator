import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Simple Interest Calculator",
      home: InterestLayout(),
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green,
      ),
      )
  );
}

class InterestLayout extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _InterestLayout();
  }
}

class _InterestLayout extends State<InterestLayout>{
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees','Dollars','Pounds'];
  var _currencyItemSelected ='';
  
   @override 
    void initState(){
      super.initState();
      _currencyItemSelected = _currencies[0];
    }

TextEditingController principalController = TextEditingController();
    TextEditingController roiController = TextEditingController();
    TextEditingController termController = TextEditingController();

    var displayResult = '';
  @override
  Widget build(BuildContext context) {
    
    TextStyle textStyle = Theme.of(context).textTheme.title;
    
    return Scaffold(
      appBar: AppBar(title: Text("Simple Interest Calculator")),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
              imageAsset(),
            Padding(
              padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please Enter Rate of Interest';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Please Enter Principal Amount",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(left:20.0,right: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                    validator: (String value){
                    if(value.isEmpty){
                      return 'Please Enter Rate of Interest';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "Enter in percentage",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
            ),
          Padding( 
            padding: EdgeInsets.all(20.0),
            child:  Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: termController,
                    validator: (String value){
                    if(value.isEmpty){
                      return 'Please Enter Rate of Interest';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Term",
                    hintText: "In years",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),             
                ),

                Container(
                   width: 25.0,
                ),
                Expanded(
                  child:              
                DropdownButton<String>(
                    items: _currencies.map((String dropDownItem){
                      return DropdownMenuItem<String>(
                        value: dropDownItem,
                        child: Text(dropDownItem),
                      );
                    }).toList(),
                    value: _currencyItemSelected,
                    onChanged: (String newValueSelected){
                      _onDropDown(newValueSelected);

                    },
                ) 
                ,)

              ],
            ),),
           Padding( 
             padding: EdgeInsets.only(left: 20.0,right: 20.0),
             child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    child: Text("Calculate",textScaleFactor: 1.5,),                  

                    onPressed: (){

                      setState(() {
                        if(_formKey.currentState.validate()){
                            this.displayResult= _calculateInterest();
                        }                      
                      });
                    },
                  ),
                ),
                   Expanded(
                  child: RaisedButton(
                    child: Text("Reset",style: textStyle,),

                    onPressed: (){

                      setState(() {
                        _reset();                          
                      });                      
                    },
                  ),
                ),

              ],
            ),),

              Center(child:  Text(                
             this.displayResult, 
             style: textStyle,
            ),)
           

          ],
        ),
    ) ,
    );
  }

  Widget imageAsset(){
      AssetImage assetImage = AssetImage("./images/logo.png");
      Image image = Image(image: assetImage, width: 150.0, height: 150.0, );
      return Container(
        margin: EdgeInsets.all(20.0 ),
        child: image,
      );
  }


  void _onDropDown(String newValueSelected){
    setState(() {
          this._currencyItemSelected = newValueSelected;
        });
  }

  String _calculateInterest(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmount = (principal*roi*term)/100;
   String result = "After $term years, your Investment will be worth $totalAmount $_currencyItemSelected";
  return result;
  }

  void _reset(){
    principalController.text = '';
    roiController.text ='';
    termController.text='';
    displayResult = '';
    _currencyItemSelected = _currencies[0];

  }

}