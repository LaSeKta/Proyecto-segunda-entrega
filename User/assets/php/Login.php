<?php
include '../../../assets/database.php'; // Asegúrate de que este archivo define correctamente $conn

header('Content-Type: application/json');

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (isset($_POST['accion']) && $_POST['accion'] == 'login') {
            if (isset($_POST['ci'], $_POST['password'])) {
                $ci = $_POST['ci'];
                $password = $_POST['password'];

                // Verifica que la conexión $conn esté definida y sin errores
                if (isset($conn) && $conn !== null) {
                    // Preparar la consulta para seleccionar el usuario por CI
                    $stmt = $conn->prepare("SELECT contrasena FROM usuarios WHERE CI = ?");
                    
                    if ($stmt) {
                        $stmt->bind_param("s", $ci);
                        $stmt->execute();
                        $stmt->store_result();

                        if ($stmt->num_rows > 0) {
                            $stmt->bind_result($hashed_password);
                            $stmt->fetch();

                            // Verifica la contraseña usando password_verify
                            if (password_verify($password, $hashed_password)) {
                                echo json_encode(['status' => 'success', 'message' => 'Inicio de sesión exitoso']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Contraseña incorrecta']);
                            }
                        } else {
                            echo json_encode(['status' => 'error', 'message' => 'Usuario no encontrado']);
                        }

                        $stmt->close();
                    } else {
                        echo json_encode(['status' => 'error', 'message' => 'Error al preparar la consulta: ' . $conn->error]);
                    }
                } else {
                    echo json_encode(['status' => 'error', 'message' => 'Error en la conexión a la base de datos']);
                }
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Faltan datos para iniciar sesión']);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Acción no válida']);
        }
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => 'Error del servidor: ' . $e->getMessage()]);
}


?>

