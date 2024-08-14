let lastToken;

document.addEventListener('DOMContentLoaded', function() {
    getTokens();
});

// Función para obtener todos los tokens desde el backend
async function getTokens() {
    try {
        const response = await fetch('../api/get_token.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();

        console.log('Tokens obtenidos:', data);

        // Mostrar los tokens en la tabla
        const tableBody = document.getElementById('TokenTableBody');
        if (tableBody) {
            tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos

            data.forEach(token => {
                const tr = document.createElement('tr');

                // Fecha de Generación (dividida en fecha y hora)
                const tokenDate = new Date(token.fechaGeneracion);

                // Celda para la fecha
                const dateCell1 = document.createElement('td');
                dateCell1.innerText = tokenDate.toLocaleDateString(); // Mostrar solo la fecha
                tr.appendChild(dateCell1);

                // Celda para la hora
                const dateCell2 = document.createElement('td');
                dateCell2.innerText = tokenDate.toLocaleTimeString(); // Mostrar solo la hora
                tr.appendChild(dateCell2);


                // Token
                const tokenCell = document.createElement('td');
                tokenCell.innerText = token.tokenActual;
                tr.appendChild(tokenCell);

                tableBody.appendChild(tr);
            });

            document.getElementById("TokenTableBody").style.display = "block"; // Mostrar la sección
        } else {
            console.error('Elemento TokenTableBody no encontrado.');
        }
    } catch (err) {
        console.error('Error al obtener los tokens:', err);
    }
}

// Función para obtener y mostrar el historial de emisores
async function getEmisor() {
    let response;
    try {
        response = await fetch('../api/get_emisores.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const emisores = await response.json();
        const tableBody = document.getElementById('hEmisorTableBody');
        tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos.
        
        emisores.forEach((emisor) => {
            // Crea una fila de tabla por cada registro.
            let tr = `<tr>
                <td>${emisor.nombreComercial}</td>
                <td>${emisor.nit}</td>
                <td>${emisor.nrc}</td>
                <td>${emisor.telefono}</td>
                <td>${emisor.correoElectronico}</td>
                <td>${emisor.municipio}</td>
                <td>${emisor.direccion}</td>
                <td>${emisor.giroComercial}</td>
                <td class="text-center">
                    <button class="btn btn-danger" onclick="eliminarEmisor(${emisor.id})">Eliminar</button>
                </td>
            </tr>`;
            tableBody.innerHTML += tr;
        });
    } catch (error) {
        console.error('Error al obtener los emisores:', error);
        document.getElementById('H.EmisorSection').innerHTML = '<p>No se encontraron datos.</p>';
    }
}

// Función para eliminar un emisor
async function eliminarEmisor(id) {
    if (confirm('¿Estás seguro de que deseas eliminar este emisor?')) {
        try {
            const response = await fetch(`../api/delete_emisor.php?id=${id}`, { method: 'DELETE' });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            alert('Emisor eliminado exitosamente.');
            getEmisor(); // Recargar la tabla de emisores
        } catch (error) {
            console.error('Error al eliminar el emisor:', error);
            alert('Error al eliminar el emisor.');
        }
    }
}

//historial de receptor
async function getClientes() {
    try {
        const response = await fetch('../api/get_clientes.php');
        if (!response.ok) {
            throw new Error(`Error HTTP: ${response.status}`);
        }

        const clientes = await response.json();

        // Log para verificar los datos obtenidos
        console.log('Clientes obtenidos:', clientes);

        const tableBody = document.getElementById('hClienteTableBody');
        tableBody.innerHTML = '';

        clientes.forEach(cliente => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${cliente.nombreCliente}</td>
                <td>${cliente.nombreComercial}</td>
                <td>${cliente.nitDui}</td>
                <td>${cliente.nrc}</td>
                <td>${cliente.telefono}</td>
                <td>${cliente.correoElectronico}</td>
                <td>${cliente.municipio}</td>
                <td>${cliente.direccion}</td>
                <td>${cliente.giroComercial}</td>
                <td>${cliente.exentoIVA ? 'Sí' : 'No'}</td>
                <td>
                    <button class="btn btn-danger" onclick="eliminarCliente(${cliente.id})">Eliminar</button>
                </td>
            `;
            tableBody.appendChild(row);
        });
    } catch (error) {
        console.error('Error al obtener los clientes:', error);
    }
}

// Función para eliminar un cliente
async function eliminarCliente(id) {
    if (confirm('¿Estás seguro de que deseas eliminar este cliente?')) {
        try {
            const response = await fetch(`http://localhost:3000/FacturacionElectronicaSQL/api/delete_cliente.php`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `id=${id}`
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            alert('Cliente eliminado exitosamente.');
            getClientes(); // Recargar la tabla de clientes
        } catch (error) {
            console.error('Error al eliminar el cliente:', error);
            alert('Error al eliminar el cliente.');
        }
    }
}

 // Función para cargar el historial de DTE
async function cargarHistorialDTE() {
    try {
        console.log("Cargando historial de DTE...");
        const response = await fetch("../api/get_dte_history.php");
        if (!response.ok) {
            throw new Error("Error al obtener el historial de DTE");
        }
        const dteHistory = await response.json();
        console.log("Historial de DTE obtenido:", dteHistory);

        const tableBody = document.getElementById("dteHistoryTableBody");
        tableBody.innerHTML = "";

        dteHistory.forEach(row => {
            const tr = document.createElement("tr");

            const fechaDocumentoTd = document.createElement("td");
            fechaDocumentoTd.textContent = row.fechaDocumento;
            tr.appendChild(fechaDocumentoTd);

            const estadoDocumentoTd = document.createElement("td");
            estadoDocumentoTd.textContent = row.estadoDocumento; 
            tr.appendChild(estadoDocumentoTd);

            const tipoDteTd = document.createElement("td");
            tipoDteTd.textContent = row.tipoDte;
            tr.appendChild(tipoDteTd);

            const operacionesTd = document.createElement("td");
            const obtenerPdfButton = document.createElement("button");
            obtenerPdfButton.className = "btn btn-dark";
            obtenerPdfButton.textContent = "Obtener PDF";
            obtenerPdfButton.onclick = () => obtenerPdfHacienda(lastToken, row.codigoGeneracion);
            operacionesTd.appendChild(obtenerPdfButton);
            tr.appendChild(operacionesTd);

            tableBody.appendChild(tr);
        });
    } catch (error) {
        console.error("Error al cargar el historial de DTE:", error);
    }
}


// Función para obtener el PDF de Hacienda
async function obtenerPdfHacienda(lastToken, codGeneracion) {
    try {
        const url = `https://admin.factura.gob.sv/test/generardte/generar-pdf/descargar/base64/codigo-generacion/1/${codGeneracion}`;
        const headers = {
            'Authorization': lastToken
        };

        const response = await axios.post(url, null, { headers });
        if (response.status === 200) {
            const pdfBase64 = response.data;
            // Crear un enlace para descargar el PDF
            const link = document.createElement('a');
            link.href = `data:application/pdf;base64,${pdfBase64}`;
            link.download = `${codGeneracion}.pdf`;
            link.click();
        } else {
            console.error('Error al obtener el PDF:', response.status);
        }
    } catch (error) {
        console.error('Error interno del servidor:', error.message);
    }
}

// Funciones para mostrar las secciones correspondientes
function showToken() {
    hideAllSections();
    document.getElementById('H.TokenSection').classList.remove('hidden');
    getTokens();
}

function showTiposdeDocumento() {
    hideAllSections();
    document.getElementById('H.TiposDocumentoSection').classList.remove('hidden');
    cargarHistorialDTE();
}

function showEmisor() {
    hideAllSections();
    document.getElementById('H.EmisorSection').classList.remove('hidden');
    getEmisor();
}

function showClientes() {
    hideAllSections();
    document.getElementById('H.ClienteSection').classList.remove('hidden');
    getClientes();
}

function hideAllSections() {
    const sections = document.querySelectorAll('.container.section');
    sections.forEach(section => {
        section.classList.add('hidden');
    });
}