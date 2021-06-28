# Instasend

An online delivery app.

## Architecture

The project uses MVVM Architecture with the help of `provider` and `get_it` packages. The `provider` package acts as the view model where the views are listened to. The `get_it` package provides singleton repositories to be used within view models.

## Folder Structure
 - `models/` - Contains all the plain data classes used by the view model.
 - `repositories/` - Single source of truth (data). Consists of firebase helper classes.
 - `services/` - Contains services that should be available to the whole app. These services make some flutter utilities easier to use such as navigation, dialog, etc.
 - `ui/` - All Flutter screens, widgets, and other UI related.
 - `utils/` - Themes, static function, constant variables and other helper clases.


### Notes
 - I broke some MVVM rule here where the Views should not directly interact with the Models. I did so by requiring to pass a model to some deeply-nested widget to read data.  To be fair Flutter makes it hard to implement MVVM stuff.