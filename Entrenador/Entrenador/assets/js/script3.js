let planes = [
    { id: 1, nombre: 'Plan de Fuerza', objetivo: 'Aumentar fuerza muscular' }
];

let clientes = [
    { id: 1, nombre: 'Juan Pérez' },
    { id: 2, nombre: 'María Gómez' }
];

let asignaciones = [
    { clienteId: 1, planId: 1 }
];

document.addEventListener('DOMContentLoaded', () => {
    cargarPlanes(); 
    cargarClientes(); 
    cargarOpcionesPlanes(); 
    cargarAsignacionesTabla(); 
    ocultarModales(); 
});

function ocultarModales() {
    document.getElementById('modal-asignar-plan').style.display = 'none';
}

function cargarPlanes() {
    const listaPlanes = document.getElementById('planes-list');
    listaPlanes.innerHTML = ''; 
    
    planes.forEach(plan => {
        const li = document.createElement('li');
        li.textContent = `${plan.nombre} - ${plan.objetivo}`;
        li.dataset.id = plan.id;
        li.addEventListener('click', () => cargarFormularioPlan(plan));
        listaPlanes.appendChild(li);
    });


    cargarOpcionesPlanes();
}


function cargarFormularioPlan(plan) {
    document.getElementById('nombre-plan').value = plan.nombre;
    document.getElementById('objetivo-plan').value = plan.objetivo;
    document.getElementById('agregar-plan-btn').dataset.id = plan.id; 
}

function cargarOpcionesPlanes() {
    const selectPlanes = document.getElementById('plan-select');
    selectPlanes.innerHTML = ''; 

    planes.forEach(plan => {
        const option = document.createElement('option');
        option.value = plan.id;
        option.textContent = plan.nombre;
        selectPlanes.appendChild(option);
    });
}

function cargarClientes() {
    const selectClientes = document.getElementById('cliente-select');
    selectClientes.innerHTML = ''; 

    clientes.forEach(cliente => {
        const option = document.createElement('option');
        option.value = cliente.id;
        option.textContent = cliente.nombre;
        selectClientes.appendChild(option);
    });
}


document.getElementById('plan-form').addEventListener('submit', (e) => {
    e.preventDefault();
    const id = document.getElementById('agregar-plan-btn').dataset.id;
    const nombre = document.getElementById('nombre-plan').value;
    const objetivo = document.getElementById('objetivo-plan').value;

    if (id) {

        const plan = planes.find(p => p.id == id);
        plan.nombre = nombre;
        plan.objetivo = objetivo;
    } else {

        const nuevoPlan = {
            id: Date.now(), 
            nombre,
            objetivo
        };
        planes.push(nuevoPlan); 
    }

    cargarPlanes(); 
    e.target.reset(); 
    delete document.getElementById('agregar-plan-btn').dataset.id; 
});


document.getElementById('eliminar-plan-btn').addEventListener('click', () => {
    const id = document.getElementById('agregar-plan-btn').dataset.id;
    if (id) {
        planes = planes.filter(p => p.id != id); 
        cargarPlanes(); 
        document.getElementById('plan-form').reset();
        delete document.getElementById('agregar-plan-btn').dataset.id; 
    }
});

document.getElementById('asignar-plan-form').addEventListener('submit', (e) => {
    e.preventDefault();
    const clienteId = parseInt(document.getElementById('cliente-select').value);
    const planId = parseInt(document.getElementById('plan-select').value);

    asignaciones.push({ clienteId, planId });
    
    cargarAsignacionesTabla(); 
    e.target.reset(); 
});


function cargarAsignacionesTabla() {
    const tablaAsignacionesBody = document.querySelector('#tabla-asignaciones tbody');
    tablaAsignacionesBody.innerHTML = '';

    asignaciones.forEach(asignacion => {
        const cliente = clientes.find(c => c.id === asignacion.clienteId);
        const plan = planes.find(p => p.id === asignacion.planId);
        const tr = document.createElement('tr');
        tr.innerHTML = `<td>${cliente.nombre}</td><td>${plan.nombre}</td>`;
        tablaAsignacionesBody.appendChild(tr);
    });
}

document.getElementById('abrir-modal-asignar-btn').addEventListener('click', () => {
    document.getElementById('modal-asignar-plan').style.display = 'block';
    cargarOpcionesPlanes(); 
    cargarAsignacionesTabla(); 
});

document.getElementById('cerrar-modal-asignar-btn').addEventListener('click', () => {
    document.getElementById('modal-asignar-plan').style.display = 'none';
});

window.addEventListener('click', (event) => {
    if (event.target === document.getElementById('modal-asignar-plan')) {
        document.getElementById('modal-asignar-plan').style.display = 'none';
    }
});