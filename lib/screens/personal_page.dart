import 'package:flutter/material.dart';
import 'package:practica2/models/persona.dart';

class PersonalPage extends StatefulWidget {
  final Persona persona;

  const PersonalPage({super.key, required this.persona});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late TextEditingController _nomController;
  late TextEditingController _cognomController;
  late TextEditingController _dataNaixementController;
  late TextEditingController _correuController;
  late TextEditingController _contrasenyaController;
  DateTime? _dataSeleccionada;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.persona.nom);
    _cognomController = TextEditingController(text: widget.persona.cognom);
    _dataNaixementController = TextEditingController(
      text: widget.persona.dataNaixement.toIso8601String().split('T')[0],
    );
    _correuController = TextEditingController(text: widget.persona.correu);
    _contrasenyaController = TextEditingController(text: widget.persona.contrasenya);
    _dataSeleccionada = widget.persona.dataNaixement;
  }

  @override
  void dispose() {
    _nomController.dispose();
    _cognomController.dispose();
    _dataNaixementController.dispose();
    _correuController.dispose();
    _contrasenyaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Page de ${widget.persona.cognom}")),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _crearNom(),
          const Divider(),
          _crearCognom(),
          const Divider(),
          _crearDataNaixement(context),
          const Divider(),
          _crearCorreu(),
          const Divider(),
          _crearContrasenya(),
          const SizedBox(height: 30),
          _crearBotoDesar(),
        ],
      ),
    );
  }

  Widget _crearNom() {
    return TextField(
      controller: _nomController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        counterText: 'Lletres: ${_nomController.text.length}',
        hintText: 'Nom',
        labelText: 'Nom',
        helperText: 'Introdueix el teu nom',
        suffixIcon: const Icon(Icons.person),
        icon: const Icon(Icons.account_circle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _crearCognom() {
    return TextField(
      controller: _cognomController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'Cognom',
        labelText: 'Cognom',
        suffixIcon: const Icon(Icons.badge),
        icon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget _crearDataNaixement(BuildContext context) {
    return TextField(
      controller: _dataNaixementController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Data de naixement',
        labelText: 'Data de naixement',
        suffixIcon: const Icon(Icons.calendar_today),
        icon: const Icon(Icons.date_range),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onTap: () => _seleccionaData(context),
    );
  }

  Future<void> _seleccionaData(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSeleccionada ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ca', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _dataSeleccionada = picked;
        _dataNaixementController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  Widget _crearCorreu() {
    return TextField(
      controller: _correuController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Correu electrònic',
        labelText: 'Correu electrònic',
        suffixIcon: const Icon(Icons.alternate_email),
        icon: const Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget _crearContrasenya() {
    return TextField(
      controller: _contrasenyaController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contrasenya',
        labelText: 'Contrasenya',
        suffixIcon: const Icon(Icons.lock_open),
        icon: const Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget _crearBotoDesar() {
    return ElevatedButton.icon(
      onPressed: _desaCanvis,
      icon: const Icon(Icons.save),
      label: const Text("Desa"),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  void _desaCanvis() {
    final personaModificada = Persona(
      nom: _nomController.text,
      cognom: _cognomController.text,
      dataNaixement: _dataSeleccionada ?? DateTime.now(),
      correu: _correuController.text,
      contrasenya: _contrasenyaController.text,
    );

    Navigator.pop(context, personaModificada);
  }
}
