lastToken;

function cargarFactura(tipoDocumento) {
  let facturaJson = {};

  switch (tipoDocumento) {
    case "FE":
      facturaJson = {
        nit: "06142803901121",
        activo: true,
        passwordPri: "Rr2Ll3rm0@$ñ@",
        dteJson: {
          identificacion: {
            version: 1,
            ambiente: "00",
            tipoDte: "01",
            numeroControl: "DTE-01-0001ONEC-000000000005038",
            codigoGeneracion: "48634903-FC58-45F9-9173-F9206D016489",
            tipoModelo: 1,
            tipoOperacion: 1,
            tipoContingencia: null,
            motivoContin: null,
            fecEmi: "2024-03-21",
            horEmi: "19:30:00",
            tipoMoneda: "USD",
          },
          documentoRelacionado: null,
          emisor: {
            nit: "06142803901121",
            nrc: "2398810",
            nombre: "JUAN MANUEL REYES",
            codActividad: "73100",
            descActividad: "Publicidad",
            nombreComercial: null,
            tipoEstablecimiento: "01",
            direccion: {
              departamento: "06",
              municipio: "14",
              complemento: "San Salvador",
            },
            telefono: "2281-8000",
            codEstableMH: "0000",
            codEstable: "0000",
            codPuntoVentaMH: "0000",
            codPuntoVenta: "0000",
            correo: "mentesbrillantesagencia@gmail.com",
          },
          receptor: {
            tipoDocumento: "36",
            numDocumento: "06142803901121",
            nrc: null,
            nombre: "Luis Del Cid",
            codActividad: null,
            descActividad: null,
            direccion: {
              departamento: "06",
              municipio: "14",
              complemento: "SAN SALVADOR",
            },
            telefono: "78291734",
            correo: "gj23726116@gmail.com",
          },
          otrosDocumentos: null,
          ventaTercero: null,
          cuerpoDocumento: [
            {
              numItem: 1,
              tipoItem: 2,
              numeroDocumento: null,
              cantidad: 1,
              codigo: null,
              codTributo: null,
              uniMedida: 99,
              descripcion: "EMISIÓN DE CERTIFICADOS DE FIRMA ELECTRÓNICA 1",
              precioUni: 100,
              montoDescu: 0,
              ventaNoSuj: 0,
              ventaExenta: 0,
              ventaGravada: 100,
              tributos: null,
              psv: 0,
              noGravado: 5,
              ivaItem: 11.5,
            },
            {
              numItem: 2,
              tipoItem: 2,
              numeroDocumento: null,
              cantidad: 1,
              codigo: null,
              codTributo: null,
              uniMedida: 99,
              descripcion: "EMISIÓN DE CERTIFICADOS DE FIRMA ELECTRÓNICA 2",
              precioUni: 25,
              montoDescu: 25,
              ventaNoSuj: 0,
              ventaExenta: 0,
              ventaGravada: 0,
              tributos: null,
              psv: 0,
              noGravado: 0,
              ivaItem: 0,
            },
          ],
          resumen: {
            totalNoSuj: 0,
            totalExenta: 0,
            totalGravada: 100,
            subTotalVentas: 100,
            descuNoSuj: 0,
            descuExenta: 0,
            descuGravada: 0,
            porcentajeDescuento: 0,
            totalDescu: 25,
            tributos: null,
            subTotal: 100,
            ivaRete1: 0,
            reteRenta: 0,
            montoTotalOperacion: 100,
            totalNoGravado: 5,
            totalPagar: 105,
            totalLetras: "pendiente",
            totalIva: 11.5,
            saldoFavor: -500,
            condicionOperacion: 1,
            pagos: [
              {
                codigo: "01",
                montoPago: 50,
                referencia: null,
                plazo: null,
                periodo: null,
              },
              {
                codigo: "03",
                montoPago: 25,
                referencia: null,
                plazo: null,
                periodo: null,
              },
              {
                codigo: "99",
                montoPago: 25,
                referencia: null,
                plazo: null,
                periodo: null,
              },
            ],
            numPagoElectronico: null,
          },
          extension: {
            nombEntrega: null,
            docuEntrega: null,
            nombRecibe: null,
            docuRecibe: null,
            observaciones: null,
            placaVehiculo: null,
          },
          apendice: null,
        },
      };
      break;
    case "CCF":
      facturaJson = {
        nit: "06142803901121",
        activo: true,
        passwordPri: "Rr2Ll3rm0@$ñ@",
        dteJson: {
          identificacion: {
            version: 3,
            ambiente: "00",
            tipoDte: "03",
            numeroControl: "DTE-03-0001ONEC-000000000005051",
            codigoGeneracion: "D7A32E8C-06C0-41A2-9E2F-A094C994AFDE",
            tipoModelo: 1,
            tipoOperacion: 1,
            tipoContingencia: null,
            motivoContin: null,
            fecEmi: "2024-02-21",
            horEmi: "20:00:00",
            tipoMoneda: "USD",
          },
          documentoRelacionado: null,
          emisor: {
            nit: "06142803901121",
            nrc: "2398810",
            nombre: "JUAN MANUEL REYES",
            codActividad: "73100",
            descActividad: "publicidad",
            nombreComercial: null,
            tipoEstablecimiento: "01",
            direccion: {
              departamento: "06",
              municipio: "14",
              complemento: "San Salvador",
            },
            telefono: "2281-8000",
            correo: "mentesbrillantesagencia@gmail.com",
            codEstableMH: "0000",
            codEstable: "0000",
            codPuntoVentaMH: "0000",
            codPuntoVenta: "0000",
          },
          receptor: {
            nit: "06142803901121",
            nrc: "2398810",
            nombre: "Gerardo juárez",
            codActividad: "73100",
            descActividad: "publicidad",
            nombreComercial: null,
            direccion: {
              departamento: "06",
              municipio: "14",
              complemento: "San Salvador",
            },
            telefono: null,
            correo: "gj23726116@gmail.com",
          },
          otrosDocumentos: null,
          ventaTercero: null,
          cuerpoDocumento: [
            {
              numItem: 1,
              tipoItem: 1,
              numeroDocumento: null,
              codigo: "37578",
              codTributo: null,
              descripcion: "Shampoo Pantene",
              cantidad: 2.0,
              uniMedida: 59,
              precioUni: 10.0,
              montoDescu: 0.0,
              ventaNoSuj: 0.0,
              ventaExenta: 0.0,
              ventaGravada: 20.0,
              tributos: ["20"],
              psv: 0.0,
              noGravado: 0.0,
            },
            {
              numItem: 2,
              tipoItem: 1,
              numeroDocumento: null,
              codigo: "63840",
              codTributo: null,
              descripcion: "Jamon de pavo Vita",
              cantidad: 3.0,
              uniMedida: 1,
              precioUni: 1.25,
              montoDescu: 0.0,
              ventaNoSuj: 0.0,
              ventaExenta: 0.0,
              ventaGravada: 3.75,
              tributos: ["20"],
              psv: 0.0,
              noGravado: 0.0,
            },
            {
              numItem: 3,
              tipoItem: 1,
              numeroDocumento: null,
              codigo: "149801",
              codTributo: null,
              descripcion: "Cafe Instantaneo Mussun",
              cantidad: 1.0,
              uniMedida: 59,
              precioUni: 2.0,
              montoDescu: 0.0,
              ventaNoSuj: 0.0,
              ventaExenta: 0.0,
              ventaGravada: 2.0,
              tributos: ["20"],
              psv: 0.0,
              noGravado: 0.0,
            },
          ],
          resumen: {
            totalNoSuj: 0.0,
            totalExenta: 0.0,
            totalGravada: 25.75,
            subTotalVentas: 25.75,
            descuNoSuj: 0.0,
            descuExenta: 0.0,
            descuGravada: 0.0,
            porcentajeDescuento: 0.0,
            totalDescu: 0.0,
            tributos: [
              {
                codigo: "20",
                descripcion: "Impuesto al Valor Agregado 13%",
                valor: 3.35,
              },
            ],
            subTotal: 25.75,
            ivaPerci1: 0.0,
            ivaRete1: 0.0,
            reteRenta: 0.0,
            montoTotalOperacion: 29.1,
            totalNoGravado: 0.0,
            totalPagar: 29.1,
            totalLetras: "VEINTINUEVE DOLARES CON 10 CENTAVOS USD",
            saldoFavor: 0.0,
            condicionOperacion: 1,
            pagos: null,
            numPagoElectronico: null,
          },
          extension: {
            nombEntrega: null,
            docuEntrega: null,
            nombRecibe: null,
            docuRecibe: null,
            observaciones: null,
            placaVehiculo: null,
          },
          apendice: null,
        },
      };
      break;
    // Puedes agregar más casos según necesites
    default:
      console.error("Tipo de documento no soportado");
      break;
  }

  return facturaJson;
}

