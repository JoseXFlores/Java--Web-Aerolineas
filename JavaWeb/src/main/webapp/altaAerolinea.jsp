<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Crear Aerolínea</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #2c3e50;
      --accent-color: #e74c3c;
      --light-color: #ecf0f1;
      --dark-color: #2c3e50;
    }

    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: var(--dark-color);
    }

    .form-container {
      max-width: 800px;
      margin: 2rem auto;
      background: white;
      border-radius: 10px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      padding: 2.5rem;
    }

    .form-header {
      text-align: center;
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid #eee;
    }

    .form-header h2 {
      color: var(--secondary-color);
      font-weight: 600;
    }

    .form-icon {
      font-size: 2.5rem;
      color: var(--primary-color);
      margin-bottom: 1rem;
    }

    .form-label {
      font-weight: 500;
      color: var(--secondary-color);
    }

    .form-control, .form-select {
      border-radius: 5px;
      padding: 0.75rem 1rem;
      border: 1px solid #ddd;
      transition: all 0.3s;
    }

    .form-control:focus, .form-select:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
    }

    .btn-submit {
      background-color: var(--primary-color);
      border: none;
      padding: 0.75rem 2rem;
      font-weight: 500;
      width: 100%;
      margin-top: 1rem;
      transition: all 0.3s;
    }

    .btn-submit:hover {
      background-color: #2980b9;
      transform: translateY(-2px);
    }

    .form-section {
      margin-bottom: 1.5rem;
    }

            .dark-mode {
                background-color: #121212 !important;
                color: #f1f1f1 !important;
            }

            .dark-mode .card-custom {
                background-color: #1e1e2f;
                color: #f8f9fa;
            }

            .dark-mode .form-control,
            .dark-mode .form-select {
                background-color: #2c2c3c;
                color: #f8f9fa;
                border-color: #444;
            }

            .dark-mode .btn-primary {
                background-color: #ffc107;
                color: #212529;
            }

            .dark-mode .form-control::placeholder {
                color: #bbbbbb;
            }



  </style>
</head>
<body>
  <!-- Navbar oculta pero funcional -->

    <jsp:include page="navbar.jsp"/>


  <div class="container py-5">
    <div class="form-container">
      <div class="form-header">
        <i class="fas fa-plane-departure form-icon"></i>
        <h2>Crear Nueva Aerolínea</h2>
        <p class="text-muted">Complete todos los campos requeridos para registrar una nueva aerolínea</p>
      </div>

      <form action="<%=request.getContextPath()%>/aerolineas/alta" method="post">
        <div class="row">
          <!-- Columna izquierda -->
          <div class="col-md-6">
            <div class="form-section">
              <label for="nombre" class="form-label">Nombre de la Aerolínea</label>
              <input type="text" class="form-control" id="nombre" name="nombre"
                     placeholder="Ej: AeroMéxico" value="${param.nombre}" required>
              <small class="text-muted">Nombre completo de la aerolínea</small>
            </div>

            <div class="form-section">
              <label for="iata" class="form-label">Código IATA</label>
              <input type="text" class="form-control" id="iata" name="iata"
                     placeholder="Ej: AM" value="${param.iata}" required maxlength="3">
              <small class="text-muted">Código de 2-3 letras</small>
            </div>

            <div class="form-section">
              <label for="pais" class="form-label">País de Origen</label>
              <input type="text" class="form-control" id="pais" name="pais"
                     placeholder="Ej: México" value="${param.pais}" required>
            </div>
          </div>

          <!-- Columna derecha -->
          <div class="col-md-6">
            <div class="form-section">
              <label for="fundacion" class="form-label">Fecha de Fundación</label>
              <input type="date" class="form-control" id="fundacion" name="fundacion"
                     value="${param.fundacion}" required>
            </div>

            <div class="form-section">
              <label for="estatus" class="form-label">Estatus</label>
              <select class="form-select" id="estatus" name="estatus" required>
                <option value="" disabled selected>Seleccione un estatus</option>
                <option value="1">Disponible</option>
                <option value="2">No Disponible</option>
              </select>
            </div>

            <div class="form-section">
              <div class="d-grid gap-2">
                <button type="submit" class="btn btn-submit">
                  <i class="fas fa-save me-2"></i>Guardar Aerolínea
                </button>
               <a href="<%=request.getContextPath()%>/" class="btn btn-outline-secondary">
                 <i class="fas fa-times me-2"></i>Cancelar
                </a>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Script para seleccionar el valor de estatus si viene en los parámetros
    document.addEventListener('DOMContentLoaded', function() {
      const estatusParam = "${param.estatus}";
      if(estatusParam) {
        document.getElementById('estatus').value = estatusParam;
      }

      // Validación del código IATA (2-3 letras mayúsculas)
      document.getElementById('iata').addEventListener('input', function(e) {
        this.value = this.value.toUpperCase().replace(/[^A-Z]/g, '');
      });
    });
  </script>
  <script>
      const toggleBtn = document.getElementById('toggleTheme');
      const themeIcon = document.getElementById('themeIcon');
      const body = document.body;

      function applyTheme(theme) {
          if (theme === 'dark') {
              body.classList.add('dark-mode');
              themeIcon.classList.replace('bi-sun-fill', 'bi-moon-stars-fill');
          } else {
              body.classList.remove('dark-mode');
              themeIcon.classList.replace('bi-moon-stars-fill', 'bi-sun-fill');
          }
          localStorage.setItem('theme', theme);
      }

      // Toggle al hacer clic
      toggleBtn.addEventListener('click', () => {
          const currentTheme = body.classList.contains('dark-mode') ? 'dark' : 'light';
          applyTheme(currentTheme === 'dark' ? 'light' : 'dark');
      });

      // Aplicar tema guardado
      const savedTheme = localStorage.getItem('theme') || 'light';
      applyTheme(savedTheme);
  </script>

</body>
</html>