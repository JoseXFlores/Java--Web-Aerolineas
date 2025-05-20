<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.jose.webapp.proyecto.models.Aerolinea" %>
<%@ page import="com.jose.webapp.proyecto.models.Avion" %>
<%@ page import="com.jose.webapp.proyecto.models.enums.Estatus" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>

<% List<Aerolinea> aerolineas = (List<Aerolinea>) request.getAttribute("aerolineas"); %>
<% List<Avion> aviones = (List<Avion>) request.getAttribute("aviones"); %>

<%
    Avion avion = (Avion) request.getAttribute("avion");
    LocalDate fechaPrimerVuelo = avion.getFechaPrimerVuelo();
    String fechaFormateada = "";
    if (fechaPrimerVuelo != null){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        fechaFormateada = fechaPrimerVuelo.format(formatter);
    }
%>

<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Crear Avión</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body class="container mt-5">
<jsp:include page="navbar.jsp"/>

<h2>Avion:<%=avion.getNumRegistro()%></h2>

<form action="<%=request.getContextPath()%>/aviones/actualizar" method="post">
<form method="post" action="editaAvion">

    <div class="mb-3">

        <label class="form-label">Número de Registro</label>

        <input type="hidden" name="id" value="<%=avion.getId() %>" >
        <input type="text" step="any" id="numRegistro" name="numRegistro" class="form-control" placeholder=" Numero de Registro " value="<%=avion.getNumRegistro()%>" required>

        </div>

        <div class="mb-3">
          <label class="form-label">Tipo</label>
         <input type="text" step="any" id="tipo" name="tipo" class="form-control" placeholder=" tipo " value="<%=avion.getTipo()%>" required>
        </div>

        <div class="mb-3">
          <label class="form-label">Código del Modelo</label>
         <input type="text" step="any" id="codigoModelo" name="codigoModelo" class="form-control" placeholder=" Codigo del Modelo " value="<%=avion.getCodigoModelo()%>" required>
        </div>

        <div class="mb-3">
          <label class="form-label">Capacidad</label>
            <input min="1" type="number" step="any" id="capacidad" name="capacidad" class="form-control" placeholder=" Capacidad " value="<%=avion.getCapacidad()%>" required>

        <div class="mb-3">
          <label class="form-label">Fecha de Primer Vuelo</label>
          <input type="date" id="fechaPrimerVuelo" name="fechaPrimerVuelo" class="form-control" value="<%=avion.getFechaPrimerVuelo().toString()%>" required>
         </div>

        <div class="mb-3">
          <label for="" class="form-label">Estatus</label>
          <select id="estatus" name="estatus" class="form-select" required>
            <option value="1"<%= avion.getEstatus() == Estatus.DISPONIBLE? "selected" :"" %> >Disponible</option>
            <option value="2"<%= avion.getEstatus() == Estatus.NO_DISPONIBLE? "selected" :"" %> >No Disponible</option>
          </select>
        </div>

        <div class="col-md-12">

        <label for="aerolinea" class="form-label">Aerolinea</label>
            <select  name="aerolinea" id="aerolinea" class="form-select">
                <%
                    int contador = 1;
                    for (Aerolinea a: aerolineas) {
                %>
                <option value="<%=a.getId()%>"><%=a.getNombre()%> </option>
                <% contador++; } %>
            </select>

        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
      </form>
      </body>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
      </html>
