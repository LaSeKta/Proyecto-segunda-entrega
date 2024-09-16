<?php
include '../../../assets/database.php'; // Asegúrate de que este archivo define correctamente $conn

header('Content-Type: application/json');

try {
    // Verificar que se está recibiendo una solicitud POST
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Verificar que se reciban los datos necesarios
        if (isset($_POST['ci'])) {
            $ci = $_POST['ci'];

            // Preparar la consulta para actualizar el user_estado a 2 (inactivo) en la tabla clientes
            $stmt = $conn->prepare("UPDATE clientes SET user_estado = 2 WHERE id_cliente = ?");
            if ($stmt) {
                $stmt->bind_param("s", $ci);

                // Ejecutar la consulta y verificar si se actualizó correctamente
                if ($stmt->execute()) {
                    // Verificar si se actualizó alguna fila
                    if ($stmt->affected_rows > 0) {
                        echo json_encode(['status' => 'success', 'message' => 'Usuario desactivado correctamente']);
                    } else {
                        echo json_encode(['status' => 'error', 'message' => 'No se encontró un cliente con el CI proporcionado']);
                    }
                } else {
                    echo json_encode(['status' => 'error', 'message' => 'Error al desactivar el usuario: ' . $stmt->error]);
                }

                // Cerrar el statement
                $stmt->close();
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Error al preparar la consulta: ' . $conn->error]);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Datos incompletos para desactivar el usuario']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Método de solicitud no permitido']);
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => 'Error del servidor: ' . $e->getMessage()]);
}
?>
