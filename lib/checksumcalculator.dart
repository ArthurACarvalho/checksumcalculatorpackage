library checksumcalculator;

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