document.addEventListener("DOMContentLoaded", function () {
  document
    .getElementById("submitDocumentButton")
    .addEventListener("click", async function () {
      try {
        const documentoSeleccionado =
          document.getElementById("documentType").value;
        let facturaJson = cargarFactura(documentoSeleccionado);

        let tipoDte = facturaJson.dteJson.identificacion.tipoDte;

        // Generar el nuevo número de control
        const nuevoNumeroControl = generarNuevoNumeroControl(
          facturaJson.dteJson.identificacion.numeroControl,
          tipoDte
        );

        // Sobreescribir el número de control en el JSON original
        facturaJson.dteJson.identificacion.numeroControl = nuevoNumeroControl;

        // Generar el nuevo código de generación
        facturaJson.dteJson.identificacion.codigoGeneracion = generarUUID();

        // Modifica el JSON según sea necesario
        facturaJson.dteJson.identificacion.fecEmi = new Date()
          .toISOString()
          .split("T")[0]; // Actualiza la fecha de emisión
        facturaJson.dteJson.identificacion.horEmi =
          new Date().toLocaleTimeString("en-GB"); // Actualiza la hora de emisión

        //Capturar y actualizar datos de Emisor
        const datosEmisor = capturarDatosEmisor();
        facturaJson.dteJson.emisor.nit = datosEmisor.nit;
        facturaJson.dteJson.emisor.nrc = datosEmisor.nrc;
        facturaJson.dteJson.emisor.nombre = datosEmisor.nombre;
        facturaJson.dteJson.emisor.codActividad = datosEmisor.codActividad;
        facturaJson.dteJson.emisor.descActividad = datosEmisor.descActividad;
        facturaJson.dteJson.emisor.nombreComercial =
          datosEmisor.nombreComercial;
        facturaJson.dteJson.emisor.direccion.departamento =
          datosEmisor.departamento;
        facturaJson.dteJson.emisor.direccion.municipio = datosEmisor.municipio;
        facturaJson.dteJson.emisor.direccion.complemento =
          datosEmisor.complemento;
        facturaJson.dteJson.emisor.telefono = datosEmisor.telefono;
        facturaJson.dteJson.emisor.correo = datosEmisor.correo;

        //facturaJson.dteJson.emisor.tipoEstablecimiento = datosEmisor.tipoEstablecimiento;
        /*facturaJson.dteJson.emisor.codEstableMH = datosEmisor.codEstableMH;
facturaJson.dteJson.emisor.codEstable = datosEmisor.codEstable;
facturaJson.dteJson.emisor.codPuntoVentaMH = datosEmisor.codPuntoVentaMH;
facturaJson.dteJson.emisor.codPuntoVenta = datosEmisor.codPuntoVenta;*/

        // Capturar y actualizar datos de Receptor
        const datosReceptor = capturarDatosReceptor();
        facturaJson.dteJson.receptor.nit = datosReceptor.nit;
        facturaJson.dteJson.receptor.nrc = datosReceptor.nrc;
        facturaJson.dteJson.receptor.nombre = datosReceptor.nombre;
        facturaJson.dteJson.receptor.codActividad = datosReceptor.codActividad;
        facturaJson.dteJson.receptor.descActividad =
          datosReceptor.descActividad;
        facturaJson.dteJson.receptor.nombreComercial =
          datosReceptor.nombreComercial;
        facturaJson.dteJson.receptor.direccion.departamento =
          datosReceptor.departamento;
        facturaJson.dteJson.receptor.direccion.municipio =
          datosReceptor.municipio;
        facturaJson.dteJson.receptor.direccion.complemento =
          datosReceptor.complemento;
        facturaJson.dteJson.receptor.telefono = datosReceptor.telefono;
        facturaJson.dteJson.receptor.correo = datosReceptor.correo;

        // Envía la factura
        await enviarFactura(facturaJson, documentoSeleccionado);
      } catch (error) {
        console.error("Error en el proceso de envío:", error);
        alert("Error en el proceso de envío");
      }
    });
});

