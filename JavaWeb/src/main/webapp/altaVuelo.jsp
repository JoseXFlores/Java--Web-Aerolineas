<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jose.webapp.proyecto.models.Aeropuerto" %>
<%@ page import="com.jose.webapp.proyecto.models.Avion" %>
<%@ page import="com.jose.webapp.proyecto.models.Vuelo" %>

<% List<Aeropuerto> aeropuertos = (List<Aeropuerto>) request.getAttribute("aeropuertos"); %>
<% List<Avion> aviones = (List<Avion>) request.getAttribute("aviones"); %>

<html lang="es">


<head>
  <meta charset="UTF-8">
  <title>Crear Vuelo</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>

<body class="container mt-5">
  <jsp:include page="navbar.jsp"/>

<h2>Crear Vuelo</h2>

<form action="<%=request.getContextPath()%>/vuelos/alta" method="post">

  <div class="mb-3">
    <label class="form-label">Código de Vuelo</label>
     <input type="text" step="any" name="codigoVuelo" class="form-control" placeholder=" Codigo del vuelo " value="${param.codigoVuelo}"required>
  </div>

  <div class="mb-3">
        <label for="avion" class="form-label"> Avion </label>
          <select  name="avion" id="avion" class="form-select">
              <%
                  int count = 1; // Inicia el contador en 1 o el valor que prefieras
                  for (Avion c: aviones) {
              %>
              <option value="<%=c.getId()%>"><%=c.getTipo()%> </option>
              <% count++; } %>
          </select>
  </div>

  <div class="mb-3">
        <label for="aeropuerto" class="form-label"> Aeropuerto Origen</label>
          <select  name="origen" id="origen" class="form-select">
              <%
                  int conta = 1; // Inicia el contador en 1 o el valor que prefieras
                  for (Aeropuerto a: aeropuertos) {
              %>
              <option value="<%=a.getId()%>"><%=a.getNombre()%> </option>
              <% conta++; } %>
          </select>
  </div>

  <div class="mb-3">

          <label for="aeropuerto" class="form-label"> Aeropuerto Destino</label>
            <select  name="destino" id="destino" class="form-select">
                <%
                    int contador = 1; // Inicia el contador en 1 o el valor que prefieras
                    for (Aeropuerto d: aeropuertos) {
                %>
                <option value="<%=d.getId()%>"><%=d.getNombre()%> </option>
                <% contador++; } %>
            </select>
  </div>

  <div class="mb-3">
    <label class="form-label">Fecha de Salida</label>
    <input type="datetime-local" id="fechaSalida" name="fechaSalida" value="${param.fechaSalida}"class="form-control">
  </div>

  <div class="mb-3">
    <label class="form-label">Estatus</label>
    <label class="form-label" for="estatus">Estatus</label>
        <select id="estatus" name="estatus" class="form-select" required>
          <option value="1">Disponible</option>
          <option value="2">No Disponible</option>
    </select>
  </div>

  <button type="submit" class="btn btn-primary">Guardar</button>
</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

</html>
