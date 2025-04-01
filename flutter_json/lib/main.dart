

import 'package:flutter/material.dart';
import 'package:flutter_json/musica.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shake/shake.dart';
//import para usar o Random
import 'dart:math';
//import para usar o json
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp( const MaterialApp (title: "App",
      home: MainApp(),));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});


  @override
  MainAPP createState() => MainAPP();
}

class MainAPP extends State<MainApp> {
 // ignore: unused_field
 late ShakeDetector _detector;
bool mostrarMusica = false;
List<Musica> musicas=List.empty();                                      
Musica musicaSorteada  = Musica();
int total = 0;
 Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/liked_songs.json');
     Iterable data = await json.decode(response);
    musicas =  List<Musica>.from(data.map((model)=> Musica.fromJson(model)));
    total = musicas.length;
    setState(() {
      musicas;
      total;
    });
  }




Future<void> _abreSpotify(String id) async {
  String str = "https://open.spotify.com/track/$id";
  final Uri url = Uri.parse(str);
   if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
    }}

sorteiaMusica()
{
  var r = Random();
  var index = r.nextInt(musicas.length);
   musicaSorteada =  musicas[index];
   mostrarMusica = true;
  setState(() {
   musicaSorteada;
   mostrarMusica;}
  );

}


  @override
   initState()  {
    super.initState();
       readJson();

        _detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sorteando!'),
          ),
        );
        sorteiaMusica();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        body:  Center(
          child:Padding(padding:const EdgeInsets.fromLTRB(25, 30, 25 , 30) ,
          child:Column(mainAxisSize: MainAxisSize.max,
           //Alinha no centro da página - vertical - , 
           //com distribuição uniforme
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children:<Widget>[ 
             Text('Sorteie uma das $total Músicas!:)', style: const TextStyle(color: Color.fromRGBO(73, 36, 62, 1), fontSize: 40, fontStyle: FontStyle.italic),),
            
            
            ElevatedButton(onPressed:sorteiaMusica,style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 64, 220, 111),fixedSize: const Size(250, 75)), child: const Text("Sorteio!!!",style: TextStyle(color: Color.fromRGBO(73, 36, 62, 1),fontSize:30,fontWeight: FontWeight.bold),),),
           Visibility(
  visible: mostrarMusica,
  child:Expanded(child: Column( 
  
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,mainAxisSize: MainAxisSize.max,
    children: <Widget>[
            Text(musicaSorteada.nome,
                style: const TextStyle(color: Color.fromRGBO(112, 66, 100, 1), 
                                  fontSize:30, 
                                  fontWeight: FontWeight.w600),),
            Text(musicaSorteada.artista,
                style: const TextStyle(color: Color.fromRGBO(112, 66, 100, 1), 
                                  fontSize:25, 
                                  fontWeight: FontWeight.w500),),
            Text(musicaSorteada.album,
                style: const TextStyle(color: Color.fromRGBO(112, 66, 100, 1), 
                                  fontSize:25, 
                                  fontWeight: FontWeight.w500),),
            Text(musicaSorteada.dataLancFormatada(),
                style: const TextStyle(color: Color.fromRGBO(112, 66, 100, 1), 
                                  fontSize:25, 
                                  fontWeight: FontWeight.w400),),
            Text(musicaSorteada.tempo(),
                style: const TextStyle(color: Color.fromRGBO(112, 66, 100, 1), 
                                  fontSize:25, 
                                  fontWeight: FontWeight.w400),),
            ElevatedButton(onPressed: () => _abreSpotify(musicaSorteada.trackID),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 80, 60, 120),
                    fixedSize: const Size(275, 75)), 
                 child: const Text('Ouvir no Spotify!', 
                 style: TextStyle(color: Color.fromRGBO(73, 36, 62, 1),
                  fontSize:25,fontWeight: FontWeight.bold)), )
           ])))

        ]
          )),
      ),
    ));
  }
}
