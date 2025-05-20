<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jose.webapp.proyecto.models.Avion" %>
<%@ page import="com.jose.webapp.proyecto.models.Aeropuerto" %>
<%@ page import="com.jose.webapp.proyecto.models.Vuelo" %>
<%@ page import="com.jose.webapp.proyecto.models.enums.Estatus" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>

<%
    Vuelo vuelo = (Vuelo) request.getAttribute("vuelo");
    List<Avion> aviones = (List<Avion>) request.getAttribute("aviones");
    List<Aeropuerto> aeropuertos = (List<Aeropuerto>) request.getAttribute("aeropuertos");
    String fechaFormateada = "";
    if (vuelo.getFechaSalida() != null) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        fechaFormateada = vuelo.getFechaSalida().format(formatter);
    }
%>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Vuelo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
<jsp:include page="navbar.jsp"/>

<h2>Editar Vuelo: <%= vuelo.getCodigoVuelo() %></h2>

<form action="<%=request.getContextPath()%>/vuelos/actualizar" method="post">
    <input type="hidden" name="id" value="<%= vuelo.getId() %>">

    <div class="mb-3">
        <label class="form-label">Código de Vuelo</label>

        <input type="text" step="any" id="codigoVuelo" name="codigoVuelo" class="form-control" placeholder=" Codigo del Vuelo " value="<%=vuelo.getCodigoVuelo()%>" required>
          </div>

    <div class="mb-3">
        <label class="form-label">Avión</label>
        <select name="avion" class="form-select" required>
            <% for (Avion a : aviones) { %>
                <option value="<%= a.getId() %>" <%= a.getId().equals(vuelo.getAvion().getId()) ? "selected" : "" %>>
                    <%= a.getTipo() %>
                </option>
            <% } %>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label">Aeropuerto Origen</label>
        <select name="origen" class="form-select" required>
            <% for (Aeropuerto a : aeropuertos) { %>
                <option value="<%= a.getId() %>" <%= a.getId().equals(vuelo.getOrigen().getId()) ? "selected" : "" %>>
                    <%= a.getNombre() %>
                </option>
            <% } %>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label">Aeropuerto Destino</label>
        <select name="destino" class="form-select" required>
            <% for (Aeropuerto a : aeropuertos) { %>
                <option value="<%= a.getId() %>" <%= a.getId().equals(vuelo.getDestino().getId()) ? "selected" : "" %>>
                    <%= a.getNombre() %>
                </option>
            <% } %>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label">Fecha de Salida</label>
        <input type="datetime-local" name="fechaSalida" class="form-control" value="<%= fechaFormateada %>" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Estatus</label>
        <select name="estatus" class="form-select" required>
            <option value="1" <%= vuelo.getEstatus() == Estatus.DISPONIBLE ? "selected" : "" %>>Disponible</option>
            <option value="2" <%= vuelo.getEstatus() == Estatus.NO_DISPONIBLE ? "selected" : "" %>>No Disponible</option>
        </select>
    </div>

    <button type="submit" class="btn btn-primary">Guardar</button>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
