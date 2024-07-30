lastToken;
let estado;

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
            numeroControl: "DTE-01-0001ONEC-000000000005040",
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
            numeroControl: "DTE-03-0001ONEC-000000000005068",
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
          cuerpoDocumento: [],
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
      let dataRecepcion = null; 
      let facturaJson = null;
      let documentoData = null;

      try {
       //agregar swicth con casos para envio de cada dte


        // Generar y modificar el JSON de la factura
        const documentoSeleccionado = document.getElementById("documentType").value;
        facturaJson = cargarFactura(documentoSeleccionado);

        // Generar el nuevo número de control y código de generación
        let tipoDte = facturaJson.dteJson.identificacion.tipoDte;
        facturaJson.dteJson.identificacion.numeroControl = generarNuevoNumeroControl(
          facturaJson.dteJson.identificacion.numeroControl,
          tipoDte
        );
        facturaJson.dteJson.identificacion.codigoGeneracion = generarUUID();
        facturaJson.dteJson.identificacion.fecEmi = new Date().toISOString().split("T")[0];
        facturaJson.dteJson.identificacion.horEmi = new Date().toLocaleTimeString("en-GB");

        // Capturar y actualizar datos de Emisor
        const datosEmisor = capturarDatosEmisor();
        facturaJson.dteJson.emisor.nit = datosEmisor.nit;
        facturaJson.dteJson.emisor.nrc = datosEmisor.nrc;
        facturaJson.dteJson.emisor.nombre = datosEmisor.nombre;
        facturaJson.dteJson.emisor.codActividad = datosEmisor.codActividad;
        facturaJson.dteJson.emisor.descActividad = datosEmisor.descActividad;

        console.log(datosEmisor.codActividad);
        console.log(datosEmisor.descActividad);

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

        console.log(datosReceptor.codActividad); // Debería mostrar el código de giro del receptor
        console.log(datosReceptor.descActividad); // Debería mostrar el nombre de giro del receptor

        // Capturar y actualizar datos de Detalles
        const detalles = capturarDatosDetalles();
        facturaJson.dteJson.cuerpoDocumento = detalles;

        // Calcular el resumen y actualizar en el JSON
        const resumen = calcularResumen(detalles);
        facturaJson.dteJson.resumen = resumen;

        try {
          // Intentar enviar la factura
          dataRecepcion = await enviarFactura(facturaJson, documentoSeleccionado);
        } catch (error) {
          console.error("Error al enviar la factura:", error);
        }

        // Continuar el proceso y construir el objeto para guardar en la base de datos
        const estado = dataRecepcion.estado || "INGRESADO";
        const codigoGeneracion = facturaJson.dteJson.identificacion.codigoGeneracion;

        // Mapear el estado del documento
        let idEstadoDocumento;
        switch (estado) {
          case "INGRESADO":
            idEstadoDocumento = 1;
            break;
          case "PROCESADO":
            idEstadoDocumento = 2;
            break;
          case "RECHAZADO":
            idEstadoDocumento = 3;
            break;
          default:
            idEstadoDocumento = 1;
            break;
        }

        // Crear objeto con los datos del documento para enviar a la base de datos
        documentoData = {
          noDocumento: facturaJson.dteJson.identificacion.numeroControl,
          fechaDocumento: facturaJson.dteJson.identificacion.fecEmi,
          horaDocumento: facturaJson.dteJson.identificacion.horEmi,
          idEstadoDocumento,
          idCliente: datosReceptor.idCliente || 1,
          totalVentasExentas: resumen.totalVentasExentas || 0,
          totalVentasNoSujetas: resumen.totalVentasNoSujetas || 0,
          totalVentasGravadas: resumen.totalVentasGravadas || 0,
          ivaDocumento: resumen.ivaDocumento || 0,
          retencionIVA: resumen.retencionIVA || 0,
          totalDocumento: resumen.totalDocumento || 0,
          numeroControl: facturaJson.dteJson.identificacion.numeroControl,
          codigoGeneracion,

          clasificacionMsg: dataRecepcion?.clasificaMsg || "",
          codigoMsg: dataRecepcion?.codigoMsg || "",
          descripcionMsg: dataRecepcion?.descripcionMsg || "",

          idArchivoJson: null,
          idArchivoPDF: null,
          idTipoPago: datosReceptor.idTipoPago || 1,
          idPlazoPago: datosReceptor.idPlazoPago || 1,
          idLote: null,
          idBodegaSucursal: datosEmisor.idBodegaSucursal || 1,
          idUsuario: datosEmisor.idUsuario || 1,
          subTotalVentas: resumen.subTotalVentas || 0,
          descuentoNoSujetas: resumen.descuentoNoSujetas || 0,
          descuentoExentas: resumen.descuentoExentas || 0,
          descuentoGravadas: resumen.descuentoGravadas || 0,
          porcentajeDescuento: resumen.porcentajeDescuento || 0,
          totalDescuentos: resumen.totalDescuentos || 0,
          subTotal: resumen.subTotal || 0,
          ivaPercibido: resumen.ivaPercibido || 0,
          retencionRenta: resumen.retencionRenta || 0,
          montoTotalOperacion: resumen.montoTotalOperacion || 0,
          totalNoGravado: resumen.totalNoGravado || 0,
          totalPagar: resumen.totalPagar || 0,
          totalLetras: resumen.totalLetras || "",
          totalIva: resumen.totalIva || 0,
        };

        // Intentar guardar el documento en la base de datos
        await guardarDocumento(documentoData);
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
          Authorization: lastToken,
        },
        body: JSON.stringify(dte),
      }
    );

   
    const dataRecepcion = await responseRecepcion.json();
    console.log("Respuesta de recepciondte (JSON):", dataRecepcion);
    return dataRecepcion;
  } catch (error) {
    console.error("Error al enviar la factura:", error);
    alert("Error al enviar la factura");
    throw error; // Asegura que el error se propague
  }
}

