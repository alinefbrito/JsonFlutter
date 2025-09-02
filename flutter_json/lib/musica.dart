//classe para representar uma música
class Musica {
  //late indica que a variável será inicializada depois do construtor
  //final indica que a variável não pode ser alterada depois de inicializada
  late String trackID;
  late String nome;
  late String album;
  late String artista;
  late DateTime lancamento;
  late double duracao;
  late String generos;
  //construtor padrão
  Musica()
  {
    nome = "";
    artista = "";
    album = "";
    duracao = 0;
    generos="";
  lancamento = DateTime.now();
  trackID ="";

  }
  //construtor nomeado necessário para criar o objeto a partir do json
  //construtor nomeado é chamado com o nome da classe seguido de um ponto e o nome do construtor
  Musica.v(this.trackID,this.nome, this.album, this.artista, this.lancamento, this.duracao, this.generos);

  
//método necessário para criar o objeto a partir do json

  Musica.fromJson(Map<String, dynamic> json)
      : trackID = json['Track ID'] as String,
        nome = json['Track Name'] as String,
        album= json['Album Name'] as String,
        artista= json['Artist Name(s)'] as String,
        lancamento=Musica.tratarData(json['Release Date']),
        duracao = json['Duration (ms)'] as double,
        generos= json['Genres'] as String ;
//método necessário para converter o objeto em json
//útil para salvar o objeto em um arquivo ou enviar para uma API
  Map<String, dynamic> toJson() => {
        'Track ID': trackID,
        'Track Name': nome,
        'Album Name': album,
        'Artist Name(s)': artista,
        'Release Date': lancamento,
        'Duration (ms)':duracao,
        'Genres': generos,
      };
      //método para formatar a data de lançamento no formato dd/mm/aaaa
      //ex: 2020-05-01 -> 01/05/2020
      String dataLancFormatada()
  { 
    //separa a data em um vetor
    final dt = lancamento.toString().split(' ');
   //pega apenas a parte da data e descosidera a hora e separa em um novo vetor 
    //escreve o vetor de trás pra frente( dd/mm/aaaa) e junta novamente
    final d = dt[0].split('-').reversed.join('/');
    
    return d;
  }
  //método estático para tratar a data que pode vir em diferentes formatos
  //ex: "2020-05-01", "2020-05", "2020"
  //se a data estiver incompleta, preenche com 01 para dia e mês
 static DateTime tratarData(String dt)
  {
   
    final d = dt.toString().split('-');
    if(d.length==1) {
    return DateTime(int.parse(d[0]));
}
if(d.length>1)
{
final ano = d[0].isEmpty?2000:d[0];
 final mes = d[1].isEmpty?01:d[1];
 final dia = d[2].isEmpty?01:d[2];
    return DateTime(int.parse(ano.toString()),int.parse(mes.toString()), int.parse(dia.toString()));
}
  return DateTime.now();
  }
  String tempo()
  { 
    return duracao.toString();
  }
}