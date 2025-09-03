## Estrutura da Classe Musica (`lib/musica.dart`)

A classe `Musica` é responsável por representar cada música do projeto, facilitando o tratamento dos dados vindos do JSON e a exibição das informações na interface.

---

### Principais Atributos

- **trackID**: Identificador único da música no Spotify.
- **nome**: Nome da música.
- **album**: Nome do álbum.
- **artista**: Nome(s) do(s) artista(s).
- **lancamento**: Data de lançamento (`DateTime`).
- **duracao**: Duração da música em milissegundos.
- **generos**: Gêneros musicais associados.

---

### Construtores

- **Construtor padrão**: Inicializa os atributos com valores vazios ou padrão.
- **Construtor nomeado (`Musica.v`)**: Permite criar o objeto informando todos os atributos.
- **Construtor a partir do JSON (`Musica.fromJson`)**: Facilita a criação do objeto a partir dos dados lidos do arquivo JSON.

---

### Métodos Importantes

- **toJson()**  
  Converte o objeto `Musica` em um mapa JSON, útil para salvar ou enviar dados.

- **dataLancFormatada()**  
  Retorna a data de lançamento no formato `dd/mm/aaaa`, tornando a informação mais amigável para o usuário.

- **tratarData(String dt)**  
  Método estático que trata diferentes formatos de data vindos do JSON, preenchendo valores faltantes com `01` para mês ou dia.

- **tempo()**  
  Retorna a duração da música como string.

---

### Destaques

- A classe lida com diferentes formatos de data, tornando o app mais robusto para arquivos JSON variados.
- Os comentários explicam cada etapa, facilitando a manutenção e entendimento do código.
- Permite fácil integração com APIs ou arquivos externos, graças aos métodos de conversão para e a partir de JSON.

---

## Funcionamento do Projeto

Este projeto Flutter sorteia músicas a partir de um arquivo JSON e permite ao usuário ouvir a música sorteada diretamente no Spotify.

### Principais Funcionalidades

- **Leitura do JSON:**  
  O app lê o arquivo `assets/liked_songs.json` (declarado no `pubspec.yaml`) usando o método assíncrono `readJson()`. O conteúdo é convertido em uma lista de objetos `Musica`.

- **Sorteio de Música:**  
  Ao clicar no botão "Sorteio!!!", o método `sorteiaMusica()` seleciona aleatoriamente uma música da lista carregada.

- **Exibição das Informações:**  
  Quando uma música é sorteada, são exibidos:
  - Nome da música
  - Artista
  - Álbum
  - Data de lançamento formatada (`dd/mm/aaaa`)
  - Duração

- **Abrir no Spotify:**  
  O botão "Ouvir no Spotify!" abre a música sorteada diretamente no Spotify, usando o pacote `url_launcher`.

### Observações

- O arquivo JSON deve estar corretamente referenciado no `pubspec.yaml`.
- Os comentários do código explicam cada etapa do processo, facilitando o entendimento.
- O projeto utiliza `Musica` para representar cada música e tratar diferentes formatos de data.

---

## Visual do App

A interface do aplicativo é simples e intuitiva:

- Exibe o total de músicas disponíveis para sorteio.
- Um botão centralizado ("Sorteio!!!") permite ao usuário sortear uma música.
- Após o sorteio, são exibidas as informações detalhadas da música escolhida.
- Um botão adicional permite ouvir a faixa diretamente no Spotify.

---

## Requisitos e Dependências

- **Flutter**  
- **Pacotes:**  
  - `url_launcher` (abrir links externos)

- **Arquivo JSON:**  
  - Certifique-se de declarar `assets/liked_songs.json` no `pubspec.yaml`.

---
...existing code...

---

## Explicação dos Métodos e Conceitos do Arquivo `main.dart`

O arquivo `main.dart` é o núcleo do aplicativo Flutter. Ele gerencia o ciclo de vida do app, a interface e a lógica de sorteio das músicas. Abaixo estão os principais métodos e conceitos utilizados:

### Métodos Principais

- **main()**  
  Ponto de entrada do app. Inicializa o Flutter e define o widget principal.

- **readJson()**  
  Método assíncrono responsável por carregar as músicas do arquivo JSON localizado em `assets/liked_songs.json`.  
  **Funcionamento detalhado:**  
  - Utiliza o `rootBundle.loadString` para ler o conteúdo do arquivo como uma string.
  - Decodifica a string usando `json.decode`, transformando-a em uma coleção dinâmica.
  - Utiliza o método `map` para converter cada elemento da coleção em um objeto da classe `Musica` através do construtor `Musica.fromJson`.
  - Armazena todos os objetos `Musica` em uma lista.
  - Calcula o total de músicas disponíveis.
  - Chama `setState()` para atualizar o estado do app, garantindo que a interface reflita os dados carregados.
  - **Observação:** O método é chamado no `initState()`, garantindo que as músicas sejam carregadas assim que o app inicia.


- **sorteiaMusica()**  
  Utiliza a classe `Random` para selecionar uma música aleatoriamente da lista carregada. Atualiza o estado para exibir as informações da música sorteada.

- **_abreSpotify(String id)**  
  Cria uma URL para a música sorteada no Spotify e tenta abrir essa URL usando o pacote `url_launcher`. Caso não seja possível, lança uma exceção.

- **initState()**  
  Método do ciclo de vida do Flutter chamado ao criar o estado do widget. Utilizado para inicializar dados, como a leitura do JSON.

- **build(BuildContext context)**  
  Constrói a interface do usuário. Utiliza widgets como `Scaffold`, `Column`, `Text`, `ElevatedButton` e `Visibility` para organizar e exibir os elementos na tela.

---

### Conceitos Utilizados

- **StatefulWidget**  
  Permite que o app tenha uma interface dinâmica, reagindo a mudanças de estado (como o sorteio de uma música).

- **Assincronismo**  
  Métodos como `readJson()` usam `async/await` para garantir que operações de leitura de arquivos não travem a interface.

- **Gerenciamento de Estado**  
  O método `setState()` é chamado sempre que há uma alteração que deve ser refletida na interface, como ao sortear uma música ou carregar o JSON.

- **Widgets**  
  Elementos visuais do Flutter, como botões, textos e layouts, são usados para criar uma interface intuitiva e responsiva.

- **Integração com APIs Externas**  
  O app utiliza o pacote `url_launcher` para abrir links externos (Spotify) e pode usar o pacote `shake` para detectar movimentos do dispositivo.

---

### Resumo

O arquivo `main.dart` integra a lógica de sorteio, leitura de dados, exibição das informações e interação com o Spotify, proporcionando uma experiência completa e interativa ao usuário.
---

## Licença

Este projeto é apenas para fins educacionais