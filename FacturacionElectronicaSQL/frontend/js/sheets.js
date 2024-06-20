let lastToken;
let emisor;
let receptor;
let token;

// Función para enviar datos a la hoja de Google Sheets
function sendDataToSheet(sheetName, data) {
    const sheets = gapi.client.sheets.spreadsheets.values;
    const spreadsheetId = '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI';
    const range = `${sheetName}!A:Z`;
  
    sheets.append({
      spreadsheetId: spreadsheetId,
      range: range,
      valueInputOption: 'RAW',
      values: [data] // Se envía como un array de datos
    }).then(function (response) {
      alert(`Los datos se han enviado correctamente a la hoja "${sheetName}"`);
    }, function (error) {
      console.error("Error al enviar datos a la hoja: ", error);
    });
}

// Función para manejar el envío del formulario de Token
document.getElementById('tokenForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir el envío del formulario por defecto

    // Obtener los valores de los campos del formulario
    const nit = document.getElementById('nit').value;
    const password = document.getElementById('password').value;

    // Realizar la solicitud a la API
    const url = 'https://apitest.dtes.mh.gob.sv/seguridad/auth'; // URL de la API
    const data = new URLSearchParams();
    data.append('user', nit);
    data.append('pwd', password);

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: data
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json(); // Convertir la respuesta en JSON
    })
    .then(jsonResponse => {
        // Aquí puedes manejar la respuesta JSON como desees
        console.log(jsonResponse);
        const token = jsonResponse.body.token.toString(); // Convertir el token en una cadena de texto

        // Guardar el token en la variable global
        lastToken = token;

        // Obtener la fecha de creación
        const fechaCreacion = new Date().toISOString();

        // Crear un arreglo con los datos a enviar a la hoja de Google Sheets
        const dataToSend = [ fechaCreacion, token ];

        // Llamar a la función para enviar los datos a la hoja de Google Sheets
        sendDataToSheet('h.token', dataToSend);

        // Mostrar el token en la página
        document.getElementById('tokenDisplay').innerText = token;
    })
    .catch(error => {
        // Aquí manejas los errores
        console.error('There was a problem with the fetch operation:', error);
        alert('Hubo un problema con la autenticación.');
    });
});

// Función para obtener el último token de Google Sheets
async function getLastToken() {
    try {
        const response = await gapi.client.sheets.spreadsheets.values.get({
            spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
            range: 'h.token!A:D', // Ajusta el rango según sea necesario
        });

        const rows = response.result.values;
        if (rows.length > 0) {
            const lastRow = rows[rows.length - 1]; // Obtener la última fila
            lastToken = lastRow[1]; // Suponiendo que el token está en la segunda columna
            const tokenDate = new Date(lastRow[0]); // Suponiendo que la fecha está en la primera columna
            const currentDate = new Date();

            console.log('Último token obtenido:', lastToken); // Log para mostrar el token obtenido

            // Mostrar el token en la tabla
            const tableBody = document.getElementById('lastTokenTableBody');
            if (tableBody) {
                tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos
                const tr = `<tr>
                              <td>${lastRow[0]}</td>
                              <td>${lastRow[1]}</td>
                            </tr>`;
                tableBody.innerHTML += tr;

                // Calcular la diferencia en horas entre la fecha del token y la fecha actual
                const timeDifference = currentDate - tokenDate;
                const hoursDifference = timeDifference / (1000 * 60 * 60);

                // Mostrar un mensaje sobre el estado del token
                const message = document.createElement('p');
                if (hoursDifference > 24) {
                    message.innerText = 'El token ha caducado.';
                } else {
                    message.innerText = 'El token está vigente.';
                }
                document.getElementById('lastTokenSection').appendChild(message);

                document.getElementById("lastTokenSection").style.display = "block"; // Mostrar la sección
            } else {
                console.error('Elemento lastTokenTableBody no encontrado.');
            }
        } else {
            console.error('No se encontró ningún token.');
        }
    } catch (err) {
        console.error('The API returned an error: ' + err);
    }
}

async function cargarEmisoresDesdeGoogleSheets() {
    try {
        const response = await gapi.client.sheets.spreadsheets.values.get({
            spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
            range: 'h.emisor!A:Q', // Asegúrate de que este rango cubra todas las columnas necesarias.
        });

        const rows = response.result.values;
        if (rows && rows.length > 0) {
            console.log('Datos recibidos:', rows); // Log de los datos recibidos
            const emisores = rows.slice(1).map(row => ({
                nit: row[0],
                nrc: row[1],
                nombre: row[2],
                codActividad: row[3],
                descActividad: row[4],
                nombreComercial: row[5],
                tipoEstablecimiento: row[6],
                direccion: {
                    departamento: row[7],
                    municipio: row[8],
                    complemento: row[9],
                },
                telefono: row[10],
                correo: row[11],
                codEstableMH: row[12],
                codEstable: row[13],
                codPuntoVentaMH: row[14],
                codPuntoVenta: row[15],
            }));
            //llenarTablaEmisores(emisores);
            llenarSelectEmisores(emisores);
        } else {
            console.log('No se encontraron datos.');
            alert('No se encontraron datos en la hoja especificada.');
        }
    } catch (err) {
        console.error('The API returned an error: ', err);
        alert('Hubo un error al obtener los datos: ' + err.message);
    }
}

