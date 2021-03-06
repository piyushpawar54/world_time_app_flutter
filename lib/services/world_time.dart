import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for ui
  String time; //time in that location
  String flag; //url to asset flag icon
  String url; //location url to api endpoint
  bool isDaytime; //day or night

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async {

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      String datetime = data["datetime"];
      String offsethrs = data["utc_offset"].substring(1, 3);
      String offsetmin = data["utc_offset"].substring(4, 6);

      //flutter inbuilt function to convert data time string to date time objec
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsethrs), minutes: int.parse(offsetmin)));


      //set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print("Caught error: $e");
      time = "could not get time data!!";
    }


  }
}