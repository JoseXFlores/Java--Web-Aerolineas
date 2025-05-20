<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jose.webapp.proyecto.models.Aerolinea" %>
<%@ page import="com.jose.webapp.proyecto.models.enums.Estatus" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%
    Aerolinea aerolinea = (Aerolinea) request.getAttribute("aerolinea");
    LocalDate fechaFundacion = aerolinea.getFechaFundacion();
    String fechaFormateada = "";
    if (fechaFundacion != null) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        fechaFormateada = fechaFundacion.format(formatter);
    }
%>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Aerolínea</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f7fa;
            color: #2c3e50;
            font-family: 'Segoe UI', sans-serif;
        }

        .card-custom {
            background: #ffffff;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }

        .card-custom h3 {
            color: #2c3e50;
        }

        .form-control,
        .form-select {
            background-color: #ffffff;
            border: 1px solid #ced4da;
            color: #2c3e50;
        }

        .form-control::placeholder {
            color: #6c757d;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #ffc107;
            box-shadow: 0 0 0 0.2rem rgba(255, 193, 7, 0.25);
        }

        .btn-primary {
            background-color: #ffc107;
            color: #212529;
            border: none;
        }

        .btn-primary:hover {
            background-color: #e0a800;
        }

        label {
            font-weight: 500;
        }

        .container-padding {
            padding-top: 20px;
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
    <jsp:include page="navbar.jsp" />

    <div class="container container-padding">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card card-custom mt-4">
                    <h3 class="mb-4 text-center">
                        <i class="bi bi-pencil-square"></i> Editar Aerolínea: <%= aerolinea.getNombre() %>
                    </h3>

                    <form action="<%=request.getContextPath()%>/aerolineas/actualizar" method="post">
                        <input type="hidden" name="id" value="<%= aerolinea.getId() %>">

                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre de la Aerolínea" value="<%= aerolinea.getNombre() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="iata" class="form-label">Código IATA</label>
                            <input type="text" class="form-control" id="iata" name="iata" placeholder="Código IATA" value="<%= aerolinea.getIata() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="pais" class="form-label">País</label>
                            <input type="text" class="form-control" id="pais" name="pais" placeholder="Nombre del País" value="<%= aerolinea.getPais() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="fundacion" class="form-label">Fecha de Fundación</label>
                            <input type="date" id="fundacion" name="fundacion" class="form-control" value="<%= fechaFormateada %>" required>
                        </div>

                        <div class="mb-4">
                            <label for="estatus" class="form-label">Estatus</label>
                            <select id="estatus" name="estatus" class="form-select" required>
                                <option value="1" <%= aerolinea.getEstatus() == Estatus.DISPONIBLE ? "selected" : "" %>>Disponible</option>
                                <option value="2" <%= aerolinea.getEstatus() == Estatus.NO_DISPONIBLE ? "selected" : "" %>>No Disponible</option>
                            </select>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-save"></i> Guardar Cambios
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>

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
