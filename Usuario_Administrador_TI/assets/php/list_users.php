<?php
include '../../../assets/database.php'; // Asegúrate de que este archivo define correctamente $conn

header('Content-Type: application/json');

try {
    // Consulta para obtener usuarios activos (user_estado != 2)
    $query = "
        SELECT u.ci, u.id_rol, p.nombre, c.user_estado 
        FROM usuarios u
        LEFT JOIN personas p ON u.CI = p.id_persona
        LEFT JOIN clientes c ON u.CI = c.id_cliente
        WHERE c.user_estado != 2"; // Filtrar solo usuarios activos
    
    $result = $conn->query($query);

    if ($result) {
        $users = [];
        while ($row = $result->fetch_assoc()) {
            $users[] = $row;
        }
        echo json_encode($users);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Error al obtener usuarios: ' . $conn->error]);
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => 'Error del servidor: ' . $e->getMessage()]);
}
?>
