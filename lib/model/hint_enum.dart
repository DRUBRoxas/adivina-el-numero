String par_impar(int num) {
  if (num % 2 == 0) {
    return 'Par';
  } else {
    return 'Impar';
  }
}

String primo(int num) {
  if (num == 1) {
    return 'No es primo';
  }
  for (var i = 2; i < num; i++) {
    if (num % i == 0) {
      return 'No es primo';
    }
  }
  return 'Primo';
}

enum Pistas {
  parImpar("¿Par o Impar?", par_impar),
  numeroPrimo("¿Primo?", primo);

  const Pistas(this.nombre, this.funcion);

  final String nombre;
  final Function funcion;
}
