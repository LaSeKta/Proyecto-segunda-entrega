document.addEventListener('DOMContentLoaded', function () {
    // Obtener referencias a los elementos del DOM
    const evolucionForm = document.getElementById('evolucionForm');
    const clientEvolutionsTable = document.getElementById('clientEvolutions');

    // Escuchar el evento de envío del formulario
    evolucionForm.addEventListener('submit', function (event) {
        event.preventDefault(); // Evitar el envío del formulario

        // Obtener los valores de los campos del formulario
        const clientName = document.getElementById('clientName').value;
        const clientProgress = parseInt(document.getElementById('clientProgress').value);
        const clientRating = document.getElementById('clientRating').value;

        // Crear una nueva fila para la tabla de evolución
        const newRow = document.createElement('tr');

        // Crear celdas para los datos del cliente
        const nameCell = document.createElement('td');
        nameCell.textContent = clientName;
        newRow.appendChild(nameCell);

        const progressCell = document.createElement('td');
        progressCell.textContent = `${clientProgress}%`;
        newRow.appendChild(progressCell);

        const ratingCell = document.createElement('td');
        ratingCell.textContent = clientRating;
        newRow.appendChild(ratingCell);

        // Crear celda de alerta si el progreso es menor que el 50%
        const alertCell = document.createElement('td');
        if (clientProgress < 50) {
            alertCell.textContent = '¡Alerta: Bajo progreso!';
            alertCell.style.color = 'red';
            alertCell.style.fontWeight = 'bold';
        } else {
            alertCell.textContent = 'Buen Progreso';
        }
        newRow.appendChild(alertCell);

        // Agregar la nueva fila a la tabla
        clientEvolutionsTable.appendChild(newRow);

        // Limpiar los campos del formulario después de agregar la fila
        evolucionForm.reset();
    });
});