// Función para llenar el select con emisores
function llenarSelectEmisores(emisores) {
    const emisorSelect = document.getElementById('emisorSelect');
    emisorSelect.innerHTML = '<option value="" disabled selected>Seleccionar Emisor</option>'; // Limpiar el select

    emisores.forEach((emisor, index) => {
        let option = document.createElement('option');
        option.value = index;
        option.text = emisor.nombre;
        emisorSelect.appendChild(option);
    });

    // Asociar evento onchange al select
    emisorSelect.addEventListener('change', function() {
        autocompletarEmisor(parseInt(this.value)); // Llama a autocompletarEmisor con el índice seleccionado convertido a entero
    });

    // Guardar los emisores en una variable global para acceder a ellos en la función autocompletarEmisor
    window.emisores = emisores;
}

/*function llenarTablaEmisores(emisores) {
    const tableBody = document.getElementById('emisorTableBody');
    tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos.

    emisores.forEach((emisor, index) => {
        let tr = `<tr>
                    <td>${emisor.nombre}</td>  <!-- Nombre -->
                    <td class="text-center">
                      <button class="btn btn-primary" onclick="autocompletarEmisor(${index})">Autocompletar</button>
                    </td>
                  </tr>`;
        tableBody.innerHTML += tr;
    });

    // Guardar los emisores en una variable global para acceder a ellos en la función autocompletarCampos
    window.emisores = emisores;
}
function mostrarOcultarEmisores() {
    const emisoresSection = document.getElementById('EmisoresSection');
    if (emisoresSection.style.display === 'none') {
        emisoresSection.style.display = 'block';
        document.getElementById('mostrarEmisoresButton').innerText = 'Ocultar Emisores';
    } else {
        emisoresSection.style.display = 'none';
        document.getElementById('mostrarEmisoresButton').innerText = 'Mostrar Emisores';
    }
}

*/

function autocompletarEmisor(index) {
    const emisor = window.emisores[index];

    if (emisor) {
        document.getElementById('NIT').value = emisor.nit || '';
        document.getElementById('nrc').value = emisor.nrc || '';
        document.getElementById('nombre').value = emisor.nombre || '';
        document.getElementById('codActividad').value = emisor.codActividad || '';
        document.getElementById('descActividad').value = emisor.descActividad || '';
        document.getElementById('nombreComercial').value = emisor.nombreComercial || '';
        document.getElementById('departamento').value= emisor.departamento || '';
        document.getElementById('municipio').value = emisor.direccion.municipio || '';
        document.getElementById('complemento').value = emisor.direccion.complemento || '';
        document.getElementById('telefono').value = emisor.telefono || '';
        document.getElementById('correo').value = emisor.correo || '';
        //document.getElementById('tipoEstablecimiento').value = emisor.tipoEstablecimiento || '';
        /*document.getElementById('codEstableMH').value = emisor.codEstableMH || '';
        document.getElementById('codEstable').value = emisor.codEstable || '';
        document.getElementById('codPuntoVentaMH').value = emisor.codPuntoVentaMH || '';
        document.getElementById('codPuntoVenta').value = emisor.codPuntoVenta || '';*/

        /* Autocompletar departamento

        const departamentoSelect = document.getElementById('departamento');
        const departamentoValue = emisor.direccion.departamento;
        let optionExists = false;

        for (let i = 0; i < departamentoSelect.options.length; i++) {
            if (departamentoSelect.options[i].value === departamentoValue) {
                optionExists = true;
                break;
            }
        }

        if (!optionExists) {
            const newOption = document.createElement('option');
            newOption.value = departamentoValue;
            newOption.text = `Departamento ${departamentoValue}`;
            departamentoSelect.appendChild(newOption);
        }

        departamentoSelect.value = departamentoValue;
        */
    } else {
        console.error('Emisor no encontrado para el índice:', index);
    }
        
}

