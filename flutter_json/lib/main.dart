

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

//Cria uma classe StatefulWidget
class MainApp extends StatefulWidget {
  const MainApp({super.key});


  @override
  MainAPP createState() => MainAPP();
}

//
//Cria a classe de estado
class MainAPP extends State<MainApp> {

 
bool mostrarMusica = false;
List<Musica> musicas=List.empty();                                      
Musica musicaSorteada  = Musica();
int total = 0;

//método assincrono para ler o json
 Future<void> readJson() async {
  //lê o arquivo json da pasta assets
  //o arquivo deve ser declarado no pubspec.yaml
  //await indica que o método é assíncrono e deve esperar o resultado
  //rootBundle é um objeto que permite acessar os arquivos da pasta assets
  //loadString lê o arquivo como uma string
  //final indica que a variável não pode ser alterada depois de inicializada
    final String response = await rootBundle.loadString('assets/liked_songs.json');
     //decodifica o json
     //json.decode converte a string em um objeto dinâmico
     //Iterable é uma coleção de elementos que podem ser percorridos
     
     Iterable data = await json.decode(response);
      //converte o json para uma lista de objetos do tipo Musica
      //List.from cria uma lista a partir de uma coleção
      //map é um método que aplica uma função a cada elemento da coleção
     //model é o elemento atual da coleção
     //Musica.fromJson(model) cria o objeto do tipo Musica a partir do json
         musicas =  List<Musica>.from(data.map((model)=> Musica.fromJson(model)));
    //pega o total de músicas
    total = musicas.length;
    //define que o estado do objeto foi alterado
    setState(() {
      musicas;
      total;
    });
  }



//método assincrono para abrir o spotify a partir do id da música
Future<void> _abreSpotify(String id) async {
  //cria a url do spotify
  String str = "https://open.spotify.com/track/$id";
  //converte a string para um Uri
  //Uri == Uniform Resource Identifier
  final Uri url = Uri.parse(str);
  //tenta abrir a url utilizando o pacote url_launcher
   if (!await launchUrl(url)) {
    //se não conseguir abrir a url, lança uma exceção
        throw Exception('Could not launch $url');
    }}

sorteiaMusica()
{
  //cria um objeto da classe Random
  var r = Random();
  //sorteia um número entre 0 e o total de músicas
  var index = r.nextInt(musicas.length);
  //pega a música sorteada
   musicaSorteada =  musicas[index];
   mostrarMusica = true;
   //define que o estado do objeto foi alterado
  setState(() {
   musicaSorteada;
   mostrarMusica;}
  );

}

//método chamado quando o estado do objeto é criado
  @override
   initState()  {
    //chama o método initState da superclasse que é StatefulWidget
    super.initState();
    //chama o método para ler o json
       readJson();

       
    
    }
//método que constrói a interface do usuário
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
             Text('Sorteie uma das $total Músicas!', style: const TextStyle(color: Color.fromRGBO(73, 36, 62, 1), fontSize: 40, fontStyle: FontStyle.italic),),
            
            
            ElevatedButton(onPressed:sorteiaMusica,style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(187,132 , 147, 1),fixedSize: const Size(250, 75)), child: const Text("Sorteio!!!",style: TextStyle(color: Color.fromRGBO(73, 36, 62, 1),fontSize:30,fontWeight: FontWeight.bold),),),
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
                    backgroundColor: const Color.fromRGBO(219,175 , 160, 1),
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