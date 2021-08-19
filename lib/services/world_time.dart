import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from date
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('error caught : $e');
      time = 'Error getting time data';
    }

  }
}

