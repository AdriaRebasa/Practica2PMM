import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  // Posicions de les caixes
  Offset posBox1 = const Offset(50, 50);
  Offset posBox2 = const Offset(200, 150);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InteractiveViewer"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Mou les caixes amb Draggable",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(child: _buildMainContainer()),
        ],
      ),
    );
  }

  /// Contenidor principal amb fons imatge
  Widget _buildMainContainer() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/600/400'),
          fit: BoxFit.cover,
        ),
      ),
      child: DragTarget<DragData>(
        builder: (context, candidateData, rejectedData) {
          return _buildInteractiveStack();
        },
        onAcceptWithDetails: (details) {
          setState(() {
            // Actualitzar la posició exacta on es deixa anar
            details.data.onUpdate(details.offset);
          });
        },
      ),
    );
  }

  /// Stack amb InteractiveViewer i Draggable boxes
  Widget _buildInteractiveStack() {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(50),
      minScale: 0.5,
      maxScale: 3.0,
      child: Stack(
        children: [
          _buildDraggableBox(posBox1, Colors.red, (offset) => posBox1 = offset),
          _buildDraggableBox(posBox2, Colors.green, (offset) => posBox2 = offset),
        ],
      ),
    );
  }

  /// Crea un Draggable amb informació per DragTarget
  Widget _buildDraggableBox(Offset pos, Color color, Function(Offset) onUpdate) {
    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: Draggable<DragData>(
        data: DragData(onUpdate),
        feedback: _buildColorBox(color),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: _buildColorBox(color),
        ),
        child: _buildColorBox(color),
      ),
    );
  }

  /// Caixa de color amb marc negre
  Widget _buildColorBox(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }
}

/// Classe per passar informació a DragTarget
class DragData {
  final Function(Offset) onUpdate;

  DragData(this.onUpdate);
}
