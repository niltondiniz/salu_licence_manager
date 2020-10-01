import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Salu Manager"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    controller.getAllClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        leading: Image.asset("assets/images/salu.jpeg"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Observer(
              builder: (_) {
                if (controller.clients.error != null) {
                  return Center(child: Text('Erro ao buscar dados'));
                }
                if (controller.clients.value == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<ClientModel> list = controller.clients.value;

                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = list[index];
                        return Dismissible(
                          key: Key(item.id.toString()),
                          onDismissed: (direction) {
                            setState(() {
                              controller.deleteClient(list[index]);
                              list.removeAt(index);
                            });
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${item.nome} foi removido"),
                              ),
                            );
                          },
                          confirmDismiss: (DismissDirection direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmação"),
                                  content: const Text(
                                      "Deseja realmente excluir este item?"),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Excluir")),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Cancelar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    "Excluir Registro",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                  ),
                                  child: Icon(
                                    Icons.delete_sweep,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Modular.navigator.pushNamed("/user/$index");
                            },
                            child: ListTile(
                              title: Text(
                                list[index].nome,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(list[index].cnpj == null
                                  ? "[Dados não definidos]"
                                  : list[index].cnpj),
                              leading: SizedBox(
                                height: 70,
                                width: 70,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Color(0xff000000),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage('assets/images/salu.jpeg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.navigator.pushNamed("/user/n");
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF29B6CE),
      ),
    );
  }
}
