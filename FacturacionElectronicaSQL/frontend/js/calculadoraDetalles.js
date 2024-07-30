
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('add-detail').addEventListener('click', () => {
        const tbody = document.getElementById('details-body');
        const newRow = document.createElement('tr');

        newRow.innerHTML = `
            <td><input type="number" value="0" class="form-control qty" min="0"></td>
            <td><input type="text" class="form-control description" required></td>
            <td><input type="number" value="0" class="form-control price" min="0"></td>
            <td><input type="number" value="0" class="form-control" readonly></td>
            <td><input type="number" value="0" class="form-control" readonly></td>
            <td><input type="number" value="0" class="form-control total" readonly></td>
            <td><button class="btn btn-danger delete-row">Eliminar</button></td>
        `;

        tbody.appendChild(newRow);
    });

    document.getElementById('details-body').addEventListener('input', (event) => {
        if (event.target.classList.contains('qty') || event.target.classList.contains('price') || event.target.classList.contains('description')) {
            validateInputs(event.target);
            updateCalculations();
        }
    });

    document.getElementById('details-body').addEventListener('click', (event) => {
        if (event.target.classList.contains('delete-row')) {
            event.target.closest('tr').remove();
            updateCalculations();
        }
    });

    document.getElementById('export-csv').addEventListener('click', () => {
        exportToCSV();
    });

   
});

function validateInputs(input) {
    if (input.classList.contains('description')) {
        if (input.value.trim() === '') {
            input.setCustomValidity('La descripción no puede estar vacía.');
        } else {
            input.setCustomValidity('');
        }
    } else if (input.type === 'number') {
        if (input.valueAsNumber < 0) {
            input.setCustomValidity('El valor no puede ser negativo.');
        } else {
            input.setCustomValidity('');
        }
    }
}

function updateCalculations() {
    const rows = document.querySelectorAll('#details-body tr');
    let totalGravada = 0;

    rows.forEach(row => {
        const qty = row.querySelector('.qty').valueAsNumber;
        const price = row.querySelector('.price').valueAsNumber;
        const total = (qty > 0 && price > 0) ? qty * price : 0;

        row.querySelector('.total').value = total.toFixed(2);
        totalGravada += total;
    });

    const iva = totalGravada * 0.13;
    const subTotal = totalGravada + iva;

    document.querySelector('.summary tbody').innerHTML = `
        <tr>
            <td>Sumas</td>
            <td>0</td>
            <td>0</td>
            <td>${totalGravada.toFixed(2)}</td>
        </tr>
        <tr>
            <td>13% IVA</td>
            <td></td>
            <td></td>
            <td>${iva.toFixed(2)}</td>
        </tr>
        <tr>
            <td>SUB TOTAL</td>
            <td></td>
            <td></td>
            <td>${subTotal.toFixed(2)}</td>
        </tr>
        <tr>
            <td>VENTA EXENTA</td>
            <td></td>
            <td></td>
            <td>0</td>
        </tr>
        <tr>
            <td>VENTA NO SUJETAS</td>
            <td></td>
            <td></td>
            <td>0</td>
        </tr>
        <tr>
            <td>SUB TOTAL</td>
            <td></td>
            <td></td>
            <td>${subTotal.toFixed(2)}</td>
        </tr>
        <tr>
            <td>VENTA TOTAL</td>
            <td></td>
            <td></td>
            <td>${subTotal.toFixed(2)}</td>
        </tr>
    `;
}

