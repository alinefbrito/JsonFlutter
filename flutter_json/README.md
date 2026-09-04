# flutter_json

## Visão geral

Este projeto é uma aplicação em Flutter que lê uma lista de músicas em formato JSON, converte esses dados em objetos da classe `Musica`, sorteia uma música aleatoriamente e exibe seus detalhes na interface. Além disso, o app permite abrir a faixa diretamente no Spotify.

A lógica principal envolve:

- leitura de arquivos locais em `assets`;
- parse de dados em JSON;
- conversão de registros em objetos Dart;
- uso de listas para armazenar e manipular os dados;
- atualização da interface por meio de `setState()`;
- integração com URLs externas por meio de `url_launcher`.

---

## Estrutura principal

### 1. `main.dart`

Arquivo responsável pela interface e pela lógica principal da aplicação.

Principais pontos:

- leitura do arquivo JSON com `rootBundle.loadString()`;
- conversão do conteúdo para uma estrutura dinâmica com `json.decode()`;
- criação de uma lista de objetos `Musica`;
- seleção aleatória de uma música com `Random()`;
- atualização da interface com `setState()`;
- renderização dos widgets da tela.

A aplicação usa widgets como:

- `MaterialApp`
- `Scaffold`
- `Column`
- `Text`
- `ElevatedButton`
- `Visibility`

Esses componentes permitem construir a tela e responder às ações do usuário.

---

### 2. `musica.dart`

Arquivo com a classe `Musica`, que representa cada item da coleção de músicas.

A classe encapsula atributos como:

- `trackID`
- `nome`
- `album`
- `artista`
- `lancamento`
- `duracao`
- `generos`

Além disso, ela possui:

- um construtor padrão;
- um construtor com parâmetros;
- um construtor `fromJson()` para converter dados do JSON em objetos;
- métodos para formatar a data e a duração;
- lógica de tratamento das datas recebidas no formato do arquivo.

Essa classe funciona como um modelo de domínio, permitindo que o restante do código trabalhe com objetos tipados em vez de mapas genéricos.

---

## Leitura e conversão de JSON

O fluxo de dados do projeto é:

1. o arquivo JSON é carregado do diretório `assets`;
2. o conteúdo é convertido para uma estrutura em Dart;
3. cada item é transformado em um objeto `Musica` via `Musica.fromJson()`;
4. a lista de músicas é armazenada em memória;
5. a interface usa essa coleção para exibir informações e sorteio.

Esse processo é fundamental para compreender como aplicativos consomem dados externos, como arquivos locais, APIs e serviços web.

---

## Estado e reatividade

A aplicação usa `StatefulWidget` para controlar informações que mudam em tempo de execução, como:

- a música escolhida no sorteio;
- a flag que define se a música deve ser exibida;
- o total de registros carregados.

Quando o estado muda, o método `setState()` é chamado para notificar o Flutter que a interface precisa ser redesenhada. Esse mecanismo é central para a construção de telas dinâmicas e interativas.

### Exemplo de uso de `setState()`

```dart
sorteiaMusica() {
  var r = Random();
  var index = r.nextInt(musicas.length);
  musicaSorteada = musicas[index];
  mostrarMusica = true;

  setState(() {
    musicaSorteada;
    mostrarMusica;
  });
}
```

### Explicação

- `musicaSorteada` recebe a música selecionada;
- `mostrarMusica` indica que a faixa deve ser exibida na tela;
- `setState()` dispara uma reconstrução do widget, atualizando a UI com os novos valores.

Esse padrão é essencial em Flutter, porque a interface reage às mudanças do estado interno da aplicação.

---

## Snippets do código e explicação dos métodos principais

### 1. Leitura do arquivo JSON

```dart
Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/liked_songs.json');
  Iterable data = await json.decode(response);
  musicas = List<Musica>.from(data.map((model) => Musica.fromJson(model)));
  total = musicas.length;
  setState(() {
    musicas;
    total;
  });
}
```

#### Conceitos envolvidos:

- `rootBundle`: acessa arquivos da pasta `assets`;
- `loadString`: lê o conteúdo do arquivo em formato texto;
- `json.decode`: transforma o JSON em uma estrutura Dart manipulável;
- `List<Musica>.from(...)`: converte os itens em objetos `Musica`;
- `setState()`: atualiza a UI após o carregamento.

---

### 2. Conversão de JSON para objeto

