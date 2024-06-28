document.getElementById('loginForm').addEventListener('submit', async (event) => {
    event.preventDefault();

    const correo = document.getElementById('correo').value.trim();
    const nit = document.getElementById('nit').value.trim();

    if (!correo || !nit) {
      alert('Todos los campos son obligatorios.');
      return;
    }

    const data = { correo, nit };

    const response = await fetch('../api/login.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });

    if (response.ok) {
      const result = await response.json();
      if (result.success) {
        alert('Login exitoso');
        // Redirige a la página principal o dashboard
        window.location.href = 'inicio.html';
      } else {
        alert('Credenciales incorrectas');
      }
    } else {
      alert('Error en el servidor');
    }
  });