function exportToCSV() {
    let csvContent = "data:text/csv;charset=utf-8,";
    const rows = document.querySelectorAll('table tr');
    
    rows.forEach(row => {
        let rowContent = [];
        row.querySelectorAll('td, th').forEach(cell => {
            rowContent.push(cell.innerText);
        });
        csvContent += rowContent.join(",") + "\r\n";
    });

    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", "detalles_productos.csv");
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

// Nueva función para capturar los datos de los detalles
function capturarDatosDetalles() {
    const rows = document.querySelectorAll('#details-body tr');
    const detalles = [];

    rows.forEach((row, index) => {
        const qty = row.querySelector('.qty').valueAsNumber;
        const description = row.querySelector('.description').value;
        const price = row.querySelector('.price').valueAsNumber;
        const total = row.querySelector('.total').valueAsNumber;

        detalles.push({
            numItem: index + 1,
            tipoItem: 1,
            numeroDocumento: null,
            codigo: "0",  // Este valor puede ser dinámico o estático según tu necesidad
            codTributo: null,
            descripcion: description,
            cantidad: qty,
            uniMedida: 59,  // Este valor puede ser dinámico o estático según tu necesidad
            precioUni: price,
            montoDescu: 0.0,
            ventaNoSuj: 0.0,
            ventaExenta: 0.0,
            ventaGravada: total,
            tributos: ["20"],  // Este valor puede ser dinámico o estático según tu necesidad
            psv: 0.0,
            noGravado: 0.0,
        });
    });

    return detalles;
}

function calcularResumen(detalles) {
    let totalNoSuj = 0.0;
    let totalExenta = 0.0;
    let totalGravada = 0.0;
    let subTotalVentas = 0.0;
    let totalDescu = 0.0;
    let valorIVA = 0.0;
    const IVA_RATE = 0.13; // Assuming 13% IVA rate

    detalles.forEach(detalle => {
        totalNoSuj += detalle.ventaNoSuj;
        totalExenta += detalle.ventaExenta;
        totalGravada += detalle.ventaGravada;
        totalDescu += detalle.montoDescu;
    });

    subTotalVentas = totalNoSuj + totalExenta + totalGravada;
    valorIVA = totalGravada * IVA_RATE;

    const subTotal = Math.round((subTotalVentas - totalDescu) * 100) / 100;
    const montoTotalOperacion = Math.round((subTotalVentas + valorIVA - totalDescu) * 100) / 100;
    const totalPagar = Math.round((subTotalVentas + valorIVA - totalDescu) * 100) / 100;

    return {
        totalNoSuj: Math.round(totalNoSuj * 100) / 100,
        totalExenta: Math.round(totalExenta * 100) / 100,
        totalGravada: Math.round(totalGravada * 100) / 100,
        subTotalVentas: Math.round(subTotalVentas * 100) / 100,
        descuNoSuj: 0.0, // Adjust as needed
        descuExenta: 0.0, // Adjust as needed
        descuGravada: Math.round(totalDescu * 100) / 100,
        porcentajeDescuento: 0.0, // Adjust as needed
        totalDescu: Math.round(totalDescu * 100) / 100,
        tributos: [
            {
                codigo: "20",
                descripcion: "Impuesto al Valor Agregado 13%",
                valor: Math.round(valorIVA * 100) / 100,
            }
        ],
        subTotal: subTotal,
        ivaPerci1: 0.0, // Adjust as needed
        ivaRete1: 0.0, // Adjust as needed
        reteRenta: 0.0, // Adjust as needed
        montoTotalOperacion: montoTotalOperacion,
        totalNoGravado: 0.0, // Adjust as needed
        totalPagar: totalPagar,
        totalLetras: convertirNumeroALetras(totalPagar), // Function to convert numbers to words
        saldoFavor: 0.0, // Adjust as needed
        condicionOperacion: 1, // Adjust as needed
        pagos: null, // Adjust as needed
        numPagoElectronico: null, // Adjust as needed
    };
}

function convertirNumeroALetras(num) {
    const unidades = ["", "UNO", "DOS", "TRES", "CUATRO", "CINCO", "SEIS", "SIETE", "OCHO", "NUEVE"];
    const decenas = ["", "DIEZ", "VEINTE", "TREINTA", "CUARENTA", "CINCUENTA", "SESENTA", "SETENTA", "OCHENTA", "NOVENTA"];
    const centenasArray = ["", "CIEN", "DOSCIENTOS", "TRESCIENTOS", "CUATROCIENTOS", "QUINIENTOS", "SEISCIENTOS", "SETECIENTOS", "OCHOCIENTOS", "NOVECIENTOS"];
    const especiales = ["", "ONCE", "DOCE", "TRECE", "CATORCE", "QUINCE", "DIECISEIS", "DIECISIETE", "DIECIOCHO", "DIECINUEVE"];
    const especiales2 = ["", "VEINTIUNO", "VEINTIDOS", "VEINTITRES", "VEINTICUATRO", "VEINTICINCO", "VEINTISEIS", "VEINTISIETE", "VEINTIOCHO", "VEINTINUEVE"];
  
    function convertGroup(n) {
      let output = "";
      if (n === 100) {
        return "CIEN";
      } else if (n < 1000) {
        output += centenasArray[Math.floor(n / 100)];
        n = n % 100;
      }
  
      if (n >= 30) {
        output += (output ? " " : "") + decenas[Math.floor(n / 10)];
        n = n % 10;
      } else if (n >= 20) {
        output += (output ? " " : "") + (n === 20 ? "VEINTE" : especiales2[n - 20]);
        n = 0;
      } else if (n >= 10) {
        output += (output ? " " : "") + (n === 10 ? "DIEZ" : especiales[n - 10]);
        n = 0;
      } else if (n > 0) {
        output += (output ? " " : "") + unidades[n];
        n = 0;
      }
      return output;
    }
  
    function splitNumber(num) {
      const parts = num.toString().split('.');
      const wholePart = parseInt(parts[0], 10);
      const fractionalPart = parts[1] ? parseInt(parts[1].padEnd(2, '0'), 10) : 0;
      return [wholePart, fractionalPart];
    }
  
    const [wholePart, fractionalPart] = splitNumber(num);
    const millones = Math.floor(wholePart / 1000000);
    const miles = Math.floor((wholePart % 1000000) / 1000);
    const centenasParte = wholePart % 1000;
  
    let literal = "";
  
    if (millones > 0) {
      literal += convertGroup(millones) + " MILLON" + (millones > 1 ? "ES" : "");
    }
  
    if (miles > 0) {
      literal += (literal ? " " : "") + convertGroup(miles) + " MIL";
    }
  
    if (centenasParte > 0) {
      literal += (literal ? " " : "") + convertGroup(centenasParte);
    }
  
    if (literal === "") {
      literal = "CERO";
    }
  
    if (fractionalPart > 0) {
      literal += ` CON ${convertGroup(fractionalPart)} CENTAVOS`;
    }
  
    literal += " USD";
  
    return literal;
  }

// Uso de los datos capturados
document.getElementById('save-json').addEventListener('click', () => {
    const documentoSeleccionado = document.getElementById("documentType").value;
        let facturaJson = cargarFactura(documentoSeleccionado);
    const detalles = capturarDatosDetalles();
    facturaJson.dteJson.cuerpoDocumento = detalles;

    // Otras operaciones necesarias con facturaJson

    console.log(facturaJson);
});
