library checksumcalculator;

List<String> separadorDeBytes({required String comando}) {
  final List<String> paresBytes = [];

  if (comando.length % 2 != 0) {
    throw Exception("Tamanho dos bytes incorreto\r\n404");
  }

  for (int i = 0; i < comando.length; i += 2) {
    paresBytes.add(comando.substring(i, i + 2));
  }

  return paresBytes;
}

int somaDaListaParesBytes({required List<String> paresBytes}) {
  final List<int> listaDecimais = paresBytes
      .map((byte) => int.parse(byte, radix: 16))
      .toList();

  final int total = listaDecimais.fold(
    0,
    (acumulador, decimal) => acumulador + decimal,
  );

  return total;
}

int complementoDeDois({required int soma}) {
  final int resultadoComplemento = ~soma + 1;
  return resultadoComplemento;
}

String calcularChecksum({required int resultadoComplemento}) {
  final String checksum = (resultadoComplemento & 0xFF)
      .toRadixString(16)
      .padLeft(2, '0')
      .toUpperCase();

  return checksum;
}
