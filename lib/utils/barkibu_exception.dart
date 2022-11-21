class BarkibuException implements Exception {
  final String statusCode;
  static Map<String, String> errorMap = errorHashMap();

  BarkibuException(
    this.statusCode,
  );

  static Map<String, String> errorHashMap() {
    Map<String, String> errorMap = {};
    errorMap['SCTY-1000'] = 'Data invalida';
    errorMap['SCTY-1001'] = 'Al menos un campo esta vacio';
    errorMap['SCTY-1002'] = 'Nombre de usuario ya existente';
    errorMap['SCTY-1003'] = 'Correo electronico ya existente';
    errorMap['SCTY-1004'] = 'Formato de correo electronico invalido';
    errorMap['SCTY-1005'] = 'Codigo de recuperacion invalido';
    errorMap['SCTY-1006'] = 'Codigo de recuperacion expirado';
    errorMap['SCTY-1007'] = 'Contraseña nueva y confirmacion deben ser iguales';
    errorMap['SCTY-1008'] = 'La fecha debe ser anterior a la actual';
    errorMap['SCTY-1009'] = 'Veterinaria ya existente';
    errorMap['SCTY-1010'] = 'Contraseña actual incorrecta';
    errorMap['SCTY-1011'] = 'Contraseña nueva y actual deben ser diferentes';
    errorMap['SCTY-1012'] = 'Respuesta ya respondida';
    errorMap['SCTY-1013'] = 'Respuesta ya apoyada';
    // Errores de tipo unauthorized (401) -- no autehnticado
    errorMap['SCTY-2000'] = 'Credenciales invalidas';
    errorMap['SCTY-2001'] = 'Token invalido';
    errorMap['SCTY-2002'] = 'Token expirado';
    errorMap['SCTY-2003'] = 'No se ha proporcionado un token';
    // Errores de tipo forbidden (403) -- no autorizado
    errorMap['SCTY-3000'] = 'El usuario no tiene permisos para realizar esta accion';
    errorMap['SCTY-3001'] = 'El usuario ha sido bloqueado, por favor intente mas tarde';
    // Errores de tipo not found (404) -- no encontrado
    errorMap['SCTY-4000'] = 'Usuario no encontrado';
    errorMap['SCTY-4001'] = 'Ciudad no encontrada';
    errorMap['SCTY-4002'] = 'Estado no encontrado';
    errorMap['SCTY-4003'] = 'Pais no encontrado';
    errorMap['SCTY-4004'] = 'Veterinaria no encontrada';
    errorMap['SCTY-4005'] = 'Pregunta no encontrada';
    errorMap['SCTY-4006'] = 'Categoria de pregunta no encontrada';
    errorMap['SCTY-4007'] = 'Especie no encontrada';
    errorMap['SCTY-4008'] = 'Mascota no encontrada';
    errorMap['SCTY-4009'] = 'Respuesta no encontrada';
    errorMap['SCTY-4010'] = 'Codigo de recuperacion no encontrado';
    errorMap['SCTY-4011'] = 'No hay preguntas para mostrar';
    // Errores de tipo server error (500) -- error interno del servidor
    errorMap['SCTY-5000'] = 'Error al generar el token';
    errorMap['SCTY-5001'] = 'Error al enviar el correo electronico';
    errorMap['SCTY-5002'] = 'Error al subir la imagen';
    return errorMap;
  }

  @override
  String toString() {
    return errorMap[statusCode] ?? 'Error desconocido';
  }
}
