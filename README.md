# Demonstration du Dej'Tech Flutter

Construisez étape par étape une application.

Ressources utilisées :
- https://github.com/lesnitsky/todolist_flutter/blob/master/README.md
- https://flutter.dev/docs/cookbook/animation/animated-container#3-start-the-animation-by-rebuilding-with-new-properties

> Vous pouvez utiliser les commits de ce repository pour avoir accès aux
> fichiers, et vérifier que tout s'est bien passé, étape par étape.

> N'hésitez pas à créér une issue ou a faire un pull request si vous
> voyez une erreur dans ce tutoriel.

## Sommaire

0. Pré-requis
1. Initialisation
2. Importation de widgets
3. Mise en place de routes
4. Todo List
5. Refactoring de la Todo List
6. Animation de container

## Etape 0 : Pre-Requis

Avant de pouvoir démarrer sur Flutter, il faut l'installer.

Rendez-vous sur
[le site de Flutter](https://flutter.dev/docs/get-started/install) et
suivez le guide jusqu'à la fin de l'étape `Test Drive` pour vous assurer
que l'installation est bien réussie.

## Etape 1 : Initialisation

Pour cette première étape, nous allons créer un nouveau projet Flutter.

En ligne de commandes :

```sh
flutter create demo_app
```
Après l'installation, ouvrez le fichier `main`, nous allons l'étudier un
petit peu.

📄 lib/main.dart
```diff
+ import 'package:flutter/material.dart';
```
Cette ligne fait l'import de la librairie `material` fournie par
Flutter. Cette librairie implémente divers composants ayant un style
"Material Design".

📄 lib/main.dart
```diff
  import 'package:flutter/material.dart';
+
+ void main() => runApp(MyApp());
```

Cette fonction est le point d'entrée d'une application Flutter. Il
appelle simplement `runApp` mais on peut faire plus au sein de cette
fonction (comme passer en plein écran, bloquer l'affichage au mode
portrait...). 

📄 lib/main.dart
```diff
  void main() => runApp(MyApp());
+
+ class MyApp extends StatelessWidget {}
```
En Flutter, tous les composants sont appelés `widget`. Ils peuvent être
soit `stateless` (affichage simple) ou `stateful` (conteneur pour gérer
des états). Le composant au premier niveau d'une application devrait
toujours être un composant stateless. 

Chaque widget doit surcharger la function build. Elle retourne la
hiérarchie de la disposition des widgets (le layout) (`Container`,
`Padding`, `Flex`, etc). La logique métier doit être contenu dans des
widgets stateful.

[En savoir plus](https://www.didierboelens.com/fr/2018/06/widget---state---context---inheritedwidget/)

📄 lib/main.dart
```diff
  void main() => runApp(MyApp());

- class MyApp extends StatelessWidget {}
+ class MyApp extends StatelessWidget {
+   @override
+   Widget build(BuildContext context) {
+     return Container();
+   }
+ }
```
Dans le cas du composant de premier niveau "App", le build doit
retourner soit un `CupertinoApp`, soit un `MaterialApp`. Dans notre cas,
un [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html) . 

>Vous pouvez accéder à la documentation des widgets utilisés en faisant
>un `CTRL+B` après avoir placé votre curseur sur le widget en question.

📄 lib/main.dart
```diff
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
-     return Container();
+     return MaterialApp();
    }
  }
```
Le reste de l'application de base Flutter vous détaille ce que font les
différents éléments.

Il est temps de lancer notre application, alors crééz ou lancez un
émulateur (ou connectez votre propre device en mode développeur) et
lancer un Build (Si vous avez suivi l'étape 0, vous devriez déjà
l'avoir fait).

On va utiliser le Hot Reload. Pour cela, modifier la ligne suivante

📄 lib/main.dart
```diff
        primarySwatch: Colors.blue,
      ),
-      home: MyHomePage(title: 'Flutter Demo Home Page'),
+      home: MyHomePage(title: 'Démo Hot Reload'),
    );
  }
}
```

Pour voir les modifications, il faut soit cliquer sur l'onglet Hot
Reload (l'icone en forme d'éclair), soit invoquer `save all` (CTRL+S par
défaut)

## Etape 2 : Importation de widgets, packages etc...

Le fichier main.dart contient actuellement à la fois l'app et le widget
`home_page`. On va séparer un peu tout ça. 

Pour cela on va d'abord créer un fichier `home_page.dart` dans le
dossier `lib`. Puis on va déplacer les 2 classes MyHomePage et
MyHomePageState dans ce nouveau fichier.

📄 lib/home_page.dart
```diff
+ class MyHomePage extends StatefulWidget { MyHomePage({Key key, this.title}) : super(key: key);
+   final String title;

+   @override
+   _MyHomePageState createState() => _MyHomePageState();
+ }

+ class _MyHomePageState extends State<MyHomePage> {
+   int _counter = 0;
+ 
+   void _incrementCounter() {
    ...
```

On a désormais une erreur dans le main

📄 lib/main.dart
```diff
        primarySwatch: Colors.blue,
      ),
-      home: MyHomePage(title: 'Démo Hot Reload'),
    );
  }
}
```

2 solutions s'offrent à nous :
1. Positionner son curseur sur `MyHomePage`
puis faire `ALT+ENTREE` et choisir `import library
'package:nom_app/home_page.dart` 
2. Entrer manuellement la ligne `import
   'package:nom_app/home_page.dart';` en haut du fichier main.dart

Un petit coup de `Hot Reload` et le tour est joué !

De cette manière, on peut importer des widgets ou des packages.

> Il est important de noter qu'il est préférable d'utiliser la notation
> `package:url/vers/le/fichier.dart` plutôt que d'utiliser des chemins
> relatifs, même si celle-ci peut être plus longue à taper lors d'un
> import manuel.

## Etape 3 : Mise en place de routes

Pour mettre en place une navigation, on va avoir besoin d'au moins 2
pages. On va donc créer un fichier `splash_screen.dart`. On va y mettre
un logo Flutter tout simple.

📄 lib/splash_screen.dart
```diff
+ import 'package:flutter/material.dart';
+ 
+ class SplashScreen extends StatelessWidget {
+   @override
+   Widget build(BuildContext context) {
+     return Scaffold(
+       body: Center(
+         child: FlutterLogo(
+           size: 400,
+         ),
+       ),
+     );
+   }
+ }
```

📄 lib/main.dart
```
        primarySwatch: Colors.blue,
      ),
-      home: MyHomePage(title: 'Démo Hot Reload'),
+      home: SplashScreen(),
    );
  }
}
```
On oublie pas de faire l'import du widget et de faire un hot reload ! On
à désormais un joli logo Flutter. (On peut également enlever la
propriété `size` ou jouer avec pour voir les changements.)

On a un joli logo, mais toujours pas de navigation ! Pour pouvoir passer
d'une route à une autre, il va nous falloir un bouton.

📄 lib/splash_screen.dart
```diff
    return Scaffold(
      body: Center(
-       child: FlutterLogo(
+       child: Column(
+         mainAxisAlignment: MainAxisAlignment.center,
+         children: <Widget>[
+           FlutterLogo(
              size: 400,
            ),
+           RaisedButton(
+             child: Text("Prochain écran"),
+           ),
+         ],
+       ),
      ),
    );
```
On a une erreur avec notre `RaisedButton` : la propriété `onPressed` est
obligatoire. Mais on a rien à lui faire faire. Il va falloir modifier un
petit peu le main pour utiliser des routes nommées.

📄 lib/main.dart
```
        primarySwatch: Colors.blue,
      ),
-      home: SplashScreen(),
+      initialRoute: "/",
+      routes: {
+        "/": (context) => SplashScreen(),
+        "/home": (context) => MyHomePage(title: "Démo Hot Reload !"),
+      },
    );
  }
}
```
> Cette étape nécéssite de faire un `Hot Restart` plutôt qu'un `Hot
> Reload`. `MAJ+F10` par défaut.
> [Plus d'explications](https://flutter.dev/docs/development/tools/android-studio#hot-reload-vs-hot-restart)

`MaterialApp` a besoin soit d'un `home`, soit d'un `initialRoute &
routes`. 

`initialRoute` indique quelle route sera affichée au lancement de
l'application (équivalent de "home" lorsqu'on utilise des routes).

`routes` indique quelles routes nous allons mettre en place dans notre
application, et quelle widget y sera associée.

Ici on démarrera donc du SplashScreen pour se diriger sur la page
d'accueil.

On va pouvoir modifier le `RaisedButton` !

📄 lib/splash_screen.dart
```diff
              FlutterLogo(
                size: 400,
              ),
              RaisedButton(
+               onPressed: () {
+                 Navigator.of(context).pushNamed("/home"); // On ajoute "/home" à la pile de routes
+               },
                child: Text("Prochain écran"),
              ),
```
On utilise le Navigator, mis à disposition par `MaterialApp` et transmis
par le `BuildContext` pour ajouter une route à la pile des routes
traversées. Pour comprendre un peu mieux le fonctionnement des routes et
les différentes méthodes associées :
[Article sympa](https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31)

Faites un hot reload, puis cliquer sur le bouton... Vous voici sur la
page d'accueil de tout à l'heure !

## Etape 4 : Todo list

Maintenant qu'on à vu comment naviguer dans une application Flutter, on
va apprendre à utiliser les widgets `Stateful` grâce à une todo list.

On va ajouter une nouvelle route au main.

📄 lib/main.dart
```diff
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/home": (context) => MyHomePage(title: "Démo Hot Reload !"),
+       "/list": (context) => TodoList(),
      },
    );
```

📄 lib/splash_screen.dart
```diff
RaisedButton(
  onPressed: () {
+    Navigator.of(context).pushNamed("/list");
  },
  child: Text("Prochain écran"),
),
```
Le widget `TodoList` n'existe pas encore, crééons-le ensemble !

📄 lib/todo_list.dart
```diff
+ import 'package:flutter/material.dart';
+ 
+ class TodoList extends StatefulWidget {
+   @override
+   _TodoListState createState() => _TodoListState();
+ }
+ 
+ class _TodoListState extends State<TodoList> {
+   @override
+   Widget build(BuildContext context) {
+     return Scaffold(
+       appBar: AppBar(title: Text('Todo List')),
+       body: Container(),
+     );
+   }
+ }
```
On peut désormais importer ce widget dans le `main.dart`.

On va maintenant décrire l’entité “todo” qui correspondra à une
Checkbox. Un `todo` a un titre, et un boolean (fait ou pas fait)

📄 lib/todo.dart
```diff
+ class Todo {
+   Todo({this.title, this.isDone = false});
+ 
+   String title;
+   bool isDone;
+ }
```
On va ajouter une liste de Todo à notre TodoList:

📄 lib/todo_list.dart
```diff
  }

  class _TodoListState extends State<TodoList> {
+   List<Todo> todos = [];
+
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
```

Pour afficher notre liste de todo, on va utiliser le widget `ListView` 

📄 lib/todo_list.dart
```diff
  class _TodoListState extends State<TodoList> {
    List<Todo> todos = [];

+   _buildItem() {}
+
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
-       body: Container(),
+       body: ListView.builder(
+         itemBuilder: _buildItem,
+         itemCount: todos.length,
+       ),
      );
    }
  }