async function enviarFactura(facturaJson, documentoSeleccionado) {
  try {
    const responseFirmar = await fetch(
      "https://localhost:8113/firmardocumento/",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "*/*",
          Connection: "keep-alive",
          "Accept-Encoding": "gzip, deflate, br",
          "User-Agent": "PostmanRuntime/7.39.0",
        },
        body: JSON.stringify(facturaJson),
      }
    );

    if (!responseFirmar.ok) {
      throw new Error("Error en la respuesta de firmardocumento");
    }

    const dataFirmar = await responseFirmar.json();
    console.log("Respuesta de firmardocumento:", dataFirmar);

    const documentoFirmado = dataFirmar.body;

    const dte = {
      ambiente: "00",
      idEnvio: 1,
      version: facturaJson.dteJson.identificacion.version,
      tipoDte: facturaJson.dteJson.identificacion.tipoDte,
      documento: documentoFirmado,
    };

    const responseRecepcion = await fetch(
      "https://apitest.dtes.mh.gob.sv/fesv/recepciondte",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "User-Agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36 Edg/125.0.0.0",
          Authorization: lastToken, // Utilizar el token almacenado
        },
        body: JSON.stringify(dte),
      }
    );

    const responseText = await responseRecepcion.text(); // Obtener la respuesta como texto
    console.log("Respuesta de recepciondte:", responseText);

    if (!responseRecepcion.ok) {
      throw new Error(`Error en la respuesta de recepciondte: ${responseText}`);
    }

    const dataRecepcion = JSON.parse(responseText); // Parsear la respuesta si fue exitosa
    console.log("Respuesta de recepciondte (JSON):", dataRecepcion);

    // Extraer los datos necesarios de la respuesta
    const estado = dataRecepcion.estado;
    const selloRecibido = dataRecepcion.selloRecibido;
    const codigoGeneracion = dataRecepcion.codigoGeneracion;
    const fechaEmitido = facturaJson.dteJson.identificacion.fecEmi; // Utilizar la fecha de emisión del documento

    // Obtener la fecha de creación
    const fechaCreacion = new Date().toISOString();

    // Crear un arreglo con los datos a enviar a la hoja de Google Sheets
    const dataToSend = [
      fechaCreacion,
      estado,
      selloRecibido,
      codigoGeneracion,
      fechaEmitido,
      documentoSeleccionado,
    ];

    // Llamar a la función para enviar los datos a la hoja de Google Sheets
    sendDataToSheet("h.TiposDeDocumento", dataToSend);

    alert("Factura enviada con éxito");
  } catch (error) {
    console.error("Error al enviar la factura:", error);
    alert("Error al enviar la factura");
  }
}

