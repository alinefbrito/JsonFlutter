class Musica {
  late String trackID;
  late String nome;
  late String album;
  late String artista;
  late DateTime lancamento;
  late double duracao;
  late String generos;
  Musica()
  {
    nome = "";
    this.artista = "";
    this.album = "";
    this.duracao = 0;
    this.generos="";
  this.lancamento = DateTime.now();
  this.trackID ="";

  }
  Musica.v(this.trackID,this.nome, this.album, this.artista, this.lancamento, this.duracao, this.generos);

  

  Musica.fromJson(Map<String, dynamic> json)
      : trackID = json['Track ID'] as String,
        nome = json['Track Name'] as String,
        album= json['Album Name'] as String,
        artista= json['Artist Name(s)'] as String,
        lancamento=DateTime.parse(json['Release Date']),
        duracao = json['Duration (ms)'] as double,
        generos= json['Genres'] as String ;

  Map<String, dynamic> toJson() => {
        'Track ID': trackID,
        'Track Name': nome,
        'Album Name': album,
        'Artist Name(s)': artista,
        'Release Date': lancamento,
        'Duration (ms)':duracao,
        'Genres': generos,
      };
      String dataLancFormatada()
  { 
    //sepsara a data em um vetor
    final dt = lancamento.toString().split(' ');
   //pega apenas a parte da data e descosidera a hora e separa em um novo vetor 
    //escreve o vetor de trás pra frente( dd/mm/aaaa) e junta novamente
    final d = dt[0].split('-').reversed.join('/');
    
    return d;
  }
  String tempo()
  { 
    return duracao.toString();
  }
} 