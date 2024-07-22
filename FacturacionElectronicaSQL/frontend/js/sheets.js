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

  document.addEventListener('DOMContentLoaded', function() {
    // Cargar datos de emisor y receptor
    loadEmisorData();
    loadReceptorData();

    // Mostrar la sección de emisor por defecto al cargar la página
    showSection('emisorSection');

    // Asociar eventos para los selectores de emisor y receptor
    document.getElementById('emisorSelect').addEventListener('change', function() {
        const emisorId = this.value;
        populateEmisorForm(emisorId);
    });

    document.getElementById('receptorSelect').addEventListener('change', function() {
        const receptorId = this.value;
        populateReceptorForm(receptorId);
    });
});

function loadEmisorData() {
    axios.get('../api/get_emisores.php')
        .then(response => {
            const emisores = response.data;
            const emisorSelect = document.getElementById('emisorSelect');
            emisores.forEach(emisor => {
                const option = document.createElement('option');
                option.value = emisor.id;
                option.textContent = emisor.razonSocial;
                emisorSelect.appendChild(option);
            });
            console.log("Datos de emisores cargados:", emisores);
        })
        .catch(error => console.error('Error al cargar los emisores:', error));
}

function populateEmisorForm(emisorId) {
    axios.get(`../api/get_emisor.php?id=${emisorId}`)
        .then(response => {
            const emisor = response.data;
            console.log("Datos del emisor:", emisor);
            document.getElementById('razonSocial').value = emisor.razonSocial;
            document.getElementById('nombreComercial').value = emisor.nombreComercial;
            document.getElementById('nit').value = emisor.nit;
            document.getElementById('nrc').value = emisor.nrc;
            document.getElementById('telefono').value = emisor.telefono;
            document.getElementById('correo').value = emisor.correoElectronico;
            document.getElementById('municipioEmisor').value = emisor.idMunicipio;
            document.getElementById('direccion').value = emisor.direccion;
            document.getElementById('giroComercial').value = emisor.idGiroComercial;
        })
        .catch(error => console.error('Error al obtener los datos del emisor:', error));
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

document.addEventListener('DOMContentLoaded', function() {
  // Mostrar la sección de token por defecto al cargar la página
  showSection('tokenSection');

  // Cargar datos necesarios al inicio
  getLastToken();
  getTiposDeDocumentos();
  getEmisores();
  getReceptores();

  // Asociar eventos para cambiar de sección
  document.getElementById('showTokenForm').addEventListener('click', function() {
      showSection('tokenSection');
  });

  document.getElementById('showTiposdeDocumentoForm').addEventListener('click', function() {
      showSection('tiposDeDocumentoSection');
  });

  document.getElementById('showEmisorForm').addEventListener('click', function() {
      showSection('emisorSection');
  });

  document.getElementById('showReceptorForm').addEventListener('click', function() {
      showSection('receptorSection');
  });

  // Evento para cargar municipios basados en el departamento seleccionado
  document.getElementById('departamentoEmisor').addEventListener('change', function() {
      const departamentoId = this.value;
      loadMunicipios(departamentoId, 'municipioEmisor');
  });

  document.getElementById('departamentoReceptor').addEventListener('change', function() {
      const departamentoId = this.value;
      loadMunicipios(departamentoId, 'municipioReceptor');
  });

  // Llamar a loadGirosComerciales después de cargar todo lo necesario
  setTimeout(() => {
      loadGirosComerciales('giroComercial');
      loadGirosComerciales('giroComercialReceptor');
  }, 500); // Esperar un tiempo prudente para asegurar que los elementos se han cargado
});





