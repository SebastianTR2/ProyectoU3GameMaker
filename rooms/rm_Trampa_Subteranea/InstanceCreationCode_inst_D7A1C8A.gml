// Puerta bidireccional - Entrada y Salida
// Si viene de rm_Camara_Artefacto, regresa allí
// Si viene de otra sala, va a rm_Camara_Artefacto (pero necesita llave)

if (variable_global_exists("previous_room") && global.previous_room == rm_Camara_Artefacto) {
    // Regresando de la cámara del artefacto
    target = rm_Camara_Artefacto;
} else {
    // Intentando entrar a la cámara (necesita llave)
    target = rm_Camara_Artefacto;
}

entry_id = "entrada_Trampa_Subteranea";
ori = 90; //arriba