function generarNuevoNumeroControl(numeroControlActual, tipodte) {
  // Extraer el número actual del formato
  const partes = numeroControlActual.split("-");
  let numero = parseInt(partes[3], 10);

  // Incrementar el número en uno
  numero += 1;

  // Formatear el nuevo número de control
  const nuevoNumeroControl = `DTE-${pad(tipodte, 2)}-0001ONEC-${pad(
    numero.toString(),
    15,
    "0"
  )}`;

  // Imprimir el nuevo número de control generado
  console.log("Nuevo número de control:", nuevoNumeroControl);

  return nuevoNumeroControl;
}

// Función auxiliar para rellenar con ceros a la izquierda
function pad(valor, longitud, caracter = "0") {
  return valor.toString().padStart(longitud, caracter);
}

function generarUUID() {
  // Generar un UUID utilizando el formato RFC4122 version 4 (aleatorio)
  return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    .replace(/[xy]/g, function (c) {
      const r = (Math.random() * 16) | 0;
      const v = c == "x" ? r : (r & 0x3) | 0x8;
      return v.toString(16);
    })
    .toUpperCase();
}

// Capturar datos de los formularios y actualizar JSON
//deben ser siempre los mismos(los de juan)
function capturarDatosEmisor() {
  return {
    nit: document.getElementById("NIT").value,
    nrc: document.getElementById("nrc").value,
    nombre: document.getElementById("nombre").value,
    codActividad: document.getElementById("codActividad").value,
    descActividad: document.getElementById("descActividad").value,
    nombreComercial: document.getElementById("nombreComercial").value,
    departamento: document.getElementById("departamento").value,
    municipio: document.getElementById("municipio").value,
    complemento: document.getElementById("complemento").value,
    telefono: document.getElementById("telefono").value,
    correo: document.getElementById("correo").value
    //tipoEstablecimiento: document.getElementById("tipoEstablecimiento").value,
   /* codEstableMH: document.getElementById("codEstableMH").value,
    codEstable: document.getElementById("codEstable").value,
    codPuntoVentaMH: document.getElementById("codPuntoVentaMH").value,
    codPuntoVenta: document.getElementById("codPuntoVenta").value,*/
  };
}

function capturarDatosReceptor() {
  return {
    nit: document.getElementById("nitReceptor").value,
    nrc: document.getElementById("nrc").value,
    nombre: document.getElementById("nombreReceptor").value,
    codActividad: document.getElementById("codActividad").value,
    descActividad: document.getElementById("descActividad").value,
    nombreComercial: document.getElementById("nombreComercial").value,
    departamento: document.getElementById("departamentoReceptor").value,
    municipio: document.getElementById("municipioReceptor").value,
    complemento: document.getElementById("complemento").value,
    telefono: document.getElementById("telefono").value,
    correo: document.getElementById("correoReceptor").value,
  };
}
