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
                <td>${emisor.idMunicipio}</td>
                <td>${emisor.direccion}</td>
                <td>${emisor.idGiroComercial}</td>
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



//historial de dte
// Función para obtener el historial de tipos de DTE de Google Sheets
async function getDteHistory() {
  console.log('Llamando a la función getDteHistory...');
  let response;
  try {
      response = await gapi.client.sheets.spreadsheets.values.get({
          spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
          range: 'h.TiposDeDocumento!A:G', // Ajusta el rango según sea necesario
      });
      console.log('Datos de tipos de DTE obtenidos:', response);
  } catch (err) {
      console.error('The API returned an error: ' + err);
      return;
  }

  const rows = response.result.values;
  if (rows.length > 0) {
      const tableBody = document.getElementById('dteHistoryTableBody');
      tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos

      // Saltarse la primera fila si contiene los encabezados de las columnas.
      rows.slice(1).forEach((row) => {
          const tr = `<tr>
                        <td>${row[0]}</td> <!-- Fecha de Creación -->  
                        <td>${row[4]}</td> <!-- Fecha de Recibido -->
                        <td>${row[2]}</td> <!-- Sello de Recibido -->
                        <td>${row[5]}</td> <!-- Tipo de DTE -->
                        <td>
                          <button class="btn btn-dark" onclick="obtenerPdfHacienda('${lastToken}', '${row[3]}')">Obtener PDF</button> <!-- Código de Generación -->
                        </td>
                      </tr>`;
          tableBody.innerHTML += tr;
      });
      document.getElementById("H.TiposDocumentoSection").style.display = "block"; // Mostrar la sección
      console.log('Datos de tipos de DTE mostrados en la tabla.');
  } else {
      document.getElementById('H.TiposDocumentoSection').innerHTML = '<p>No se encontraron datos.</p>';
      console.log('No se encontraron datos de tipos de DTE.');
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
    document.getElementById('H.TiposDeDocumentoSection').classList.remove('hidden');
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
    const sections = document.querySelectorAll('.container.mt-5');
    sections.forEach(section => {
        section.classList.add('hidden');
    });
}