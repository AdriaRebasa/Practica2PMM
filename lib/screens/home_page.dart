import 'package:flutter/material.dart';
import 'package:practica2/models/persona.dart';
import 'personal_page.dart';
import 'widget_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Objecte Persona per mostrar i editar
  Persona persona = Persona(
    nom: "Adrià",
    cognom: "Rebasa",
    dataNaixement: DateTime(1999, 10, 22),
    correu: "adria.rebasa@gmail.com",
    contrasenya: "1234",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PF2 - Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Benvingut/da ${persona.nom} ${persona.cognom}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // Naveguem a la PersonalPage i esperem la Persona modificada
                final Persona? personaModificada = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalPage(persona: persona),
                  ),
                );

                // Si es retorna una Persona, actualitzam l'estat
                if (personaModificada != null) {
                  setState(() {
                    persona = personaModificada;
                  });
                }
              },
              child: const Text("Anar a la PersonalPage"),
            ),
            //boto per anar a la WidgetPage
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WidgetPage(),
                  ),
                );
              },
              child: const Text("Anar a la WidgetPage"),
            ),
          ],
        ),
      ),
    );
  }
}
