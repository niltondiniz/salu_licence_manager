import 'package:intl/intl.dart';

String getChave(int nDias, String sChave, String sCnpj) {
  //Esta chave vai gerar uma string contendo
  //prefixo
  //data_inicio
  //cnpj
  //qtdDias
  //milisegundos
  //chave
  final f = new DateFormat('MMyyyyddhhmm');
  final m = new DateFormat('mm');
  var sRetorno = "353301" +
      f.format(DateTime.now()) +
      sCnpj +
      nDias.toString().padLeft(2, "0") +
      m.format(DateTime.now()) +
      sChave;
  print(sRetorno);
  return sRetorno;
}
