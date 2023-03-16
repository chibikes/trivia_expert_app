# trivia_expert_app

A single-player trivia application written in flutter

![trivia_app](https://user-images.githubusercontent.com/53054854/192139109-bf19805d-244b-42b8-b52e-9054a15304a3.gif)

## Getting Started 

This app uses bloc state management pattern https://github.com/felangel/bloc and uses best pattern practices.

For more on best practices using bloc state management solution visit 
https://verygood.ventures/blog/very-good-flutter-architecture

## Firebase setup
This app uses flutterfire cli, which makes it easier to configure firebase for both mobile and ios.

To get started first install firebase cli using npm:
```bash
npm install -g firebase-tools 
```
npm is a nodejs package installer. If you don't have npm visit https://nodejs.org/en/download/

After downloading firebase cli follow the instructions at https://firebase.google.com/docs/cli to login to your firebase account using the cli

Run the following command from any directory to install flutterfire cli:
```bash
dart pub global activate flutterfire_cli
```
To set up firebase for your app run the following command on your terminal in your project's root directory:
```bash
flutterfire configure --project=<firebase-project-id>
```
note: your project-id is the project's id when you setup firebase for this project. you can omit the --project parameter and flutterfire will create a new firebase project for you.

## Run app
In your terminal, in your project's root directory, execute the follwing command:
```bash
flutter run
```