//envio de emisor
async function createEmisor() {
    const emisorData = {
        nit: document.getElementById('nit').value,
        nrc: document.getElementById('nrc').value,
        nombre: document.getElementById('nombre').value,
        codActividad: document.getElementById('codActividad').value,
        descActividad: document.getElementById('descActividad').value,
        nombreComercial: document.getElementById('nombreComercial').value,
        tipoEstablecimiento: document.getElementById('tipoEstablecimiento').value,
        departamento: document.getElementById('departamento').value,
        municipio: document.getElementById('municipio').value,
        complemento: document.getElementById('complemento').value,
        telefono: document.getElementById('telefono').value,
        correo: document.getElementById('correo').value,
        codEstableMH: document.getElementById('codEstableMH').value,
        codEstable: document.getElementById('codEstable').value,
        codPuntoVentaMH: document.getElementById('codPuntoVentaMH').value,
        codPuntoVenta: document.getElementById('codPuntoVenta').value,
        FechaCreacion: new Date().toISOString()
    };

    const newRow = [
        emisorData.nit,
        emisorData.nrc,
        emisorData.nombre,
        emisorData.codActividad,
        emisorData.descActividad,
        emisorData.nombreComercial,
        emisorData.tipoEstablecimiento,
        emisorData.departamento,
        emisorData.municipio,
        emisorData.complemento,
        emisorData.telefono,
        emisorData.correo,
        emisorData.codEstableMH,
        emisorData.codEstable,
        emisorData.codPuntoVentaMH,
        emisorData.codPuntoVenta,
        emisorData.FechaCreacion
    ];

    const sheetName = 'h.emisor';
    sendDataToSheet(sheetName, newRow);
}

document.getElementById('emisorForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir el envío del formulario por defecto

    // Llamar a la función createEmisor para enviar los datos del nuevo emisor
    createEmisor();
});

// Event listener para el formulario del Receptor
document.getElementById('receptorForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir el envío del formulario por defecto
    createReceptor();
});

//envio de receptor
// Función para recopilar los datos del formulario del Receptor
function collectReceptorFormData() {
    const data = {
        nit: document.getElementById('nitReceptor').value,
        nrc: document.getElementById('nrc').value,
        nombre: document.getElementById('nombreReceptor').value,
        codActividad: document.getElementById('codActividad').value,
        descActividad: document.getElementById('descActividad').value,
        nombreComercial: document.getElementById('nombreComercial').value,
        departamento: document.getElementById('departamentoReceptor').value,
        municipio: document.getElementById('municipioReceptor').value,
        complemento: document.getElementById('complemento').value,
        telefono: document.getElementById('telefono').value,
        correo: document.getElementById('correoReceptor').value,
        FechaCreacion: new Date().toISOString()
    };
    return data;
}

// Función para crear un nuevo receptor
async function createReceptor() {
    const receptorData = collectReceptorFormData();

    const newRow = Object.values(receptorData);
    const sheetName = 'h.receptor';
    sendDataToSheet(sheetName, newRow);
}

async function cargarReceptoresDesdeGoogleSheets() {
    try {
        const response = await gapi.client.sheets.spreadsheets.values.get({
            spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
            range: 'h.receptor!A:L', // Asegúrate de que este rango cubra todas las columnas necesarias.
        });

        const rows = response.result.values;
        if (rows && rows.length > 0) {
            console.log('Datos recibidos:', rows); // Log de los datos recibidos
            const receptores = rows.slice(1).map(row => ({
                nit: row[0],
                nrc: row[1],
                nombre: row[2],
                codActividad: row[3],
                descActividad: row[4],
                nombreComercial: row[5],
                tipoEstablecimiento: row[6],
                direccion: {
                    departamento: row[7],
                    municipio: row[8],
                    complemento: row[9],
                },
                telefono: row[10],
                correo: row[11],
            }));
            //llenarTablaEmisores(emisores);
            llenarSelectReceptores(receptores);
        } else {
            console.log('No se encontraron datos.');
            alert('No se encontraron datos en la hoja especificada.');
        }
    } catch (err) {
        console.error('The API returned an error: ', err);
        alert('Hubo un error al obtener los datos: ' + err.message);
    }
}

// Función para llenar el select con emisores
function llenarSelectReceptores(receptores) {
    const receptorSelect = document.getElementById('receptorSelect');
    receptorSelect.innerHTML = '<option value="" disabled selected>Seleccionar Receptor</option>'; // Limpiar el select

    receptores.forEach((receptor, index) => {
        let option = document.createElement('option');
        option.value = index;
        option.text = receptor.nombre;
        receptorSelect.appendChild(option);
    });

    // Asociar evento onchange al select
    receptorSelect.addEventListener('change', function() {
        autocompletarReceptor(parseInt(this.value)); // Llama a autocompletarEmisor con el índice seleccionado convertido a entero
    });

    // Guardar los emisores en una variable global para acceder a ellos en la función autocompletarEmisor
    window.receptores = receptores;
}

