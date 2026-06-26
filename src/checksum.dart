library checksumcalculator;

void main() {
  try {
    String comando = "ZH+1002C201000075000900000100002F00000102002100000100002600000100001A00000100020600000100000400000100000F00000100002500000100030100000201000300000101001D00000100003300000101001C00000100001F00000100002000000100020A00000100002E00000101010000000100002300000100000500000100020700000102003600000101000B00000102002D00000102001100000100001E00000100002900000103020400000100002A00000100000C00000100020100000101000000000100002200000100003800000103003100000100003500000101000200000101001300000100001600000100021100000103020200000104020300000100003A00000304020000000105000700000100003700000105003400000101002B00000100999900000102002400000100030000000201000800000100002800000105020500000103000A00000100001200000100001700000100002700000101020E00000100003000000100001500000100001B00000100001000000100003900000102001400000100000600000100001900000103003200000100001800000101000D00000101020800000104020B00000100020D00000102000E00000100020C00000104030300000208020F00000102021000000103030500000201030400000201030200000205020900000108021300000101021200000100021400000104030600000206021500000101022200000001022100000100022300000100022000000100888800000001021600000100021700000100030700000006021800000100ABCD00000002030800000003777700000100666600000206021A00000101030900000004030A00000002030F00000004030B00000004030E00000003030C00000004030D00000005031000000003031100000002CCCC00000001DDDD00000001021B00000100010100000101DCBA00000001000100000100";
    String comandoSemCabecalho = comando.split("ZH+")[1].toString();
    List<String> paresBytes = separadorDeBytes(comando: comandoSemCabecalho);
    int soma = somaDaListaParesBytes(paresBytes: paresBytes);
    int resultadoComplemento = complementoDeDois(soma: soma);
    String checksum = calcularChecksum(resultadoComplemento: resultadoComplemento);
    print("O checksum do comando $comando é: $checksum");
  } catch (e, st) {
    print("$e $st");
  }

}

List<String> separadorDeBytes({required String comando}) {
  List<String> paresBytes = [];

  try {
    int tamanho = comando.length;
    if (tamanho % 2 != 0) {
      throw Exception("Tamanho dos bytes incorreto\r\n404");
    }
    for (int i = 0; i < tamanho; i++) {
      if (comando.length > 0) {
        String firstByte = comando.substring(0, 2);
        paresBytes.add(firstByte);
        comando = comando.replaceFirst(firstByte, "");
      }
    }
  } catch (e) {
    rethrow;
  }

  return paresBytes;
}

int somaDaListaParesBytes({required List<String> paresBytes}){
  List<int> listaDecimais = [];
  for(int i = 0; i < paresBytes.length; i++){
    int decimal = int.parse(paresBytes[i], radix: 16);
    listaDecimais.add(decimal);
  }
  int total = listaDecimais.fold(0, (acumulador, decimal) => acumulador + decimal);  
  return total;
}

int complementoDeDois({required int soma}){
  int resultadoComplemento = ~soma + 1;
  return resultadoComplemento;
}

String calcularChecksum({required int resultadoComplemento}){
  String checksum = (resultadoComplemento & 0xFF).toRadixString(16);
  return checksum.toUpperCase();
}