```
`itemBuilder` va appeler `_buildItem` a chaque fois qu’on va vouloir
faire un rendu de Todo. On va l’implementer en utilisant
`CheckboxListTile` parce que ça convient très bien : une checkbox qui
nous dit si la todo est complétée et un titre.

📄 lib/todo_list.dart
```diff
  class _TodoListState extends State<TodoList> {
    List<Todo> todos = [];

-   _buildItem() {}
+   Widget _buildItem(BuildContext context, int index) {
+     final todo = todos[index];
+
+     return CheckboxListTile(
+     );
+   }

    @override
    Widget build(BuildContext context) {
```
La propriété de ChekboxListTile: `value` indique si l’item de la liste
doit etre checké ou non. 

`title` est un widget qui sera rendu dans la
premiere ligne de la CheckboxListTile. En général c’est un “Text”.
 
Enfin, on va gérer les "tap" grâce au `onChanged`.

📄 lib/todo_list.dart
```diff
      return CheckboxListTile(
+       value: todo.isDone,
+       title: Text(todo.title),
+       onChanged: (bool isChecked) {
+         _toggleTodo(todo, isChecked);
+       },
      );
    }
```
L'implémentation de _toggleTodo est assez simple.

📄 lib/todo_list.dart
```diff
  class _TodoListState extends State<TodoList> {
    List<Todo> todos = [];

+   _toggleTodo(Todo todo, bool isChecked) {
+     todo.isDone = isChecked;
+   }
+
    Widget _buildItem(BuildContext context, int index) {
      final todo = todos[index];
```
On va ajouter des valeurs "examples" pour voir si ça affiche bien.

📄 lib/todo_list.dart
```diff
  class _TodoListState extends State<TodoList> {
-   List<Todo> todos = [];
+   List<Todo> todos = [
+     Todo(title: 'Learn Dart'),
+     Todo(title: 'Try Flutter'),
+     Todo(title: 'Be amazed'),
+   ];

    _toggleTodo(Todo todo, bool isChecked) {
      todo.isDone = isChecked;
```
Normalement, vous devriez voir les 3 tuiles avec checkbox. Sauf que
quand on tape dessus, il ne se passe rien :(

On va ajouter un `print` pour débuguer et voir si le eventHandler pour
est bien appelé.

📄 lib/todo_list.dart
```diff
    _toggleTodo(Todo todo, bool isChecked) {
+     print('${todo.title} ${todo.isDone}');
      todo.isDone = isChecked;
    }
```
La console nous affiche que les items sont bien cochés, puisque
`isChecked` est true, mais la checkbox n’est jamais affichée !
 
Le problème, c’est qu’on modifie l’entité Todo, mais Flutter n’a aucune
idée de ce qui s’est passé. En fait, c’est parce qu’il faut appeler `
setState` (coucou les fans de React ! 😏).
 
C'est pour cela qu'on à besoin d’un statefulWidget.

📄 lib/todo_list.dart
```diff
    _toggleTodo(Todo todo, bool isChecked) {
-     print('${todo.title} ${todo.isDone}');
-     todo.isDone = isChecked;
+     setState(() {
+       todo.isDone = isChecked;
+     });
    }
```
On peut maintenant que voir que le rendu s'effectue correctement au tap
sur une tuile !

Il est temps de se débarrasser des valeurs par défaut et d'ajouter de
quoi faire nous-mêmes des nouveaux todos.

Pour cela, on va utiliser le `FloatingActionButton` du Scaffold.

📄 lib/todo_list.dart
```diff
        return Scaffold(
          appBar: AppBar(title: Text('Todo List')),
          body: ListView.builder(
        	    itemBuilder: _buildItem,
        	    itemCount: todos.length,
      	  ),
+         floatingActionButton: FloatingActionButton(
+           child: Icon(Icons.add),
+           onPressed: () {
+             // ?
+           },
+         ),
        );
      );
    }
```
```diff
  class _TodoListState extends State<TodoList> {
-   List<Todo> todos = [
-     Todo(title: 'Learn Dart'),
-     Todo(title: 'Try Flutter'),
-     Todo(title: 'Be amazed'),
-   ];
+   List<Todo> todos = [];

    _toggleTodo(Todo todo, bool isChecked) {
```

Que doit-on mettre dans le `onPressed` ?

On va appler une méthode `_addTodo`.

📄 lib/todo_list.dart
```diff
      );
    }

+   _addTodo() {}
+
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
        body: ListView.builder(
        	  itemBuilder: _buildItem,
        	  itemCount: todos.length,
      	),
+       floatingActionButton: FloatingActionButton(
+         child: Icon(Icons.add),
+         onPressed: _addTodo,
+       ),
      );
    }
  }
