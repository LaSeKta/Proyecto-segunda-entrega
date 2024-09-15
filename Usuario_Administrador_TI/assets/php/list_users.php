<?php
include '../../../assets/database.php'; // Asegúrate de que este archivo define correctamente $conn

header('Content-Type: application/json');

try {
    // Verificar la conexión a la base de datos
    if (!$conn) {
        throw new Exception('Error en la conexión a la base de datos: ' . mysqli_connect_error());
    }

    // Preparar la consulta para obtener los usuarios y sus nombres desde la tabla personas
    $query = "SELECT usuarios.ci, usuarios.id_rol, personas.nombre 
              FROM usuarios 
              JOIN personas ON usuarios.CI = personas.id_persona"; // JOIN entre usuarios y personas

    $result = $conn->query($query);

    // Verificar si la consulta fue exitosa
    if (!$result) {
        throw new Exception('Error en la consulta SQL: ' . $conn->error);
    }

    // Verificar si se obtuvieron resultados
    if ($result->num_rows === 0) {
        echo json_encode(['status' => 'error', 'message' => 'No se encontraron usuarios en la base de datos.']);
        exit;
    }

    // Construir el array de usuarios
    $users = [];
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }

    // Devolver los usuarios en formato JSON
    echo json_encode($users);

} catch (Exception $e) {
    // Devolver el mensaje de error en formato JSON
    echo json_encode(['status' => 'error', 'message' => 'Error del servidor: ' . $e->getMessage()]);
}
?>
