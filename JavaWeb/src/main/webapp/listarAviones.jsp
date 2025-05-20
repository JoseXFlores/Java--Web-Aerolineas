<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.jose.webapp.proyecto.models.Avion" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>

<%
    List<Avion> aviones = (List<Avion>) request.getAttribute("aviones");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

  <html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Tabla de Aviones</title>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
     <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
   <style>
        * {
          box-sizing: border-box;
          font-family: 'Inter', sans-serif;
        }

        body {
          margin: 0;
          background-color: #f5f9fc;
          color: #333;
          padding: 30px;
        }

        header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          border-bottom: 2px solid #ddd;
          padding-bottom: 10px;
          margin-bottom: 30px;
        }

        header h1 {
          margin: 0;
          font-size: 28px;
          color: #2c3e50;
        }

        header img {
          height: 60px;
        }

        table {
          width: 100%;
          border-collapse: collapse;
          background-color: #fff;
          border-radius: 12px;
          overflow: hidden;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        table thead {
          background-color: #3498db;
          color: white;
        }

        table th, table td {
          padding: 12px 15px;
          text-align: left;
          border-bottom: 1px solid #eee;
        }

        table td.acciones {
          display: flex;
          justify-content: center;
          gap: 10px;
          align-items: center;
          padding: 10px 0;
        }

        table i {
          margin: 0 5px;
          cursor: pointer;
          color: #3498db;
          transition: color 0.3s ease;
        }

        table i:hover {
          color: #2c3e50;
        }
    </style>
  </head>
  <body>
  <jsp:include page="navbar.jsp"/>
  <div class = "container t-4">
  <header><h1>Listado de Aviones</h1></header>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>Número de Registro</th>
      <th>Tipo</th>
      <th>Código Modelo</th>
      <th>Capacidad</th>
      <th>Fecha Primer Vuelo</th>
      <th>Estatus</th>
      <th>Aerolínea</th>
      <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <%
    int contador = 1;
    for (Avion a : aviones) {
    LocalDate fecha = a.getFechaPrimerVuelo();
    String fechaFormateada = fecha.format(dateFormatter);
    %>
    <tr>
      <td><%= contador %></td>
      <td style="display:none;"><%= a.getId() %></td>
      <td><%= a.getNumRegistro() %></td>
      <td><%= a.getTipo() %></td>
      <td><%= a.getCodigoModelo() %></td>
      <td><%= a.getCapacidad() %></td>
      <td><%= fechaFormateada %></td>
      <td><%= a.getEstatus() %></td>
      <td><%= a.getAerolinea().getNombre() %></td>
      <td class="acciones">

           <form action="<%= request.getContextPath() %>/aviones/actualizar" method="GET" style="display: inline;" >
                   <input type="hidden" name="id" value="<%= a.getId() %>" />
                   <button type="submit" class="btn btn-primary btn-sm me-1"> <!-- Cambiado a type="button" -->
                    <i class="fas fa-edit"></i>
                   </button>
           </form>

           <form action="<%= request.getContextPath() %>/aviones/eliminar" method="GET" style="display: inline;" class="delete-form">
                <input type="hidden" name="id" value="<%= a.getId() %>" />
                <button type="button" class="btn btn-danger btn-sm ms-1 delete-btn"> <!-- Cambiado a type="button" -->
                    <i class="fas fa-trash" title="Eliminar"></i>
                </button>
            </form>
      </td>
    </tr>
    <% contador++; } %>
    </tbody>
  </table>
  </body>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.1/dist/sweetalert2.all.min.js"></script>
 <script>
         document.querySelectorAll('.delete-btn').forEach(button => {
             button.addEventListener('click', function(event){
                 const form = this.closest('form');

                 Swal.fire({
                     title: '¿Estás seguro que deseas eliminar el Avion?',
                     text: "¡No podrás revertir esta acción!",
                     icon: 'warning',
                     showCancelButton: true,
                     confirmButtonColor: '#3085d6',
                     cancelButtonColor: '#d33',
                     confirmButtonText: 'Si, eliminar!',
                     cancelButtonText: 'Cancelar'
                 }).then((result) => {
                     if (result.isConfirmed) {
                         form.submit(); // Solo se envía si se confirma
                     }
                 });
             });
         });
 </script>
  </html>
