<?php
include '../../../assets/database.php'; // Asegúrate de que este archivo define correctamente $conn

header('Content-Type: application/json');

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (isset($_POST['accion']) && $_POST['accion'] == 'registrar') {
            if (isset($_POST['ci'], $_POST['password'])) {
                $ci = $_POST['ci'];
                $password = password_hash($_POST['password'], PASSWORD_BCRYPT); // Asegura el hash de la contraseña

                if (isset($conn) && $conn !== null) {
                    $stmt = $conn->prepare("INSERT INTO usuarios (CI, contrasena) VALUES (?, ?)");
                    if ($stmt) {
                        $stmt->bind_param("ss", $ci, $password);

                        if ($stmt->execute()) {
                            echo json_encode(['status' => 'success', 'message' => 'Usuario registrado correctamente']);
                        } else {
                            echo json_encode(['status' => 'error', 'message' => 'Error al registrar usuario']);
                        }

                        $stmt->close();
                    } else {
                        echo json_encode(['status' => 'error', 'message' => 'Error al preparar la consulta: ' . $conn->error]);
                    }
                } else {
                    echo json_encode(['status' => 'error', 'message' => 'Error en la conexión a la base de datos']);
                }
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Faltan datos para registrar al usuario']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        }
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => 'Error del servidor: ' . $e->getMessage()]);
}
?>
