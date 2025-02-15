import 'package:buildmypc/screens/build_details_screen.dart';
import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/services/pc_build_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SavedBuildsPage extends StatefulWidget {
  const SavedBuildsPage({Key? key}) : super(key: key);

  @override
  _SavedBuildsPageState createState() => _SavedBuildsPageState();
}

class _SavedBuildsPageState extends State<SavedBuildsPage> {
  List<PcBuild> builds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBuilds();
  }

  Future<void> _loadBuilds() async {
    try {
      final loadedBuilds =
          await BuildService(AuthService().supabase).getUserBuilds();
      setState(() {
        builds = loadedBuilds;
        isLoading = false;
      });
    } catch (error) {
      print("Errore nel caricamento delle build: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deleteBuild(int index) async {
    final buildToDelete = builds[index];

    try {
      await BuildService(AuthService().supabase).deleteBuild(buildToDelete.id);
      setState(() {
        builds.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Build eliminata con successo!")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Errore nell'eliminazione: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Build Salvate')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : builds.isEmpty
              ? const Center(child: Text("Nessuna build salvata"))
              : ListView.builder(
                  itemCount: builds.length,
                  itemBuilder: (context, index) {
                    final build = builds[index];
                    return Slidable(
                      key: ValueKey(build.id),
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => _deleteBuild(index),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Elimina',
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.white,
                          child: ListTile(
                            title: Text(build.name),
                            subtitle: Text(
                                "\$${build.totalPrice.toStringAsFixed(2)}"),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BuildDetailPage(build: build),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
