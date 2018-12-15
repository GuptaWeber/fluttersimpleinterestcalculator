import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: "StateFull Test",
      home: FavouriteCity(),
    )
  );
}

class FavouriteCity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FavouriteCityState();
  }
}

class _FavouriteCityState extends State<FavouriteCity>{
  String nameCity ="";
  var _currencies =['Rupees','Dollars','Pounds','Others'];
  String currency = "Rupees";  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The StateFul Demo"),
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (String userInput){
                  setState(() {
                  nameCity = userInput;            
                  });
                  },
              ),
          DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem){
                 return DropdownMenuItem<String>(
                   value: dropDownStringItem,
                   child: Text(dropDownStringItem),
                 );
              }).toList(),

            onChanged: (String newValueSelected){
              setState(() {
                this.currency = newValueSelected;
              });
            },

          ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text("Your Best City is $nameCity",
                style: TextStyle(fontSize: 20.0),)
              ),
            ],
          ),
        ),
      ),
    );
  }

}