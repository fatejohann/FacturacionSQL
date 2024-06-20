document.getElementById('registerForm').addEventListener('submit', async (event) => {
    event.preventDefault();

    // Validaciones en el frontend
    const nombre = document.getElementById('nombre').value.trim();
    const apellidos = document.getElementById('apellidos').value.trim();
    const correo = document.getElementById('correo').value.trim();
    const dui = document.getElementById('dui').value.trim();
    const nit = document.getElementById('nit').value.trim();
    const nrc = document.getElementById('nrc').value.trim();
    const telefono = document.getElementById('telefono').value.trim();

    if (!nombre || !apellidos || !correo || !dui || !nit || !nrc || !telefono) {
      alert('Todos los campos son obligatorios.');
      return;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(correo)) {
      alert('Por favor ingrese un correo electrónico válido.');
      return;
    }

    const duiRegex = /^\d{8}-\d{1}$/;
    if (!duiRegex.test(dui)) {
      alert('Por favor ingrese un DUI válido (formato: 12345678-9).');
      return;
    }

    const data = { nombre, apellidos, correo, dui, nit, nrc, telefono };

    const response = await fetch('../api/create_user.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });

    if (response.ok) {
      alert('Usuario registrado exitosamente');
    } else {
      const errorData = await response.json();
      alert('Error al registrar usuario: ' + errorData.error);
    }
  });