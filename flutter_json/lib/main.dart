

import 'package:flutter/material.dart';
import 'package:flutter_json/musica.dart';
import 'package:url_launcher/url_launcher.dart';
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
 

List<Musica> musicas =[Musica()];                                      
Musica musicaSorteada  = Musica();
int total = 0;
 Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/liked_songs.json');
    final data = await json.decode(response);
   
    await for (var mus in data) {
     var m =  Musica.fromJson(mus);
     addLista(m);
    }
  }

Future<void> _abreSpotify(String id) async {
  String str = "https://open.spotify.com/track/"+ id;
  final Uri url = Uri.parse(str);
   if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
    }}
addLista(m)
{

setState((){musicas.add(m);
  total = musicas.length;});


}
sorteiaMusica()
{
  var r = Random();
  var index = r.nextInt(musicas.length);
   musicaSorteada =  musicas[index];
  setState(() =>
   musicaSorteada
  );

}


  @override
  void initState() {
    super.initState();
    readJson();
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  Center(
          child:Padding(padding:const EdgeInsets.all(8.5) ,
          child:Column(
           //Alinha no centro da página - vertical - , 
           //com distribuição uniforme
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children:<Widget>[ 
             Text('Sorteie Uma das ${total} Músicas!'),
            
            
            ElevatedButton(onPressed:sorteiaMusica, child: const Text("Sorteio")),
            
            Text(musicaSorteada.nome),
            Text(musicaSorteada.artista),
            Text(musicaSorteada.album),
            Text(musicaSorteada.dataLancFormatada()),
            Text(musicaSorteada.tempo()),
            ElevatedButton(onPressed: () => _abreSpotify(musicaSorteada.trackID), child: const Text('Ouvir no Spotify!'))


        ]
          )),
      ),
    ));
  }
}
