import 'dart:math';

class Cartela {
  Random random = new Random();

  List<int> gerarNumeros() {
    List<int> listarNumeros = List();
    int numero;

    for (var i = 0; i < 25; i++) {
      // Letra B 1 a 15
      if (i == 0 || i == 5 || i == 10 || i == 15 || i == 20) {
        numero = 1 + random.nextInt(15 - 1);
        print('Numero:$numero');
        while (listarNumeros.contains(numero)) {
          numero = 1 + random.nextInt(15 - 1);
          print('Letra B');
        }
        listarNumeros.add(numero);
      }

      // Letra I 16 a 30
      if (i == 1 || i == 6 || i == 11 || i == 16 || i == 21) {
        numero = 16 + random.nextInt(30 - 16);
        while (listarNumeros.contains(numero)) {
          numero = 16 + random.nextInt(30 - 16);
        }
        listarNumeros.add(numero);
      }
      // Letra N 31 a 45
      if (i == 2 || i == 7 || i == 12 || i == 17 || i == 22) {
        numero = 31 + random.nextInt(45 - 31);

        while (listarNumeros.contains(numero)) {
          numero = 31 + random.nextInt(45 - 31);
        }

        listarNumeros.add(numero);
      }
      // Letra G 46 a 60
      if (i == 3 || i == 8 || i == 13 || i == 18 || i == 23) {
        numero = 46 + random.nextInt(60 - 46);

        while (listarNumeros.contains(numero)) {
          numero = 46 + random.nextInt(60 - 46);
        }

        listarNumeros.add(numero);
      }
      // Letra O 61 a 75
      if (i == 4 || i == 9 || i == 14 || i == 19 || i == 24) {
        numero = 61 + random.nextInt(75 - 61);

        while (listarNumeros.contains(numero)) {
          numero = 61 + random.nextInt(75 - 61);
        }
        listarNumeros.add(numero);
      }

      if (i == 12) {
        listarNumeros[12] = 0;
      }
    }

    return listarNumeros;
  }
}
