import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../estudiante.dart';
import '../providers/lugares_provider.dart';
import 'formulario_screen.dart';
import 'ubicacion_screen.dart';

class ListaLugaresScreen extends StatefulWidget {
  const ListaLugaresScreen({super.key});

  @override
  State<ListaLugaresScreen> createState() => _ListaLugaresScreenState();
}

class _ListaLugaresScreenState extends State<ListaLugaresScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LugaresProvider>().cargarLugares();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LugaresProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares UIDE'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              estudianteNombre,
              style: TextStyle(fontSize: 12, color: Color.fromARGB(179, 255, 255, 255)),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UbicacionScreen()),
              );
            },
          ),
        ],
      ),
      body: provider.lugares.isEmpty
          ? const Center(child: Text('No hay lugares registrados aún.'))
          : ListView.builder(
              itemCount: provider.lugares.length,
              itemBuilder: (context, index) {
                final lugar = provider.lugares[index];
                return ListTile(
                  title: Text(lugar.nombre),
                  subtitle: Text(lugar.descripcion),
                  trailing: IconButton(
                    icon: Icon(
                      lugar.favorito ? Icons.favorite : Icons.favorite_border,
                      color: lugar.favorito ? Colors.red : null,
                    ),
                    onPressed: () {
                      context.read<LugaresProvider>().toggleFavorito(lugar);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormularioScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
