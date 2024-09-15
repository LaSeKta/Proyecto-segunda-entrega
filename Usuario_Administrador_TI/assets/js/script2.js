document.addEventListener('DOMContentLoaded', () => {
    const usersTable = document.getElementById('users');
    const editModal = document.getElementById('editModal');
    const closeButton = document.querySelector('.close-button');
    const editForm = document.getElementById('editForm');
    let usersList = [];
    let currentUserID = null;

    const roleMap = {
        0: 'Usuario',
        1: 'Usuario cliente',
        2: 'Entrenador',
        3: 'usuario avanzado',
        4: 'Usuario administrativo',
        5: 'usuario Seleccionador',
    };

    function getRoleName(idRol) {
        return roleMap[idRol] || 'Rol Desconocido';
    }

    function fetchUsers() {
        fetch('assets/php/list_users.php')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'error') {
                    alert(data.message);
                    return;
                }

                if (Array.isArray(data)) {
                    usersList = data;
                    renderUsersTable();
                } else {
                    console.error('La respuesta no es un array:', data);
                    alert('Error: La respuesta del servidor no es un array.');
                }
            })
            .catch(error => {
                console.error('Error al obtener usuarios:', error);
                alert('Error al obtener usuarios: ' + error.message);
            });
    }

    function renderUsersTable() {
        usersTable.innerHTML = '';

        if (usersList.length === 0) {
            usersTable.innerHTML = '<tr><td colspan="4">No hay usuarios disponibles.</td></tr>';
            return;
        }

        usersList.forEach(user => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${user.nombre || 'N/A'}</td>
                <td>${user.ci || 'N/A'}</td>
                <td>${getRoleName(user.id_rol)}</td>
                <td>
                    <button class="edit-button" onclick="editPermissions('${user.ci}')">Editar</button>
                    <button class="delete-button" onclick="deleteUser('${user.ci}')">Eliminar</button>
                </td>
            `;
            usersTable.appendChild(row);
        });
    }

    window.editPermissions = function(userId) {
        currentUserID = userId;
        const user = usersList.find(user => user.ci === userId);
        if (user) {
            document.getElementById('editRole').value = user.id_rol;
            editModal.style.display = 'block';
        } else {
            alert('Usuario no encontrado para editar.');
            console.error('Usuario no encontrado:', userId);
        }
    };

    closeButton.addEventListener('click', () => {
        editModal.style.display = 'none';
    });

    editForm.addEventListener('submit', (event) => {
        event.preventDefault();

        const newRole = document.getElementById('editRole').value;

        fetch('assets/php/update_role.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                ci: currentUserID,
                id_rol: newRole,
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const user = usersList.find(user => user.ci === currentUserID);
                if (user) {
                    user.id_rol = newRole;
                    renderUsersTable();
                }
                alert(data.message);
            } else {
                alert(data.message);
                console.error('Error al actualizar el rol:', data.message);
            }
        })
        .catch(error => {
            alert('Error al actualizar el rol: ' + error.message);
            console.error('Error en la solicitud:', error);
        });

        editModal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target == editModal) {
            editModal.style.display = 'none';
        }
    });

    fetchUsers();
});