```

Maintenant on va pouvoir afficher un `Dialog` quand l'utilisateur tape
sur le `FloatingActionButton`

📄 lib/todo_list.dart
```diff
      );
    }

-   _addTodo() {}
+   _addTodo() {
+     showDialog(
+       context: context,
+       builder: (BuildContext context) {
+         return AlertDialog(
+           title: Text('New todo'),
+         );
+       },
+     );
+   }

    @override
    Widget build(BuildContext context) {
```
Le Dialog va contenir un "text input" et 2 boutons d'action : "Annuler"
et "Ajouter".

📄 lib/todo_list.dart
```diff
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New todo'),
+           content: TextField(),
+           actions: <Widget>[
+             FlatButton(
+               child: Text('Annuler'),
+             ),
+             FlatButton(
+               child: Text('Ajouter'),
+             ),
+           ],
          );
        },
      );
```
Les Dialogs ne sont pas juste des overlays, en fait ils sont aussi des
routes. Donc pour gérer le retour, on va appeler la méthode .pop() du
`Navigator` du `context`

📄 lib/todo_list.dart
```diff
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
+               onPressed: () {
+                 Navigator.of(context).pop();
+               },
              ),
              FlatButton(
                child: Text('Add'),
```
On a besoin d’accéder à la valeur du `TextField` pour créer un `Todo`. On
va avoir besoin d’un `TextEditingController` pour ça.

📄 lib/todo_list.dart
```diff
  class _TodoListState extends State<TodoList> {
    List<Todo> todos = [];

+   TextEditingController controller = new TextEditingController();
+
    _toggleTodo(Todo todo, bool isChecked) {
      setState(() {
```
On va ensuite le fournir au `TextField`

📄 lib/todo_list.dart
```diff
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New todo'),
-           content: TextField(),
+           content: TextField(controller: controller),
            actions: <Widget>[
              FlatButton(
```
Maintenant dans le `onPressed` de l'action d'ajout, on peut logger la
valeur du `TextField` et la vider.

📄 lib/todo_list.dart
```diff
              ),
              FlatButton(
                child: Text('Add'),
+               onPressed: () {
+                 print(controller.value.text);
+                 controller.clear();
+               },
              ),
            ],
          );
```
Enfin, on va créer les todos, et les ajouter à notre liste de todo. (on le fait dans le setState)

📄 lib/todo_list.dart
```diff
              FlatButton(
                child: Text('Add'),
                onPressed: () {
-                 print(controller.value.text);
-                 controller.clear();
+                 setState(() {
+                   final todo = new Todo(title: controller.value.text);
+
+                   todos.add(todo);
+                   controller.clear();
+
+                   Navigator.of(context).pop();
+                 });
                },
```
On peut meme améliorer l’UX en faisant en sorte que le clavier “pop”
directement : on utilise `autofocus: true` dans le TextField.

📄 lib/todo_list.dart
```diff
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New todo'),
-           content: TextField(controller: controller),
+           content: TextField(
+             controller: controller,
+             autofocus: true,
+           ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
```
Et voila ! Une todo list fonctionnelle.

## Etape 5 : Conteneur animé

On va préparer le terrain avant d'utiliser les `AnimatedContainer`. On va directement afficher notre nouvelle page au lancement de
l'application à la place du SplashScreen.

📄 lib/main.dart
```diff
      initialRoute: "/",
      routes: {
-       "/": (context) => SplashScreen(),
+       "/": (context) => AnimatedContainerPage(),
        "/home": (context) => MyHomePage(title: "Démo Hot Reload !"),
        "/list": (context) => TodoListScreen(),
      },
    );
```
On va aussi mettre en place cette page, en mettant un scaffold en place.
(Largement inspiré de celui présent dans home_page.dart)

📄 lib/animated_container.dart
```diff
import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Container Demo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            tooltip: "Page suivante",
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            tooltip: "Playons",
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
```
On a une page avec une `appBar` qui contient 2 boutons, un pour aller à
la page d'accueil (celle où l'on se situe) et un bouton pour aller à la
page suivante. 

`Navigator.pushNamed(context, /URL);` est simplement une
autre notation pour changer de route, le fonctionnement est identique.

La prochaine étape consiste à instantier des valeurs par défaut dans
notre `Stateful` widget.

Ces variables vont être instantiées dans la classe `State` et on pourra
les modifier ensuite.

Ici, on va inclure `width` `height` `color` `borderRadius`.

📄 lib/animated_container.dart
```diff
class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
+ // Define the various properties with default values. Update these properties
+ // when the user taps a FloatingActionButton.
+ double _width = 50;
+ double _height = 50;
+ Color _color = Colors.green;
+ BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
```

La seconde étape consiste à créer un `AnimatedContainer` qui va utiliser
les propriétés qu'on a mis en place juste au dessus. Un
AnimatedContainer est un `Container` qui pourra utiliser des animations
lorsqu'il sera modifié.

On va aussi lui donner une `duration` qui va définir le temps que met
l'animation pour s'effectuer, ainsi que `curve` (optionnerl), qui va
définir la courbe de l'animation.
[Doc sur les courbes](https://api.flutter.dev/flutter/animation/Curves-class.html)

📄 lib/animated_container.dart
```diff
        ],
      ),
-      body: Container(),
+      body: Center(
+        child: AnimatedContainer(
+          width: _width,
+          height: _height,
+          decoration: BoxDecoration(
+            color: _color,
+            borderRadius: _borderRadius,
+          ),
+          // Define how long the animation should take.
+          duration: Duration(seconds: 1),
+          // Provide an optional curve to make the animation feel smoother.
+          curve: Curves.fastOutSlowIn, // démarre vite, fini lentement
+        ),
+      ),
    );
  }
}
```
Enfin, on va pouvoir animer ce `AnimatedContainer` en rebuildant
l'application avec de nouvelles propriétés. (Avec `setState`)

Pour ce faire, on va ajouter un bouton à notre page, quand on va taper
le bouton, on va modifier aléatoirement les propriétés définis plus
haut, dans un `setState`.

En général, on transitionne entre des valeurs fixes. (Par exemple, d’un
background gris à vert). pour cette démo, on va générer des valeurs
aléatoires à chaque fois.

📄 lib/animated_container.dart 
```diff
      body: Center(
        ...
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        // Action au tap de l'utilisateur
        onPressed: () {
          // Utilisation de setState pour rebuild le widget avec de nouvelles valeurs
          setState(() {
            // Création d'un générateur de nombre aléatoire
            final random = Random();

            // random width and height
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            // random color
            _color = Color.fromRGBO(
              random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1
            );

            // random border
            _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}
```
Et voila, désormais, lorsque vous cliquez sur le bouton "play" de la
page, le conteneur s'anime lors du changement de valeurs !


## Pour aller plus loin, Etape 4.5 : Refactoring de la todo list

Depuis
[ce tutoriel](https://github.com/lesnitsky/todolist_flutter/blob/master/README.md)

`TodoList` is working, but `todo_list.dart` is kinda messy and hard to
read. The most complex method is `_addTodo`, so let's start with
rewriting it. It seems like we can move the `AlertDialog` to a separate
widget, but we can't do this right now, as we rely on `setState` from
parent widget. Instead we can pass a freshly created todo to a
`Navigator.pop`

📄 lib/todo_list.dart

```diff
    }

    _addTodo() {
-     showDialog(
+     showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              FlatButton(
                child: Text('Add'),
                onPressed: () {
-                 setState(() {
-                   final todo = new Todo(title: controller.value.text);
+                 final todo = new Todo(title: controller.value.text);
+                 controller.clear();

-                   todos.add(todo);
-                   controller.clear();
-
-                   Navigator.of(context).pop();
-                 });
+                 Navigator.of(context).pop(todo);
                },
              ),
            ],

```

In order to be able to receive the `Todo` in `_addTodo` method we need to make it `async` and `await` `showDialog` function result (which will be `null` in case it was dismissed and instance of `Todo` otherwise)

📄 lib/todo_list.dart

```diff
      );
    }

-   _addTodo() {
-     showDialog<Todo>(
+   _addTodo() async {
+     final todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

```

And move back the logic with state update

📄 lib/todo_list.dart

```diff
          );
        },
      );
+
+     if (todo != null) {
+       setState(() {
+         todos.add(todo);
+       });
+     }
    }

    @override

