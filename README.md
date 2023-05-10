# Astronomy Picture

Explore the universe with our app! Every day a new incredible image of space, detailed information and curiosities of NASA in the palm of your hand.

In this APP that communicates with NASA's [Apod](https://api.nasa.gov/) API, you can see which image of space NASA is highlighting, you can see its title, description and curiosities about the image.

You can also see random images and, if you want, you can see which were the featured images of a specific day or period.

<div align="center">
  <img src="https://user-images.githubusercontent.com/42945474/236709001-4cecff40-ad36-4557-bd11-78305429daad.jpg", width="250px"/>
  <img src="https://user-images.githubusercontent.com/42945474/236709088-b196bcee-e0b8-42c5-b0ac-3297f1b8bdd1.jpg", width="250px"/>
  <img src="https://user-images.githubusercontent.com/42945474/236709130-4cc5631b-60d6-4a07-b54f-3a11a74b56fa.jpg", width="250px"/>
  <img src="https://user-images.githubusercontent.com/42945474/236709156-e23d03d7-b00f-43fa-9ef5-ff0adf7ebbd3.jpg", width="250px"/>
  <img src="https://user-images.githubusercontent.com/42945474/236709169-e1f29a49-3b81-4f7c-aa29-5d985257d59e.jpg", width="250px"/>
</div>

## Acesse o APP
Play Store link: [Astronomy Picture](https://play.google.com/store/apps/details?id=com.cajuapps.astronomy_picture)

## About this project (Technical)

This project is an example of an application in Flutter that uses TDD (Test Driven Development) and Clean Architecture techniques, which allows separating the layers of business, application and infrastructure. In addition, the project makes use of the Bloc pattern for state management and consumption of external APIs.

Technologies used:
- Flutter
- Dart
- TDD (Test Driven Development)
- Clean Architecture
- Bloc
- API REST


## Functionalities
The APP is able of:

- Show the featured image or video with its description
- Show random images and videos in an infinite scroll view;
- Allow the user to search for specific content based on a day or period;
- Show daily notification inviting user to visit APP;
- Allow the user to save locally the content he likes;

## how to run
1. Clone the repository;

2. Nasa API Key:

      Before running you need to configure your own key in the '/environment.dart' file in the '/lib/' directory
      This file must contain a String with your NASA API access key
      See this link on [NASA API](https://api.nasa.gov/) to generate your key

3. Open the terminal in the project folder and run the command ```flutter pub get``` to install the dependencies;
4. Run the application with the command ```flutter run```.

## Project Structure
The project has the following structure:

- lib: main directory;
  - core: directory with genral features
  - features: directory with all project features, all with:
    - data: infrastructure layer, with all repositories classes and API service;
    - domain: domínio layer, with all entities, business rules, and repositories interface;
    - presentation: application layer, with all presentations classes, views and blocs;

## Tests
The project follows a TDD approach, with unit tests in all layers. Tests can be found in the test directory.

## Current Limitations
Esse projeto foi configurado e unicamente testado em ambientes android.

## Author
Althierfson Tullio

## License
This project is licensed under the MIT license. See the LICENSE file for more information.

## Informações Importantes
This app is a platform that uses NASA's APOD API to display amazing images and videos from outer space.

It is important to emphasize that NASA has no relationship with the application, since the information is provided openly and freely for anyone who wants to access it through the API.

The application seeks to organize and provide an easy way to access this data, so that users can explore and be delighted with what the space has to offer.

We emphasize that some images and videos may be subject to copyright, so it is important to consult the rights of use before using any content found in the application.

For more information on NASA's APOD API, visit https://api.nasa.gov/."
