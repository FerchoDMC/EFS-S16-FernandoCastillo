class Lugar {
  int? id;
  String nombre;
  String descripcion;
  double lat;
  double lng;
  bool favorito;

  Lugar({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.lat,
    required this.lng,
    this.favorito = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'lat': lat,
      'lng': lng,
      'favorito': favorito ? 1 : 0,
    };
  }

  factory Lugar.fromMap(Map<String, dynamic> map) {
    return Lugar(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      descripcion: map['descripcion'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      favorito: (map['favorito'] as int) == 1,
    );
  }
}
