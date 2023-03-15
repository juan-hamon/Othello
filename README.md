# Othello

This is an implementation of the Othello game, with some rules being modified from the original game.

- Diagonal movements are optional, you can activate them in the home page.
- The board has 8 columns and 8 rows by default, but you can change the dimensions in the home page (must be even).
- A piece can only be placed in a position where it's ensured that at least one opponent's piece is captured. Any other placement it's considered an invalid movement.
- The pieces only have one color, white or black (unlike the classic Othello, in which each piece has one color in each side). Because of this, a player can only place n/2 pieces on the board (being n = rows * columns).
- When  a player captures one or more pieces of the opposite color, they are returned to the opponent (allowing him to use them again), and are replaced on the board by pieces of the player's color.
- If after a player places more pieces than he has available, he is allowed to exceed the limit previously imposed until the opponent makes his/her move. After this, if the player continues to exceed the limit, the pieces on the board are counted and the player with more pieces wins the game.
- When a player has no more possible movements, he/she loses the game.

## Project configuration

### Download required dependencies

When you clone this project you will need to download the requiered dependencies using the following command:

```sh
flutter pub get
```
After that, you should be able to run the application without errors using your IDE or using the following command:
```sh
flutter run
```

### Possible problems with the AppLocalizations class

As this project allows to switch between english and spanish languages, it uses the AppLocalizations class provided by Flutter in order to add [Internationalization to the app](https://docs.flutter.dev/development/accessibility-and-localization/internationalization).

The AppLocalizations class is created in the  ***.dart_tool*** folder. However, some IDEs will show errors when you open the project because this folder does not exist until you run the app.

To solve this execute the following commands and the problem should be fixed:
```sh
flutter clean
flutter run
```
> Note: If after executing these commands the IDE stills shows errors, try restarting it, sometimes this is all it takes for the errors to go away.
## Project structure
| Folder | Objective |
| ------ | ------ |
| Config | Contains the main configuration files of the application: Internationalization values and the app routes. |
| Logic | Contains all the application logic: Entities, Controllers, Validators, etc.|
| Pages | Contains all the pages and their widgets.|
| Providers | Contains the objects responsable for the state management. |
| Utils | Contains generic classes and functions that are used throughout the application. |