```

Now we don't have any dependencies on a parent widget, so we can extract `AlertDialog` to a separate widget

📄 lib/new_todo_dialog.dart

```dart
import 'package:flutter/material.dart';

import 'package:todo_list/todo.dart';

class NewTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            final todo = new Todo(title: controller.value.text);
            controller.clear();

            Navigator.of(context).pop(todo);
          },
        ),
      ],
    );
  }
}

```

and use it inside `TodoList`

📄 lib/todo_list.dart

```diff
  import 'package:flutter/material.dart';
  import 'package:todo_list/todo.dart';

+ import 'package:todo_list/new_todo_dialog.dart';
+
  class TodoList extends StatefulWidget {
    @override
    _TodoListState createState() => _TodoListState();
  class _TodoListState extends State<TodoList> {
    List<Todo> todos = [];

-   TextEditingController controller = new TextEditingController();
-
    _toggleTodo(Todo todo, bool isChecked) {
      setState(() {
        todo.isDone = isChecked;
      final todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
-         return AlertDialog(
-           title: Text('New todo'),
-           content: TextField(
-             controller: controller,
-             autofocus: true,
-           ),
-           actions: <Widget>[
-             FlatButton(
-               child: Text('Cancel'),
-               onPressed: () {
-                 Navigator.of(context).pop();
-               },
-             ),
-             FlatButton(
-               child: Text('Add'),
-               onPressed: () {
-                 final todo = new Todo(title: controller.value.text);
-                 controller.clear();
-
-                 Navigator.of(context).pop(todo);
-               },
-             ),
-           ],
-         );
+         return NewTodoDialog();
        },
      );


```

Next step – extract todo list component

List istself could also be treated as stateless widget, state related logic could be handled by parent

So let's first rename `TodoList` to `TodoListScreen`

📄 lib/todo_list.dart

```diff

  import 'package:todo_list/new_todo_dialog.dart';

- class TodoList extends StatefulWidget {
+ class TodoListScreen extends StatefulWidget {
    @override
-   _TodoListState createState() => _TodoListState();
+   _TodoListScreenState createState() => _TodoListScreenState();
  }

- class _TodoListState extends State<TodoList> {
+ class _TodoListScreenState extends State<TodoListScreen> {
    List<Todo> todos = [];

    _toggleTodo(Todo todo, bool isChecked) {

```

rename file

📄 lib/todo_list_screen.dart => lib/todo_list.dart

and fix import

📄 lib/main.dart

```diff
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';

- import 'package:todo_list/todo_list.dart';
+ import 'package:todo_list/todo_list_screen.dart';

  void main() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Todo List',
-       home: TodoList(),
+       home: TodoListScreen(),
      );
    }
  }

```

Let's move list related logic to a separate stateless widget

📄 lib/todo_list.dart

```dart
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];

    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}

```

and remove this logic from `TodoListScreen`

📄 lib/todo_list_screen.dart

```diff
  import 'package:todo_list/todo.dart';

  import 'package:todo_list/new_todo_dialog.dart';
+ import 'package:todo_list/todo_list.dart';

  class TodoListScreen extends StatefulWidget {
    @override
  class _TodoListScreenState extends State<TodoListScreen> {
    List<Todo> todos = [];

-   _toggleTodo(Todo todo, bool isChecked) {
-     setState(() {
-       todo.isDone = isChecked;
-     });
-   }
-
-   Widget _buildItem(BuildContext context, int index) {
-     final todo = todos[index];
-
-     return CheckboxListTile(
-       value: todo.isDone,
-       title: Text(todo.title),
-       onChanged: (bool isChecked) {
-         _toggleTodo(todo, isChecked);
-       },
-     );
-   }
-
    _addTodo() async {
      final todo = await showDialog<Todo>(
        context: context,
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
-       body: ListView.builder(
-         itemBuilder: _buildItem,
-         itemCount: todos.length,
-       ),
+       body: TodoList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addTodo,

```

Now let's review our `TodoList` widget

It is missing `Todo` class import

📄 lib/todo_list.dart

```diff
  import 'package:flutter/material.dart';

+ import 'package:todo_list/todo.dart';
+
  class TodoList extends StatelessWidget {
    _toggleTodo(Todo todo, bool isChecked) {
      setState(() {

```

It also doesn't have `todos`, so let's pass them from parent widget

📄 lib/todo_list.dart

```diff
  import 'package:todo_list/todo.dart';

  class TodoList extends StatelessWidget {
+   TodoList({@required this.todos});
+
+   final List<Todo> todos;
+
    _toggleTodo(Todo todo, bool isChecked) {
      setState(() {
        todo.isDone = isChecked;

```

📄 lib/todo_list_screen.dart

```diff
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Todo List')),
-       body: TodoList(),
+       body: TodoList(
+         todos: todos,
+       ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addTodo,

```

`_toggleTodo` method relies on `setState`, so let's move it back to parent

📄 lib/todo_list.dart

```diff

    final List<Todo> todos;

-   _toggleTodo(Todo todo, bool isChecked) {
-     setState(() {
-       todo.isDone = isChecked;
-     });
-   }
-
    Widget _buildItem(BuildContext context, int index) {
      final todo = todos[index];


```

📄 lib/todo_list_screen.dart

```diff
  class _TodoListScreenState extends State<TodoListScreen> {
    List<Todo> todos = [];

+   _toggleTodo(Todo todo, bool isChecked) {
+     setState(() {
+       todo.isDone = isChecked;
+     });
+   }
+
    _addTodo() async {
      final todo = await showDialog<Todo>(
        context: context,

```

and pass it down to `TodoList` as a property

📄 lib/todo_list.dart

```diff

  import 'package:todo_list/todo.dart';

+ typedef ToggleTodoCallback = void Function(Todo, bool);
+
  class TodoList extends StatelessWidget {
-   TodoList({@required this.todos});
+   TodoList({@required this.todos, this.onTodoToggle});

    final List<Todo> todos;
+   final ToggleTodoCallback onTodoToggle;

    Widget _buildItem(BuildContext context, int index) {
      final todo = todos[index];
        value: todo.isDone,
        title: Text(todo.title),
        onChanged: (bool isChecked) {
-         _toggleTodo(todo, isChecked);
+         onTodoToggle(todo, isChecked);
        },
      );
    }

```

📄 lib/todo_list_screen.dart

```diff
        appBar: AppBar(title: Text('Todo List')),
        body: TodoList(
          todos: todos,
+         onTodoToggle: _toggleTodo,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
```

## Little More

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
