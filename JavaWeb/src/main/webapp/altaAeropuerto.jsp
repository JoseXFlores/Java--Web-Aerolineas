<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Crear Aeropuerto</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">

  </head>

<body class="container mt-5">
  <jsp:include page="navbar.jsp"/>

<h2>Crear Aeropuerto</h2>

<form action="<%=request.getContextPath()%>/aeropuertos/alta" method="post">
<form method="post" action="crearAeropuerto">
  <div class="mb-3">

    <label class="form-label">Nombre</label>
     <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre del Aeropuerto" value="${param.nombre}" required>

    </div>
  <div class="mb-3">
    <label class="form-label">Código</label>
    <input type="text" name="codigo" class="form-control" maxlength="5" placeholder="Codigo " value="${param.codigo}" required>
  </div>

  <div class="mb-3">
    <label class="form-label">Latitud</label>
    <input type="number" step="any" name="latitud" class="form-control" placeholder="Latitud" value="${param.latitud}"required>
  </div>

  <div class="mb-3">
    <label class="form-label">Longitud</label>
    <input type="number" step="any" name="longitud" class="form-control" placeholder=" Longitud " value="${param.longitud}"required>
  </div>

  <div class="mb-3">
    <label class="form-label">País</label>
    <input type="text" name="pais" class="form-control" id= "pais"  placeholder="Nombre del Pais" value="${param.pais}" required>
  </div>
  <div class="mb-3">
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
