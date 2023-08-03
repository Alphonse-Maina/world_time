import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    // This will NEVER fail
    if (route == null) return SizedBox.shrink();
    data = data.isNotEmpty ? data : route.settings.arguments as Map;
    print(data);
    String bgImage = data['isdaytime'] ? 'rising_sun.jpg' : 'nighttime.jpg';
    Color bgcolor = data['isdaytime'] ? Colors.blue : Colors.indigo;
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text(data['location'] + ' Weather'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
          child: Column(
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isdaytime': result['isdaytime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location),
                  label: Text('Edit Location')),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/${data['flag']}'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 50.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 80.0,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
