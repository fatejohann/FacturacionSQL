let lastToken;

//historial de token
async function getToken() {
  let response;
  try {
      response = await gapi.client.sheets.spreadsheets.values.get({
          spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
          range: 'h.token!A:D', // Asegúrate de que este rango cubra todas las columnas necesarias.
      });
  } catch (err) {
      console.error('The API returned an error: ' + err);
      return;
  }

  const rows = response.result.values;
  if (rows.length > 0) {
      const tableBody = document.getElementById('hTokenTableBody');
      tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos.
      // Saltarse la primera fila si contiene los encabezados de las columnas.
      rows.slice(1).forEach((row) => {
          // Crea una fila de tabla por cada registro.
          let tr = `<tr>
                      <td>${row[0]}</td>
                      <td>${row[1]}</td>
                      
                    </tr>`;
          tableBody.innerHTML += tr;
      });
      document.getElementById("H.TokenSection").style.display = "block"; // Mostrar la sección.
  } else {
      document.getElementById('H.TokenSection').innerHTML = '<p>No se encontraron datos.</p>';
  }
}


//historial de emisor
async function getEmisor(){
  let response;
  try {
      response = await gapi.client.sheets.spreadsheets.values.get({
          spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
          range: 'h.emisor!A:Q', // Asegúrate de que este rango cubra todas las columnas necesarias.
      });
  } catch (err) {
      console.error('The API returned an error: ' + err);
      return;
  }

  const rows = response.result.values;
  if (rows.length > 0) {
      const tableBody = document.getElementById('hEmisorTableBody');
      tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos.
      // Saltarse la primera fila si contiene los encabezados de las columnas.
      rows.slice(1).forEach((row) => {
          // Crea una fila de tabla por cada registro.
          let tr = `<tr>
          <td>${row[4]}</td>  <!-- Nombre -->
          <td>${row[5]}</td>  <!-- Comercial -->
          <td>${row[3]}</td>  <!-- Actividad -->
          <td>${row[1]}</td>  <!-- NCR -->
          <td>${row[0]}</td>  <!-- NIT -->
          <td>${row[6]}</td>  <!-- Depto. -->
          <td>${row[7]}</td>  <!-- Muni. -->
          <td>${row[11]}</td> <!-- Correo -->
                      <td class="text-center">
                        <button class="btn btn-dark">Modificar</button>
                        <button class="btn btn-danger">Eliminar</button>
                      </td>
                    </tr>`;
          tableBody.innerHTML += tr;
      });
      document.getElementById("H.EmisorSection").style.display = "none"; // Mostrar la sección.
  } else {
      document.getElementById('H.EmisorSection').innerHTML = '<p>No se encontraron datos.</p>';
  }
}

//historial de receptor
async function getReceptor(){
  let response;
  try {
      response = await gapi.client.sheets.spreadsheets.values.get({
          spreadsheetId: '1J__Pzj8RNIrwlojeF-mjBdWYtt9GH3QH3Je5SamLfSI',
          range: 'h.receptor!A:K', // Asegúrate de que este rango cubra todas las columnas necesarias.
      });
  } catch (err) {
      console.error('The API returned an error: ' + err);
      return;
  }

  const rows = response.result.values;
  if (rows.length > 0) {
      const tableBody = document.getElementById('hReceptorTableBody');
      tableBody.innerHTML = ''; // Limpiar el cuerpo de la tabla antes de agregar nuevos datos.
      // Saltarse la primera fila si contiene los encabezados de las columnas.
      rows.slice(1).forEach((row) => {
          // Crea una fila de tabla por cada registro.
          let tr = `<tr>
                      <td>${row[2]}</td>
                      <td>${row[0]}</td>
                      <td>${row[1]}</td>
                      
                      
                    </tr>`;/*<td class="text-center">
                        <button class="btn btn-dark">Modificar</button>
                        <button class="btn btn-danger">Eliminar</button>
                      </td>*/
          tableBody.innerHTML += tr;
      });
      document.getElementById("H.ReceptorSection").style.display = "none"; 
  } else {
      document.getElementById('H.ReceptorSection').innerHTML = '<p>No se encontraron datos.</p>';
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

//inicio 
function showToken() {
  hideAllSections();
  document.getElementById("H.TokenSection").style.display = "block";
}

function showTiposdeDocumento() {
  hideAllSections();
  document.getElementById("H.TiposDocumentoSection").style.display = "block";
}

function showEmisor() {
  hideAllSections();
  document.getElementById("H.EmisorSection").style.display = "block";
}

function showReceptor() {
  hideAllSections();
  document.getElementById("H.ReceptorSection").style.display = "block";
}

function hideAllSections() {
  document.getElementById("H.TokenSection").style.display = "none";

  document.getElementById("H.TiposDocumentoSection").style.display = "none";

  document.getElementById("H.EmisorSection").style.display = "none";
  
  document.getElementById("H.ReceptorSection").style.display = "none";
}