enum MapModo {
  explorar,
  crearMarker
}

extension MapModoExtension on MapModo {

  String get name {
    switch (this) {
      case MapModo.explorar:
        return 'Explorar';
      case MapModo.crearMarker:
        return 'Toca el mapa para crear un marcador';
      default:
        return null;
    }
  }
}