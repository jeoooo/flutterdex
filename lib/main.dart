import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // Use a Builder here to get the correct context
          leading: Builder(
            builder: (BuildContext appBarContext) {
              return IconButton(
                onPressed: () {
                  // Open the drawer using the context from the AppBar
                  Scaffold.of(appBarContext).openDrawer();
                },
                icon: const Icon(Icons.menu),
              );
            },
          ),
          title: const Text('FlutterDex'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                // Search bar
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                  height: 50,
                  width: 400,
                  child: const SearchPokemon(),
                ),
                // Card container
                const CardContainer(),
              ],
            ),
          ],
        ),
        drawer: const NavigationDrawer(),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Drawer contents go here
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Handle the item 1 tap
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Handle the item 2 tap
            },
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Open the drawer when the menu icon is tapped
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: const Text('FlutterDex'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              // Search bar
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                height: 50,
                width: 400,
                child: const SearchPokemon(),
              ),
              // Card container
              const CardContainer(),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        // Drawer contents go here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle the item 1 tap
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle the item 2 tap
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
    ),
  );
}

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({
    super.key,
  });

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {
  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      hintText: 'Search Pokemon',
      hintStyle:
          MaterialStatePropertyAll(TextStyle(color: Colors.grey, fontSize: 18)),
      side: MaterialStatePropertyAll(BorderSide(color: Colors.black)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)))),
      backgroundColor:
          MaterialStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
      leading: Padding(
        padding:
            EdgeInsets.only(left: 10.0), // Adjust the left margin as needed
        child: Icon(Icons.search),
      ),
    );
  }
}

class CardContainer extends StatefulWidget {
  const CardContainer({
    super.key,
  });

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 14.0, 0, 0),
      // color: const Color.fromARGB(255, 255, 68, 168),
      height: 700,
      width: 400,
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PokemonCard(),
          ],
        ),
      ),
    );
  }
}

class PokemonCard extends StatefulWidget {
  const PokemonCard({
    super.key,
  });

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          // color: const Color.fromARGB(255, 30, 255, 0),
          height: 120,
          width: 400,
          child: pokemonDetails(),
        ),
      ],
    );
  }

  Card pokemonDetails() {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  // color: Colors.deepPurple,
                  height: 40,
                  width: 250,
                  alignment: Alignment.center,
                  child: const Text(
                    '#000   PokemonName',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: SizedBox(
                    // color: Colors.lightBlueAccent,
                    height: 40,
                    width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // types
                        Row(
                          children: [
                            SizedBox(
                              // color: Colors.amberAccent,
                              height: 40,
                              width: 125,
                              child: Card(
                                color: Colors.redAccent,
                                child: Center(
                                    child: Text(
                                  'TYPE 2',
                                )),
                              ),
                            ),
                            SizedBox(
                              // color: Colors.blueAccent,
                              height: 40,
                              width: 125,
                              child: Card(
                                color: Colors.redAccent,
                                child: Center(
                                    child: Text(
                                  'TYPE 2',
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.indigoAccent,
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'pokemon image',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