async function guardarDocumento(documentoData) {
  try {
    // Imprimir la información que se va a enviar a la base de datos
    console.log("Datos que se enviarán a la base de datos:", documentoData);

    // Enviar la solicitud para guardar el documento
    const response = await fetch("../api/save_documento_facturacion.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(documentoData),
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.error || `Error HTTP: ${response.status}`);
    }

    const result = await response.json();
    alert(result.message);
  } catch (error) {
    console.error("Error al guardar el documento:", error);
    alert("Error al guardar el documento: " + error.message);
  }
}

//funciono de enviar detalles(cuerpo de documento) a la tabla `t_detalle_documento_facturacion` el cual toma cada detalle como un registro

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

function capturarDatosEmisor() {
  const departamentoSelect = document.getElementById(
    "departamentoEmisorInicio"
  );
  const municipioSelect = document.getElementById("municipioEmisorInicio");

  const codActividadGiro = codigoGiroGlobal;
  const descActividadGiro = nombreGiroGlobal;

  return {
    nit: document.getElementById("nitEmisor").value,
    nrc: document.getElementById("nrc").value,
    nombre: document.getElementById("razonSocial").value,
    codActividad: codActividadGiro,
    descActividad: descActividadGiro,
    nombreComercial: document.getElementById("nombreComercial").value,
    departamento:
      departamentoSelect.selectedOptions[0].getAttribute("data-codigo"),
    municipio: municipioSelect.selectedOptions[0].getAttribute("data-codigo"),
    complemento: document.getElementById("direccion").value,
    telefono: document.getElementById("telefono").value,
    correo: document.getElementById("correo").value,
  };
}

function capturarDatosReceptor() {
  const departamentoSelect = document.getElementById("departamentoReceptor");
  const municipioSelect = document.getElementById("municipioReceptor");
  const codActividadGiro = codigoGiroGlobalReceptor;
  const descActividadGiro = nombreGiroGlobalReceptor;

  return {
    nit: document.getElementById("nitReceptor").value,
    nrc: document.getElementById("nrcReceptor").value,
    nombre: document.getElementById("NombreCliente").value,
    codActividad: codActividadGiro,
    descActividad: descActividadGiro,
    nombreComercial: document.getElementById("nombreComercialReceptor").value,
    departamento:
      departamentoSelect.selectedOptions[0].getAttribute("data-codigo"),
    municipio: municipioSelect.selectedOptions[0].getAttribute("data-codigo"),
    complemento: document.getElementById("direccionReceptor").value,
    telefono: document.getElementById("telefonoReceptor").value,
    correo: document.getElementById("correoReceptor").value,
  };
}