function autocompletarReceptor(index) {
    const receptor = window.receptores[index];

    if (receptor) {
        document.getElementById('nitReceptor').value = receptor.nit || '';
        document.getElementById('nrcReceptor').value = receptor.nrc || '';
        document.getElementById('nombreReceptor').value = receptor.nombre || '';
        document.getElementById('codActividadReceptor').value = receptor.codActividad || '';
        document.getElementById('descActividadReceptor').value = receptor.descActividad || '';
        document.getElementById('nombreComercialReceptor').value = receptor.nombreComercial || '';
        document.getElementById('departamentoReceptor').value = receptor.departamento || '';
        document.getElementById('municipioReceptor').value = receptor.direccion.municipio || '';
        document.getElementById('complementoReceptor').value = receptor.direccion.complemento || '';
        document.getElementById('telefonoReceptor').value = receptor.telefono || '';
        document.getElementById('correoReceptor').value = receptor.correo || '';
      
        /* Autocompletar departamento

        const departamentoSelect = document.getElementById('departamento');
        const departamentoValue = emisor.direccion.departamento;
        let optionExists = false;

        for (let i = 0; i < departamentoSelect.options.length; i++) {
            if (departamentoSelect.options[i].value === departamentoValue) {
                optionExists = true;
                break;
            }
        }

        if (!optionExists) {
            const newOption = document.createElement('option');
            newOption.value = departamentoValue;
            newOption.text = `Departamento ${departamentoValue}`;
            departamentoSelect.appendChild(newOption);
        }

        departamentoSelect.value = departamentoValue;
        */
    } else {
        console.error('Emisor no encontrado para el índice:', index);
    }
        
}

// Arreglo para almacenar los detalles ingresados
let detallesIngresados = [];

// Función para agregar un detalle a la tabla de detalles ingresados
async function agregarDetalle() {
    // Obtener los valores del formulario
    const cantidad = document.getElementById('cantidad').value;
    const descripcion = document.getElementById('descripcion').value;
    const precio = document.getElementById('precio').value;
    const ventasNoSujetas = document.getElementById('ventasNoSujetas').value;
    const ventasExentas = document.getElementById('ventasExentas').value;
    const ventasAfectas = document.getElementById('ventasAfectas').value;

    // Validar que se ingresen todos los campos
    if (cantidad && descripcion && precio && ventasNoSujetas && ventasExentas && ventasAfectas) {
        // Crear objeto con los detalles del formulario
        const detalle = {
            cantidad,
            descripcion,
            precio,
            ventasNoSujetas,
            ventasExentas,
            ventasAfectas
        };

        // Agregar el detalle al arreglo de detalles ingresados
        detallesIngresados.push(detalle);

        // Limpiar los campos del formulario
        document.getElementById('cantidad').value = '';
        document.getElementById('descripcion').value = '';
        document.getElementById('precio').value = '';
        document.getElementById('ventasNoSujetas').value = '';
        document.getElementById('ventasExentas').value = '';
        document.getElementById('ventasAfectas').value = '';

        // Mostrar los detalles ingresados en la tabla
        mostrarDetallesIngresados();

        // Enviar los datos a Google Sheets
        await enviarDetalleAGoogleSheets(detalle);
    } else {
        alert('Por favor complete todos los campos.');
    }
}
// Función para mostrar los detalles ingresados en la tabla
function mostrarDetallesIngresados() {
    const detallesBody = document.getElementById('detallesIngresadosBody');
    detallesBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos detalles

    detallesIngresados.forEach(detalle => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${detalle.cantidad}</td>
            <td>${detalle.descripcion}</td>
            <td>${detalle.precio}</td>
            <td>${detalle.ventasNoSujetas}</td>
            <td>${detalle.ventasExentas}</td>
            <td>${detalle.ventasAfectas}</td>
        `;
        detallesBody.appendChild(row);
    });
}

// Función para enviar el detalle a Google Sheets
async function enviarDetalleAGoogleSheets(detalle) {
    const values = [
        [detalle.cantidad, detalle.descripcion, detalle.precio, detalle.ventasNoSujetas, detalle.ventasExentas, detalle.ventasAfectas]
    ];

    try {
        const response = await gapi.client.sheets.spreadsheets.values.append({
            spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
            range: 'h.detalles!A:G', // Ajusta el rango según tu necesidad
            valueInputOption: 'USER_ENTERED',
            resource: {
                values: values
            }
        });
        console.log('Detalle enviado a Google Sheets:', response);
    } catch (err) {
        console.error('Error al enviar detalle a Google Sheets:', err);
    }
}
