<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="com.jose.webapp.proyecto.models.Aeropuerto" %>
<%@ page import="com.jose.webapp.proyecto.models.enums.Estatus" %>
<%
    Aeropuerto aeropuerto = (Aeropuerto) request.getAttribute("aeropuerto");
%>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Aeropuerto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">

</head>
<body class="container mt-5">
<jsp:include page="navbar.jsp"/>

<h2>Aeropuerto:<%=aeropuerto.getNombre()%></h2>

<form action="<%=request.getContextPath()%>/aeropuertos/actualizar" method="post">
<form method="post" action="editaAeropuerto">

        <div class="mb-3">
        <label for="" class="form-label">Nombre</label>

        <input type="hidden" name="id" value="<%=aeropuerto.getId() %>" >
        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre del Aeropuerto" value="<%=aeropuerto.getNombre()%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Código</label>
            <input type="text" name="codigo" id="codigo" class="form-control" maxlength="5" placeholder="Codigo " value="<%=aeropuerto.getCodigo()%>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Latitud</label>
            <input type="number" step="any" id="latitud" name="latitud" class="form-control" placeholder="Latitud" value="<%=aeropuerto.getLatitud()%>"required>
        </div>
        <div class="mb-3">
            <label class="form-label">Longitud</label>
            <input type="number" step="any" name="longitud" id="longitud" class="form-control" placeholder=" Longitud " value="<%=aeropuerto.getLongitud()%>"required>
        </div>
        <div class="mb-3">
            <label class="form-label">País</label>
            <input type="text" name="pais" class="form-control" id= "pais"  placeholder="Nombre del Pais" value="<%=aeropuerto.getPais()%>" required>
        </div>
        <div class="mb-3">
            <label class="form-label" for="estatus">Estatus</label>
      <select id="estatus" name="estatus" class="form-select" required>
        <option value="1"<%= aeropuerto.getEstatus() == Estatus.DISPONIBLE? "selected" :"" %> >Disponible</option>
        <option value="2"<%= aeropuerto.getEstatus() == Estatus.NO_DISPONIBLE? "selected" :"" %> >No Disponible</option>
      </select>
    </div>
    <button type="submit" class="btn btn-primary">Guardar</button>
</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
</html>
