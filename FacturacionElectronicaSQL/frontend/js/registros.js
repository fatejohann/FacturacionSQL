async function loadDepartamentosYMunicipios() {
    try {
        // Cargar departamentos
        const responseDepartamentos = await fetch('../api/get_departamentos.php');
        if (!responseDepartamentos.ok) {
            throw new Error(`Error HTTP: ${responseDepartamentos.status}`);
        }
        const departamentos = await responseDepartamentos.json();

        const departamentoSelect = document.getElementById('departamento');
        departamentos.forEach(departamento => {
            const option = document.createElement('option');
            option.value = departamento.id;
            option.text = departamento.nombre;
            departamentoSelect.add(option);
        });

        // Cargar municipios al seleccionar un departamento
        departamentoSelect.addEventListener('change', async function() {
            const departamentoId = this.value;
            const responseMunicipios = await fetch(`../api/get_municipios.php?departamentoId=${departamentoId}`);
            if (!responseMunicipios.ok) {
                throw new Error(`Error HTTP: ${responseMunicipios.status}`);
            }
            const municipios = await responseMunicipios.json();

            const municipioSelect = document.getElementById('municipio');
            municipioSelect.innerHTML = ''; // Limpiar opciones anteriores
            municipios.forEach(municipio => {
                const option = document.createElement('option');
                option.value = municipio.id;
                option.text = municipio.nombre;
                municipioSelect.add(option);
            });
        });

    } catch (error) {
        console.error('Error al cargar departamentos y municipios:', error);
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
        idMunicipio: document.getElementById('municipio').value,
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

document.addEventListener('DOMContentLoaded', loadDepartamentosYMunicipios);