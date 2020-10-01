// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(i<ClientRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$clientsAtom = Atom(name: '_HomeControllerBase.clients');

  @override
  ObservableFuture<dynamic> get clients {
    _$clientsAtom.reportRead();
    return super.clients;
  }

  @override
  set clients(ObservableFuture<dynamic> value) {
    _$clientsAtom.reportWrite(value, super.clients, () {
      super.clients = value;
    });
  }

  final _$actualClientAtom = Atom(name: '_HomeControllerBase.actualClient');

  @override
  ClientModel get actualClient {
    _$actualClientAtom.reportRead();
    return super.actualClient;
  }

  @override
  set actualClient(ClientModel value) {
    _$actualClientAtom.reportWrite(value, super.actualClient, () {
      super.actualClient = value;
    });
  }

  final _$insertClientAsyncAction =
      AsyncAction('_HomeControllerBase.insertClient');

  @override
  Future<dynamic> insertClient(ClientModel clientModel) {
    return _$insertClientAsyncAction.run(() => super.insertClient(clientModel));
  }

  final _$deleteClientAsyncAction =
      AsyncAction('_HomeControllerBase.deleteClient');

  @override
  Future<dynamic> deleteClient(ClientModel clientModel) {
    return _$deleteClientAsyncAction.run(() => super.deleteClient(clientModel));
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void getAllClients() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getAllClients');
    try {
      return super.getAllClients();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getByCNPJ(String cnpj) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getByCNPJ');
    try {
      return super.getByCNPJ(cnpj);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clients: ${clients},
actualClient: ${actualClient}
    ''';
  }
}
