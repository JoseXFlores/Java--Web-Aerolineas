<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aerolíneas App - Panel de Control</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
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

        .hero-section {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 5rem 0;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center;
            background-size: cover;
            opacity: 0.15;
        }

        .dashboard-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .stats-card {
            background: white;
            border-left: 4px solid var(--primary-color);
        }

        .quick-actions {
            background: white;
        }

        .action-btn {
            width: 100%;
            margin-bottom: 0.5rem;
            text-align: left;
            padding: 0.75rem 1.25rem;
        }

        .recent-activity {
            background: white;
        }

        .activity-item {
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        footer {
            background-color: var(--secondary-color);
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
    </style>
</head>
<body>



<!-- Navbar (existente - no modificar) -->



<div style="display: none;">
    <jsp:include page="navbar.jsp"/>
</div>


    <!-- Tu navbar existente aquí -->


<!-- Hero Section -->
<section class="hero-section">
    <div class="container text-center position-relative">
        <h1 class="display-4 fw-bold mb-3">Panel de Control Aerolíneas</h1>
        <p class="lead mb-4">Gestión integral de aerolíneas, aeropuertos, aviones y vuelos</p>
        <div class="d-flex justify-content-center gap-3">
            <a href="#quick-actions" class="btn btn-light btn-lg px-4">Acciones Rápidas</a>
            <a href="#stats" class="btn btn-outline-light btn-lg px-4">Ver Estadísticas</a>
        </div>
    </div>
</section>

<!-- Main Content -->
<div class="container mb-5">
    <!-- Quick Stats -->
    <div id="stats" class="row mb-5">
        <div class="col-md-3">
            <div class="dashboard-card stats-card p-4">
                <i class="fas fa-plane card-icon"></i>
                <h3 class="h5">Aerolíneas</h3>
                <p class="display-6 fw-bold">24</p>
                <a href="<%=request.getContextPath()%>/aerolineas/listar" class="btn btn-sm btn-outline-primary">Ver todas</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card stats-card p-4">
                <i class="fas fa-building card-icon"></i>
                <h3 class="h5">Aeropuertos</h3>
                <p class="display-6 fw-bold">156</p>
                <a href="<%=request.getContextPath()%>/aeropuertos/listar" class="btn btn-sm btn-outline-primary">Ver todos</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card stats-card p-4">
                <i class="fas fa-fighter-jet card-icon"></i>
                <h3 class="h5">Aviones</h3>
                <p class="display-6 fw-bold">342</p>
                <a href="<%=request.getContextPath()%>/aviones/listar" class="btn btn-sm btn-outline-primary">Ver todos</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card stats-card p-4">
                <i class="fas fa-route card-icon"></i>
                <h3 class="h5">Vuelos</h3>
                <p class="display-6 fw-bold">1,245</p>
                <a href="<%=request.getContextPath()%>/vuelos/listar" class="btn btn-sm btn-outline-primary">Ver todos</a>
            </div>
        </div>
    </div>

    <!-- Quick Actions and Recent Activity -->
    <div class="row">
        <div class="col-md-6">
            <div class="dashboard-card quick-actions p-4" id="quick-actions">
                <h2 class="h4 mb-4"><i class="fas fa-bolt me-2"></i>Acciones Rápidas</h2>
                <div class="d-grid gap-2">
                    <a href="<%=request.getContextPath()%>/aerolineas/alta" class="btn action-btn btn-outline-primary">
                        <i class="fas fa-plus-circle me-2"></i>Nueva Aerolínea
                    </a>
                    <a href="<%=request.getContextPath()%>/aeropuertos/alta" class="btn action-btn btn-outline-primary">
                        <i class="fas fa-plus-circle me-2"></i>Nuevo Aeropuerto
                    </a>
                    <a href="<%=request.getContextPath()%>/aviones/alta" class="btn action-btn btn-outline-primary">
                        <i class="fas fa-plus-circle me-2"></i>Nuevo Avión
                    </a>
                    <a href="<%=request.getContextPath()%>/vuelos/alta" class="btn action-btn btn-outline-primary">
                        <i class="fas fa-plus-circle me-2"></i>Nuevo Vuelo
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="dashboard-card recent-activity p-4">
                <h2 class="h4 mb-4"><i class="fas fa-clock-rotate-left me-2"></i>Actividad Reciente</h2>
                <div class="activity-item">
                    <div class="d-flex justify-content-between">
                        <span><i class="fas fa-plane me-2 text-primary"></i>Nueva aerolínea registrada</span>
                        <small class="text-muted">Hace 2 horas</small>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="d-flex justify-content-between">
                        <span><i class="fas fa-fighter-jet me-2 text-success"></i>Avión actualizado</span>
                        <small class="text-muted">Hace 5 horas</small>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="d-flex justify-content-between">
                        <span><i class="fas fa-route me-2 text-info"></i>Nuevo vuelo programado</span>
                        <small class="text-muted">Ayer</small>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="d-flex justify-content-between">
                        <span><i class="fas fa-building me-2 text-warning"></i>Aeropuerto añadido</span>
                        <small class="text-muted">Ayer</small>
                    </div>
                </div>
                <a href="#" class="btn btn-sm btn-link mt-2 ps-0">Ver toda la actividad</a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="text-center">
    <div class="container">
        <div class="row">
            <div class="col-md-6 text-md-start">
                <h5 class="mb-3">Sistema de Gestión Aeroportuaria</h5>
                <p class="mb-0">© 2023 Todos los derechos reservados</p>
            </div>
            <div class="col-md-6 text-md-end mt-3 mt-md-0">
                <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="text-white me-3"><i class="fab fa-linkedin-in"></i></a>
                <a href="#" class="text-white"><i class="fab fa-github"></i></a>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Puedes añadir interactividad aquí si lo deseas
    document.addEventListener('DOMContentLoaded', function() {
        // Ejemplo: Animación al cargar las tarjetas
        const cards = document.querySelectorAll('.dashboard-card');
        cards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = 1;
            }, 100 * index);
        });
    });
</script>
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>

</html>