import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.lightBlueAccent[100] : Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 230.0, 0.0, 0.0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDaytime': result['isDaytime'],
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.white,
                  size: 30.0,
                ),
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    )
                  ),
                ]
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.white,
              ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
