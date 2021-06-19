# Instasend

An online delivery app.

## Architecture

The project uses MVVM Architecture with the help of `provider` and `get_it` packages. The `provider` package acts as the view model where the views are listened to. The `get_it` package provides singleton repositories to be used within view models.

## Folder Structure
 - `models/` - Containes all the plain data classes used by the view model.
 - `repositories/` - Single source of truth (data). Consists of firebase helper classes.
 - `ui/` - All Flutter screens, widgets, and other UI related.
 - `utils/` - Themes, static function, constant variables and other helper clases.


