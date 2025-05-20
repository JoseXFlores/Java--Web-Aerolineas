<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jose.webapp.proyecto.models.Aeropuerto" %>
<%@ page import="com.jose.webapp.proyecto.models.Aerolinea" %>
<%@ page import="com.jose.webapp.proyecto.models.Avion" %>

<% List<Aerolinea> aerolineas = (List<Aerolinea>) request.getAttribute("aerolineas"); %>

<html lang="es">
<head>

  <meta charset="UTF-8">
  <title>Crear Avión</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body class="container mt-5">
<jsp:include page="navbar.jsp"/>

<h2>Crear Avión</h2>

<form action="<%=request.getContextPath()%>/aviones/alta" method="post">

  <div class="mb-3">
   <label class="form-label">Número de Registro</label>
   <input type="text" step="any" name="numRegistro" class="form-control" placeholder=" Numero de Registro " value="${param.numRegistro}"required>

  </div>

  <div class="mb-3">
    <label class="form-label">Tipo</label>
   <input type="text" step="any" name="tipo" class="form-control" placeholder=" tipo " value="${param.tipo}"required>
  </div>

  <div class="mb-3">
    <label class="form-label">Código del Modelo</label>
   <input type="text" step="any" name="codigoModelo" class="form-control" placeholder=" Codigo del Modelo " value="${param.codigoModelo}"required>
  </div>

  <div class="mb-3">
    <label class="form-label">Capacidad</label>
      <input min="1" type="number" step="any" name="capacidad" class="form-control" placeholder=" Capacidad " value="${param.capacidad}"required>
  </div>

  <div class="mb-3">
    <label class="form-label">Fecha de Primer Vuelo</label>
     <input type="date" step="any" name="fechaPrimerVuelo" class="form-control" placeholder=" Fecha del Primer Vuelo " value="${param.fechaPrimerVuelo}"required>
  </div>

  <div class="mb-3">
    <label class="form-label">Estatus</label>
    <label class="form-label" for="estatus">Estatus</label>
        <select id="estatus" name="estatus" class="form-select" required>
          <option value="1">Disponible</option>
          <option value="2">No Disponible</option>
    </select>
  </div>

  <div class="mb-3">
    <label for="aerolinea" class="form-label">Aerolinea</label>
        <select  name="aerolinea" id="aerolinea" class="form-select">
            <%
                int contador = 1; // Inicia el contador en 1 o el valor que prefieras
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
