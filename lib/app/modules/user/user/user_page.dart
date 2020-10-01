import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salu_licence_manager/app/modules/home/home_controller.dart';
import 'package:salu_licence_manager/shared/models/client_model.dart';
import 'package:salu_licence_manager/shared/util/consts.dart';
import 'package:salu_licence_manager/shared/util/functions.dart';
import 'user_controller.dart';

class UserPage extends StatefulWidget {
  final String title;
  final String index;
  const UserPage({Key key, this.title = "Salu Manager", this.index})
      : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ModularState<UserPage, UserController> {
  //use 'controller' variable to access controller
  final _formKey = GlobalKey<FormState>();
  var chaveController = TextEditingController();
  var qtdDiasController = TextEditingController();
  var cnpjController = TextEditingController();

  HomeController homeController = Modular.get();
  int nIndex = 0;
  final maskCNPJ = MaskTextInputFormatter(
      mask: "##.###.###/####-##", filter: {"#": RegExp(r'[0-9]')});
  final maskDias =
      MaskTextInputFormatter(mask: "##", filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    try {
      nIndex = int.parse(widget.index);
    } catch (e) {
      nIndex = null;
    }

    List<ClientModel> list = homeController.clients.value;

    if (nIndex == null) {
      controller.actualClient = ClientModel();
    } else {
      controller.actualClient = homeController.clients.value[nIndex];
      chaveController.text = controller.actualClient.chaveLiberacao != null
          ? controller.actualClient.chaveLiberacao
          : "";

      cnpjController.text = controller.actualClient.cnpj;
    }
    qtdDiasController.text = "35";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Dados do Cliente",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Builder(
                builder: (context) => Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        initialValue: controller.actualClient.nome,
                        decoration: InputDecoration(labelText: 'Nome'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira o Nome do Cliente';
                          }
                        },
                        onSaved: (val) =>
                            setState(() => controller.actualClient.nome = val),
                      ),
                      TextFormField(
                        inputFormatters: [maskCNPJ],
                        controller: cnpjController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'CNPJ'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira o CNPJ do Cliente';
                          }
                        },
                        onSaved: (val) =>
                            setState(() => controller.actualClient.cnpj = val),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        initialValue: controller.actualClient.email,
                        decoration: InputDecoration(labelText: 'E-mail'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira o E-Mail do Cliente';
                          }
                        },
                        onSaved: (val) =>
                            setState(() => controller.actualClient.email = val),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue:
                            controller.actualClient.valorMensal != null
                                ? controller.actualClient.valorMensal.toString()
                                : "0,00",
                        decoration: InputDecoration(labelText: 'Valor Mensal'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira o Valor Mensal do Cliente';
                          }
                        },
                        onSaved: (val) => setState(
                          () => controller.actualClient.valorMensal =
                              int.parse(val),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                inputFormatters: [maskDias],
                                keyboardType: TextInputType.number,
                                controller: qtdDiasController,
                                decoration:
                                    InputDecoration(labelText: 'Dias Ativação'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  chaveController.text = getChave(
                                      int.parse(qtdDiasController.text),
                                      CHAVE_LICENCA,
                                      cnpjController.text
                                          .replaceAll(".", "")
                                          .replaceAll("/", "")
                                          .replaceAll("-", ""));
                                },
                                icon: Icon(Icons.refresh),
                                color: Color(0xFF29B6CE),
                                iconSize: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: chaveController,
                        enabled: false,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          labelText: 'Chave Ativacao',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira o Valor Mensal do Cliente';
                          }
                        },
                        onSaved: (val) => setState(
                          () => controller.actualClient.chaveLiberacao = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {}

                            _formKey.currentState.save();

                            if (controller.actualClient.id != null) {
                              //Realiza a alteracao no item da list
                              homeController.clients.value[nIndex] =
                                  controller.actualClient;
                            }

                            //Salva na api
                            var retorno = await homeController
                                .insertClient(controller.actualClient);

                            if (retorno["id"] != null) {
                              //e retorna para a tela anterior
                              homeController.getAllClients();
                              Modular.navigator.pop();
                            }
                          },
                          color: Color(0xFF29B6CE),
                          child: Container(
                            height: 60,
                            child: Center(
                              child: Text(
                                "Gravar",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
