let lastToken;
let emisor;
let receptor;
let token;

let codigoGiroGlobal = null;
let nombreGiroGlobal = null;
let codigoGiroGlobalReceptor = null;
let nombreGiroGlobalReceptor = null;

document.addEventListener('DOMContentLoaded', function() {
    // Cargar datos de emisor y receptor
    loadEmisorData();
    loadReceptorData();
    getLastToken();    
    showSection('tokenSection');

    // Cargar departamentos al inicio para el emisor y receptor
    loadDepartamentos('departamentoEmisorInicio');
    loadDepartamentos('departamentoReceptor');

    // Evento para cargar municipios del emisor al seleccionar un departamento
    document.getElementById('departamentoEmisorInicio').addEventListener('change', function() {
        const departamentoId = this.value;
        loadMunicipios(departamentoId, 'municipioEmisorInicio');
    });

    // Evento para cargar municipios del receptor al seleccionar un departamento
    document.getElementById('departamentoReceptor').addEventListener('change', function() {
        const departamentoId = this.value;
        loadMunicipios(departamentoId, 'municipioReceptor');
    });

    // Llamar a loadGirosComerciales después de cargar todo lo necesario
    setTimeout(() => {
        loadGirosComerciales('giroComercialInicio');
        loadGirosComerciales('giroComercialReceptor');
    }, 500); // Esperar un tiempo prudente para asegurar que los elementos se han cargado

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

// Función para obtener el último token desde el backend
async function getLastToken() {
    try {
      const response = await fetch('../api/get_last_token.php');
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      const data = await response.json();
       lastToken = data.tokenActual;
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
      .then(async response => {
          const emisor = response.data;
          console.log("Datos del emisor:", emisor);
          document.getElementById('razonSocial').value = emisor.razonSocial;
          document.getElementById('nombreComercial').value = emisor.nombreComercial;
          document.getElementById('nitEmisor').value = emisor.nit;
          document.getElementById('nrc').value = emisor.nrc;
          document.getElementById('telefono').value = emisor.telefono;
          document.getElementById('correo').value = emisor.correoElectronico;
          document.getElementById('direccion').value = emisor.direccion;
          document.getElementById('giroComercialInicio').value = emisor.idGiroComercial;
          document.getElementById('tipoEstablecimiento').value = emisor.tipoEstablecimiento;

          // Guardar codigoGiro y nombreGiro en variables globales
          codigoGiroGlobal = emisor.codigoGiroComercial;
          nombreGiroGlobal = emisor.nombreGiroComercial;
          console.log(codigoGiroGlobal);
          console.log(nombreGiroGlobal);

          // Cargar y seleccionar el departamento y municipio
          const departamentoId = emisor.idDepartamento;
          const municipioId = emisor.idMunicipio;

          // Seleccionar el departamento
          const departamentoSelect = document.getElementById('departamentoEmisorInicio');
          departamentoSelect.value = departamentoId;

          // Cargar y seleccionar el municipio
          await loadMunicipios(departamentoId, 'municipioEmisorInicio');
          document.getElementById('municipioEmisorInicio').value = municipioId;
      })
      .catch(error => console.error('Error al obtener los datos del emisor:', error));
}

function loadReceptorData() {
    // Reemplazar la URL con la correcta para obtener los datos de los receptores
    axios.get('../api/get_clientes.php')
        .then(response => {
            const receptores = response.data;
            console.log('Datos de receptores:', receptores);
            const receptorSelect = document.getElementById('receptorSelect');
            receptores.forEach(receptor => {
                const option = document.createElement('option');
                option.value = receptor.id;
                option.textContent = receptor.nombreCliente;
                receptorSelect.appendChild(option);
            });
        })
        .catch(error => console.error('Error al cargar los receptores:', error));
}

function populateReceptorForm(receptorId) {
    axios.get(`../api/get_cliente.php?id=${receptorId}`)
        .then(async response => {
            const receptor = response.data;
            console.log("Datos del receptor:", receptor);
            document.getElementById('NombreCliente').value = receptor.nombreCliente;
            document.getElementById('nombreComercialReceptor').value = receptor.nombreComercial;
            document.getElementById('nitReceptor').value = receptor.nitDui;
            document.getElementById('nrcReceptor').value = receptor.nrc;
            document.getElementById('telefonoReceptor').value = receptor.telefono;
            document.getElementById('giroComercialReceptor').value = receptor.idGiroComercial;

            document.getElementById('correoReceptor').value = receptor.correoElectronico;
            document.getElementById('direccionReceptor').value = receptor.direccion;

            // Cargar y seleccionar el departamento y municipio
            const departamentoId = receptor.idDepartamento;
            const municipioId = receptor.idMunicipio;

            // Guardar codigoGiro y nombreGiro en variables globales
            codigoGiroGlobalReceptor = receptor.codigoGiroComercial;
            nombreGiroGlobalReceptor = receptor.nombreGiroComercial;
            console.log(codigoGiroGlobalReceptor);
            console.log(nombreGiroGlobalReceptor);

            // Seleccionar el departamento
            const departamentoSelect = document.getElementById('departamentoReceptor');
            departamentoSelect.value = departamentoId;

            // Cargar y seleccionar el municipio
            await loadMunicipios(departamentoId, 'municipioReceptor');
            document.getElementById('municipioReceptor').value = municipioId;
        })
        .catch(error => console.error('Error al obtener los datos del receptor:', error));
}

function showSection(sectionId) {
    const sections = document.querySelectorAll(".section");
    sections.forEach(section => {
        section.style.display = "none";
    });
    
    document.getElementById(sectionId).style.display = "block";
    
    // Condición especial para mostrar lastTokenSection cuando se seleccione tokenSection
    if (sectionId === "tokenSection") {
        document.getElementById("lastTokenSection").style.display = "block";
    }
}

function navigate(direction) {
    const sections = ["tokenSection","TiposdeDocumentoSection","emisorSection" ,"receptorSection", "detallesSection"];
    let currentIndex = sections.findIndex(section => document.getElementById(section).style.display === "block");

    if (direction === 'forward' && currentIndex < sections.length - 1) {
        showSection(sections[currentIndex + 1]);
    } else if (direction === 'backward' && currentIndex > 0) {
        showSection(sections[currentIndex - 1]);
    }
}

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
            option.setAttribute('data-codigo', departamento.codigoDepartamento);
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
            option.setAttribute('data-codigo', municipio.codigoMunicipio);
            option.textContent = municipio.nombreMunicipio;
            municipioSelect.appendChild(option);
        });
    } catch (error) {
        console.error('Error al cargar los municipios:', error);
    }
}

async function loadGirosComerciales(elementId) {
    // Lógica para cargar giros comerciales desde la API
    const response = await fetch('../api/get_giros_comerciales.php');
    const girosComerciales = await response.json();
    const select = document.getElementById(elementId);
    select.innerHTML = '<option value="" disabled selected>Seleccionar uno</option>';

    girosComerciales.forEach(giro => {
        const option = document.createElement('option');
        option.value = giro.id;
        option.textContent = `${giro.codigoGiro} - ${giro.nombreGiro}`;
        select.appendChild(option);
    });
}