<?php

$nombre = $_GET['nombre'];
$arregloFinal = array();
$arrey2 = array();

if(!isset($nombre)){
    $arregloFinal['status'] = 200;
    $arregloFinal['respuesta'] = "Fue un éxito!";

    for($i = 0; $i < 20; $i++) {
        $arrey2[$i]['nombre_user'] = 'Alejandro';
        $arrey2[$i]['edad'] = $i;
        $arrey2[$i]['band'] = true;
    }

    $arregloFinal['respuesta2'] = $arrey2;
} else if($nombre === 'error500') {
    $arregloFinal['status'] = 500;
    $arregloFinal['respuesta'] = "Error de sintaxis de URL";
    $arregloFinal['respuesta2'] = $arrey2;
} else {
    $arregloFinal['status'] = 404;
    $arregloFinal['respuesta'] = "Objeto no encontrado";
    $arregloFinal['respuesta2'] = $arrey2;
}

echo json_encode($arregloFinal);
?>
