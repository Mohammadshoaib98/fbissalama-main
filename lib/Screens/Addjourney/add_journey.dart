import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddJourneyPage extends StatefulWidget {
  @override
  State<AddJourneyPage> createState() => _AddJourneyPage();
}

class _AddJourneyPage extends State<AddJourneyPage> {
  static const String PATH_JOURNEYS = 'journeys';
  static const String PATH_SOURCE_CITY = 'sourceCity';
  static const String PATH_DESTENATION_CITY = 'destinationCity';
  static const String PATH_TIME_JOURNEY = 'time';
  static const String PATH_DATE_JOURNEY = 'Date';

  TimeOfDay time = TimeOfDay(hour: 9, minute: 00);
  DateTime date = DateTime.now();
  final firstDate = DateTime.now();
  final lastDate = DateTime(2222, 12);
  String sourceCity = '';
  String destenationCity = '';
  late DatabaseReference _journeys_ref;

  @override
  void initState() {
    _journeys_ref = FirebaseDatabase.instance.ref();
  }

  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add Journey',
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    items: [
                      DropdownMenuItem(
                          child: Text('Damascus'), value: 'Damascus'),
                      DropdownMenuItem(child: Text('Aleppo'), value: 'Aleppo'),
                      DropdownMenuItem(child: Text('Homs'), value: 'Homs'),
                      DropdownMenuItem(child: Text('Hama'), value: 'Hama'),
                    ],
                    hint: const Text(
                      'Source City',
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.lightBlueAccent),
                    ),
                    onChanged: (value) {
                      setState(() {
                        sourceCity = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Text(sourceCity, style: const TextStyle(fontSize: 20)),
                ],
              ),
              const Divider(thickness: 1, height: 20, color: Colors.blue),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    items:  [
                      DropdownMenuItem(
                          child: Text('Damascus'), value: 'Damascus'),
                      DropdownMenuItem(child: Text('Aleppo'), value: 'Aleppo'),
                      DropdownMenuItem(child: Text('Homs'), value: 'Homs'),
                      DropdownMenuItem(child: Text('Hama'), value: 'Hama'),
                    ],
                    hint: const Text(
                      'Destination City',
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.lightBlueAccent),
                    ),
                    onChanged: (value) {
                      setState(() {
                        destenationCity = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(destenationCity, style: const TextStyle(fontSize: 20)),
                ],
              ),
              const Divider(thickness: 1, height: 20, color: Colors.blue),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context, initialTime: time);
                        if (newTime == null) return;
                        setState(() => time = newTime);
                      },
                      child: const Text('Select Time')),
                  const SizedBox(
                    width: 60,
                  ),
                  Text(
                    '${hours}:${minutes}',
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              ),
              const Divider(thickness: 1, height: 20, color: Colors.blue),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => _openDatePicker(context),
                      child: const Text('Select Date')),
                  const SizedBox(
                    width: 60,
                  ),
                  Text(
                    '$date'.split(' ')[0],
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          validateValues(
                              date, time, sourceCity, destenationCity);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('Add Journey')))
            ],
          ),
        ),
      ),
    );
  }

  _openDatePicker(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: firstDate,
        lastDate: lastDate);
    if (selectedDate != null) {
      setState(() {
        date = selectedDate;
      });
    }
  }

  void validateValues(DateTime date, TimeOfDay time, String sourceCity,
      String destenationCity) {
    if (time == null ||
        date == null ||
        sourceCity.isEmpty ||
        destenationCity.isEmpty) {
      Fluttertoast.showToast(
          msg: 'To Add Journey.All fields must be filled out',
          fontSize: 14,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else if (sourceCity == destenationCity) {
      Fluttertoast.showToast(
          msg: 'It is not possible for source city same destination city',
          fontSize: 14,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else {
      addJourneysToDatabase(sourceCity, destenationCity, time, date);
    }
  }

  void addJourneysToDatabase(String sourceCity, String destenationCity,
      TimeOfDay time, DateTime dateTime) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    final date = '$dateTime'.split(' ')[0];
    final journey = <String, dynamic>{
      PATH_SOURCE_CITY: sourceCity,
      PATH_DESTENATION_CITY: destenationCity,
      PATH_TIME_JOURNEY: '${hours}:${minutes}',
      PATH_DATE_JOURNEY: date.toString()
    };
    DatabaseReference _journeyKey = _journeys_ref.child(PATH_JOURNEYS).push();
    _journeyKey
        .set(journey)
        .then((_) => Fluttertoast.showToast(
            msg: 'The journey has been successfully added',
            fontSize: 14,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white))
        .catchError((error) => Fluttertoast.showToast(
            msg: 'You get an error $error',
            fontSize: 14,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white));
    print(_journeyKey);
  }
}