```dart
Musica.fromJson(Map<String, dynamic> json)
    : trackID = json['Track ID'] as String,
      nome = json['Track Name'] as String,
      album = json['Album Name'] as String,
      artista = json['Artist Name(s)'] as String,
      lancamento = Musica.tratarData(json['Release Date']),
      duracao = json['Duration (ms)'] as double,
      generos = json['enres'] as String;
```

#### Conceitos envolvidos:

- `Map<String, dynamic>`: estrutura de chave e valor que representa o JSON;
- `as String` e `as double`: conversão forçada para tipos esperados;
- `fromJson()`: padrão de desserialização para encapsular a conversão dos dados.

Esse padrão é muito usado em projetos que lidam com APIs e arquivos externos.

---

### 3. Tratamento da data

```dart
static DateTime tratarData(String dt) {
  final d = dt.toString().split('-');

  if (d.length == 1) {
    return DateTime(int.parse(d[0]));
  }

  if (d.length > 1) {
    final ano = d[0].isEmpty ? 2000 : d[0];
    final mes = d[1].isEmpty ? 01 : d[1];
    final dia = d[2].isEmpty ? 01 : d[2];

    return DateTime(
      int.parse(ano.toString()),
      int.parse(mes.toString()),
      int.parse(dia.toString()),
    );
  }

  return DateTime.now();
}
```

#### Conceitos envolvidos:

- processamento de strings;
- split para separar partes da data;
- uso de `DateTime` para normalizar valores;
- tratamento de casos incompletos de dados.

Esse tipo de normalização é necessário em dados trazidos de fontes externas, que nem sempre possuem estrutura idêntica.

---

### 4. Abertura de link externo

```dart
Future<void> _abreSpotify(String id) async {
  String str = "https://open.spotify.com/track/$id";
  final Uri url = Uri.parse(str);

  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
```

#### Conceitos envolvidos:

- `Uri.parse`: converte a URL em um objeto de URI;
- `launchUrl`: abre o recurso em um app ou navegador compatível;
- uso de `async/await` para operações assíncronas.

Esse trecho demonstra integração com serviços externos e navegação do app para uma ação fora da própria interface.

---

### 5. Biblioteca principal e suas funções

#### `dart:convert`

Biblioteca usada para transformar JSON em objetos manipuláveis e vice-versa.

```dart
import 'dart:convert';
```

Ela fornece, por exemplo, `json.decode()`, que converte texto JSON em estruturas Dart.

#### `flutter/services.dart`

Biblioteca usada para acessar recursos do sistema e arquivos do projeto, como o `rootBundle`.

```dart
import 'package:flutter/services.dart';
```

Ela permite leitura de assets do aplicativo, importante para dados locais como arquivos JSON.

#### `url_launcher`

Biblioteca externa usada para abrir URLs, como links de música ou páginas web.

```dart
import 'package:url_launcher/url_launcher.dart';
```

Ela abstrai a abertura de recursos externos e é muito útil quando o app precisa iniciar outra aplicação ou navegador.

#### `dart:math`

Biblioteca usada para geração de valores aleatórios.

```dart
import 'dart:math';
```

Ela fornece a classe `Random`, usada no sorteio da música.

---

## Sorteio aleatório

A função `sorteiaMusica()` gera um número aleatório dentro do intervalo da lista e seleciona uma música correspondente. Esse processo mostra como trabalhar com:

- listas;
- índices;
- geração de valores aleatórios;
- atualização do estado da aplicação.

Essa lógica é simples, mas demonstra um padrão muito usado em apps de recomendação, jogos, quizzes e experiências dinâmicas.

---

## Tratamento de datas e formatação

A data de lançamento originalmente vem em formato textual e precisa ser convertida para `DateTime`. Em seguida, a aplicação formata essa data para exibição em uma apresentação mais legível, como `dd/mm/aaaa`.

Esse tipo de processo é comum em aplicações reais, pois dados externos normalmente não vêm em um formato pronto para uso na interface.

---

## Integração com Spotify

A função `_abreSpotify(String id)` monta uma URL com o identificador da música e abre essa página no navegador ou no app do Spotify.

Esse exemplo mostra como um app pode:

- construir URLs dinâmicas;
- direcionar o usuário para um recurso externo;
- integrar a aplicação com serviços de terceiros.

---

## Conceitos aplicados

- `JSON` e desserialização para objetos Dart;
- `StatefulWidget` e gerenciamento de estado;
- uso de listas e seleção aleatória com `Random()`;
- normalização de dados, como datas e conversões de tipos;
- uso de widgets para composição da interface;
- integração com serviços externos usando `launchUrl()`;
- leitura de arquivos locais por meio de `rootBundle`.
