import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget{
  const Dropdown({super.key});

  @override
  State<StatefulWidget> createState() => DropdownState();

}

class DropdownState extends State<Dropdown>{
  String dropdownValue = 'Agency';
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
         canvasColor: Colors.grey.shade500,
    ),
    child: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        width: 50,
        color: Colors.grey.shade500,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });},
      items: <String>['Agency', 'Clerk', 'Passenger']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
    );
  }
}