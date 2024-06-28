let lastToken;
let emisor;
let receptor;
let token;

// Función para obtener el último token desde el backend
async function getLastToken() {
    try {
      const response = await fetch('../api/get_last_token.php');
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      const data = await response.json();
      const lastToken = data.tokenActual;
      const tokenDate = new Date(data.fechaGeneracion);
      const currentDate = new Date();

      console.log('Último token obtenido:', lastToken);

      // Mostrar el token en la tabla
      const tableBody = document.getElementById('lastTokenTableBody');
      if (tableBody) {
        tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos
        const tr = document.createElement('tr');
        const statusCell = document.createElement('td');
        const tokenCell = document.createElement('td');
        const dateCell = document.createElement('td');

        // Calcular la diferencia en horas entre la fecha del token y la fecha actual
        const timeDifference = currentDate - tokenDate;
        const hoursDifference = timeDifference / (1000 * 60 * 60);

        // Crear el botón sobre el estado del token
        const button = document.createElement('button');
        if (hoursDifference > 24) {
          button.innerText = 'Caducado';
          button.className = 'btn btn-danger';
          statusCell.classList.add('token-caducado');
        } else {
          button.innerText = 'Vigente';
          button.className = 'btn btn-success';
          statusCell.classList.add('token-vigente');
        }
        statusCell.appendChild(button);

        dateCell.innerText = tokenDate.toLocaleString();
        tokenCell.innerText = lastToken;

        tr.appendChild(dateCell);
        tr.appendChild(statusCell);
        tr.appendChild(tokenCell);
        tableBody.appendChild(tr);

        document.getElementById("lastTokenSection").style.display = "block"; // Mostrar la sección
      } else {
        console.error('Elemento lastTokenTableBody no encontrado.');
      }
    } catch (err) {
      console.error('Error al obtener el último token:', err);
    }
  }

  document.addEventListener('DOMContentLoaded', getLastToken);

  document.getElementById('tokenForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir el envío del formulario por defecto

    // Obtener los valores de los campos del formulario
    const nit = document.getElementById('nit').value;
    const password = document.getElementById('password').value;

    // Realizar la solicitud a la API externa
    const url = 'https://apitest.dtes.mh.gob.sv/seguridad/auth'; // URL de la API externa
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
      const tokenActual = jsonResponse.body.token.toString(); // Convertir el token en una cadena de texto

      // Obtener la fecha de creación
      const fechaGeneracion = new Date().toISOString();

      // Enviar el token al servidor para guardarlo en la base de datos
      const postData = { tokenActual, fechaGeneracion };
      

      fetch('../api/save_token.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(postData)
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        console.log('Token guardado:', data);
        alert('Token guardado exitosamente');
        // Refrescar la tabla de tokens
        getLastToken();
      })
      .catch(error => {
        console.error('Error al guardar el token:', error);
        alert('Hubo un problema al guardar el token.');
      });

    })
    .catch(error => {
      // Aquí manejas los errores
      console.error('There was a problem with the fetch operation:', error);
      alert('Hubo un problema con la autenticación.');
    });
  });

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




//inicio
function showEmisor() {
    hideAllSections();
    document.getElementById("emisorSection").style.display = "block";
  }
  
  function showReceptor() {
    hideAllSections();
    document.getElementById("receptorSection").style.display = "block";
  }
  
  function showDetalles() {
    hideAllSections();
    document.getElementById("detallesSection").style.display = "block";
  }
  
  function showToken() {
    hideAllSections();
    document.getElementById("tokenSection").style.display = "block";
  }
  
  function showTiposdeDocumento() {
    hideAllSections();
    document.getElementById("TiposdeDocumentoSection").style.display = "block";
  }
  
  function hideAllSections() {
    document.getElementById("emisorSection").style.display = "none";
    document.getElementById("receptorSection").style.display = "none";
    document.getElementById("detallesSection").style.display = "none";
    document.getElementById("tokenSection").style.display = "none";
    document.getElementById("TiposdeDocumentoSection").style.display = "none";
  }
  
  let currentSectionIndex = 0;
  const sectionIds = [
    "tokenSection",
    "TiposdeDocumentoSection",
    "emisorSection",
    "receptorSection",
    "detallesSection",
  ];
  
  function showSection(index) {
    for (let i = 0; i < sectionIds.length; i++) {
      document.getElementById(sectionIds[i]).style.display =
        i === index ? "block" : "none";
    }
    currentSectionIndex = index;
  }
  
  function navigate(direction) {
    if (direction === "forward" && currentSectionIndex < sectionIds.length - 1) {
      showSection(currentSectionIndex + 1);
    } else if (direction === "backward" && currentSectionIndex > 0) {
      showSection(currentSectionIndex - 1);
    }
  }
  
  // Mostrar la primera sección al cargar la página
  showSection(currentSectionIndex);