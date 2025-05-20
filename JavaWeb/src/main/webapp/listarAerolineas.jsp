<!-- SE MANTIENEN LAS DIRECTIVAS -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.jose.webapp.proyecto.models.Aerolinea" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>

<%
    List<Aerolinea> aerolineas = (List<Aerolinea>) request.getAttribute("aerolineas");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tabla de Aerolíneas</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        * {
          box-sizing: border-box;
          font-family: 'Inter', sans-serif;
        }

        body {
          margin: 0;
          background-color: #eef3f9;
          color: #333;
          padding: 40px;
        }

        header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          border-bottom: 2px solid #d0d9e4;
          padding-bottom: 15px;
          margin-bottom: 35px;
        }

        header h1 {
          margin: 0;
          font-size: 32px;
          color: #1a2b49;
          font-weight: 600;
        }

        header i {
          font-size: 32px;
          color: #3498db;
        }

        table {
          width: 100%;
          border-collapse: collapse;
          background-color: #ffffff;
          border-radius: 12px;
          overflow: hidden;
          box-shadow: 0 3px 15px rgba(0, 0, 0, 0.06);
        }

        table thead {
          background-color: #3498db;
          color: white;
        }

        table th, table td {
          padding: 14px 18px;
          text-align: left;
        }

        table tbody tr:hover {
          background-color: #f2f8fd;
        }

        .acciones {
          text-align: center;
        }

        .btn i {
          margin-right: 5px;
        }

        .btn-primary {
          background-color: #2980b9;
          border: none;
        }

        .btn-primary:hover {
          background-color: #2471a3;
        }

        .btn-danger {
          background-color: #e74c3c;
          border: none;
        }

        .btn-danger:hover {
          background-color: #c0392b;
        }

        .delete-btn, .edit-btn {
          display: inline-flex;
          align-items: center;
        }

        @media (max-width: 768px) {
          table thead {
            display: none;
          }

          table, table tbody, table tr, table td {
            display: block;
            width: 100%;
          }

          table tr {
            margin-bottom: 15px;
            border-bottom: 1px solid #ccc;
          }

          table td {
            text-align: right;
            padding-left: 50%;
            position: relative;
          }

          table td::before {
            content: attr(data-label);
            position: absolute;
            left: 15px;
            font-weight: bold;
            text-align: left;
          }
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
<jsp:include page="navbar.jsp"/>
<div class="container">

    <br/>

    <header>
        <h1><i class="fas fa-plane-departure me-2"></i>Listado de Aerolíneas</h1>
    </header>

    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>Nombre</th>
            <th>IATA</th>
            <th>País</th>
            <th>Fecha de Fundación</th>
            <th>Estatus</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            int contador = 1;
            for (Aerolinea a : aerolineas) {
                LocalDate fechaFundacion = a.getFechaFundacion();
                String fechaFormateada = fechaFundacion.format(dateFormatter);
        %>
        <tr>
            <td><%= contador %></td>
            <td style="display:none;"><%= a.getId() %></td>
            <td><%= a.getNombre() %></td>
            <td><%= a.getIata() %></td>
            <td><%= a.getPais() %></td>
            <td><%= fechaFormateada %></td>
            <td><%= a.getEstatus() %></td>
            <td class="acciones">
                <form action="<%= request.getContextPath() %>/aerolineas/actualizar" method="GET" style="display:inline;">
                    <input type="hidden" name="id" value="<%= a.getId() %>" />
                    <button type="submit" class="btn btn-primary btn-sm edit-btn">
                        <i class="fas fa-edit"></i>Editar
                    </button>
                </form>

                <form action="<%= request.getContextPath() %>/aerolineas/eliminar" method="GET" style="display:inline;" class="delete-form">
                    <input type="hidden" name="id" value="<%= a.getId() %>" />
                    <button type="button" class="btn btn-danger btn-sm ms-1 delete-btn">
                        <i class="fas fa-trash"></i>Eliminar
                    </button>
                </form>
            </td>
        </tr>
        <%
            contador++;
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.1/dist/sweetalert2.all.min.js"></script>
<script>
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function (event) {
            const form = this.closest('form');
            Swal.fire({
                title: '¿Eliminar aerolínea?',
                text: "No podrás deshacer esta acción.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                }
            });
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
