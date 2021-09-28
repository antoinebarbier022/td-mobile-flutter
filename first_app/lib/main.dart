import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FirstCard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FirstCard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomeCardPage();
}

class _MyHomeCardPage extends State<MyHomePage> {

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
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          clipBehavior: Clip.none, 
          alignment: Alignment.center,
          children: <Widget> [
            card,
            const Positioned(
              top:-50,
              child: CircleAvatar(
                radius: 53,
                backgroundColor: Colors.blue, 
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://antoinebarbier.fr/img/iconAntoine.277bce40.jpeg'),
                  radius: 50,
                  backgroundColor: Colors.white
                ),
              ),
            )
          ],
        ), 
      ),
    ); 
  }

  Widget card = Container(
          width:330,
          height:200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Icon(Icons.person),
                  SizedBox(width: 10,),
                  Text('Antoine Barbier'),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Icon(Icons.email),
                  SizedBox(width: 10,),
                  Text('antoine.barbier01@etu.umontpellier.fr'),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  Icon(Icons.facebook),
                  SizedBox(width: 10,),
                  Text('antoineb_dev'),
                ],
              ),
            ],
          ),
        );

  Widget avatar = Container(
    width:30,
    height:30,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red,
    ),
  );
}

