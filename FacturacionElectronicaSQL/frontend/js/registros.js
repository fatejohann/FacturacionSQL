document.addEventListener('DOMContentLoaded', function() {
    // Mostrar la sección de emisor por defecto al cargar la página
    document.getElementById('emisorSection').classList.remove('hidden');
    document.getElementById('clienteSection').classList.add('hidden');
    loadDepartamentos('departamentoEmisor'); // Cargar departamentos cuando se muestra la página de emisor

    document.getElementById('departamentoEmisor').addEventListener('change', function() {
        const departamentoId = this.value;
        loadMunicipios(departamentoId, 'municipioEmisor');
    });

    document.getElementById('showEmisorForm').addEventListener('click', function() {
        document.getElementById('emisorSection').classList.remove('hidden');
        document.getElementById('clienteSection').classList.add('hidden');
        loadDepartamentos('departamentoEmisor'); // Cargar departamentos cuando se muestra la sección de emisor
    });

    document.getElementById('showClienteForm').addEventListener('click', function() {
        document.getElementById('clienteSection').classList.remove('hidden');
        document.getElementById('emisorSection').classList.add('hidden');
        loadDepartamentos('departamentoCliente'); // Cargar departamentos cuando se muestra la sección de clientes
        document.getElementById('departamentoCliente').addEventListener('change', function() {
            const departamentoId = this.value;
            loadMunicipios(departamentoId, 'municipioCliente');
        });
    });
});

async function loadDepartamentos(selectId) {
    try {
        const response = await fetch('../api/get_departamentos.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const departamentos = await response.json();
        const departamentoSelect = document.getElementById(selectId);
        departamentoSelect.innerHTML = '<option value="" disabled selected>Seleccionar uno</option>';
        departamentos.forEach(departamento => {
            const option = document.createElement('option');
            option.value = departamento.id;
            option.textContent = departamento.nombreDepartamento;
            departamentoSelect.appendChild(option);
        });
    } catch (error) {
        console.error('Error al cargar los departamentos:', error);
    }
}

async function loadMunicipios(departamentoId, selectId) {
    try {
        const response = await fetch(`../api/get_municipios.php?departamento_id=${departamentoId}`);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const municipios = await response.json();
        const municipioSelect = document.getElementById(selectId);
        municipioSelect.innerHTML = '<option value="" disabled selected>Seleccionar uno</option>';
        municipios.forEach(municipio => {
            const option = document.createElement('option');
            option.value = municipio.id;
            option.textContent = municipio.nombreMunicipio;
            municipioSelect.appendChild(option);
        });
    } catch (error) {
        console.error('Error al cargar los municipios:', error);
    }
}



// Función para crear un nuevo emisor
async function createEmisor() {
    const emisorData = {
        nombreComercial: document.getElementById('nombreComercial').value,
        nit: document.getElementById('nit').value,
        nrc: document.getElementById('nrc').value,
        telefono: document.getElementById('telefono').value,
        correoElectronico: document.getElementById('correo').value,
        idMunicipio: document.getElementById('municipioEmisor').value,
        direccion: document.getElementById('complemento').value
    };

    console.log("Enviando datos:", emisorData); // Agregar log para verificar los datos

    try {
        const response = await fetch('../api/save_emisor.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(emisorData)
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || `Error HTTP: ${response.status}`);
        }

        const result = await response.json();
        alert(result.message);

    } catch (error) {
        console.error('Error al guardar el emisor:', error);
        alert('Error al guardar el emisor: ' + error.message);
    }
}

// Event listener para el formulario de emisor
document.getElementById('emisorForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir el envío del formulario por defecto
    createEmisor();
});



// Función para validar y crear un nuevo cliente
async function createCliente(event) {
    event.preventDefault(); // Prevenir el envío del formulario por defecto


    const clienteData = {
        nombreCliente: document.getElementById('nombreCliente').value,
        nombreComercial: document.getElementById('nombreComercialCliente').value,
        direccion: document.getElementById('direccionCliente').value,
        telefono: document.getElementById('telefonoCliente').value,
        nitDui: document.getElementById('nitDui').value,
        nrc: document.getElementById('nrcCliente').value,
        exentoIVA: document.getElementById('exentoIVA').checked ? 1 : 0,
        correoElectronico: document.getElementById('correoCliente').value,
        idMunicipio: document.getElementById('municipioCliente').value
    };

    console.log("Enviando datos:", clienteData); // Agregar log para verificar los datos

    try {
        const response = await fetch('../api/save_cliente.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(clienteData)
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || `Error HTTP: ${response.status}`);
        }

        const result = await response.json();
        alert(result.message);

    } catch (error) {
        console.error('Error al guardar el cliente:', error);
        alert('Error al guardar el cliente: ' + error.message);
    }
}

// Event listener para el formulario de cliente
document.getElementById('clienteForm').addEventListener('submit', createCliente);