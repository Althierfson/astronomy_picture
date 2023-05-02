# Astronomy Picture

Explore o universo com o nosso app! A cada dia uma nova imagem incrível do espaço, informações detalhadas e curiosidades da NASA na palma da sua mão.

Nesse APP que se comunica com a API [Apod](https://api.nasa.gov/) da nasa você pode ver qual a imagem do espaço a Nasa esta destacando, pode ver seu título, descrição e curiosidades sobre a imagem.

Você também pode ver imagens aleatórias e, caso queira, pode ver qual era a imagem em destaque de um dia especifico.

## Sobre esse projeto (Técnico)

Este projeto é um exemplo de aplicação em Flutter que utiliza técnicas de TDD (Desenvolvimento Orientado a Testes) e a arquitetura Clean Architecture, que permite separar as camadas de negócio, aplicação e infraestrutura. Além disso, o projeto faz uso do padrão Bloc para gerenciamento de estado e consumo de APIs externas.

Tecnologias utilizadas
- Flutter
- Dart
- TDD (Test Driven Development)
- Clean Architecture
- Bloc
- API REST

## Funcionalidades
O aplicativo é capaz de:

- Exibir imagem ou vídeo do dia e sua descrição vindo da API APOD;
- Exibir imagens ou vídeos aleatorios com suas descrições vindo da API APOD;
- Exibir imagens ou vídeos e suas descrições baseados em um dia especifico vindo da API APOD;
- Exibir notificações diárias convidando o usuário a visitar o APP

## Como executar
1. Clone o repositório;
2. Abra o terminal na pasta do projeto e execute o comando ```flutter pub get``` para instalar as dependências;
3. Execute a aplicação com o comando ```flutter run```.

## Estrutura do projeto
O projeto segue a seguinte estrutura:

- lib: diretório principal do projeto;
  - core: diretorio com Funções e features gerais
  - features: Camada com todas as features do projeto
    - data: camada de infraestrutura, onde estão as classes de repositório e o serviço de API;
    - domain: camada de domínio, onde estão as entidades, regras de negócio e interfaces de repositório;
    - presentation: camada de aplicação, onde estão as classes de apresentação, views e blocos.

## Testes
O projeto segue uma abordagem de TDD, com testes unitários e integrados em todas as camadas. Os testes podem ser encontrados no diretório test.

## Autor
Althierfson Tullio

## Licença
Este projeto está licenciado sob a licença MIT. Consulte o arquivo LICENSE para obter mais informações.
