<style>
    /* Fondo con degradado y sombra */
    .navbar-custom {
        background: linear-gradient(90deg, #0f2027, #203a43, #2c5364);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }

    .navbar-brand {
        font-weight: bold;
        font-size: 1.5rem;
        color: #f8f9fa !important;
        transition: transform 0.3s ease;
    }

    .navbar-brand:hover {
        transform: scale(1.05);
    }

    .nav-link {
        color: #f1f1f1 !important;
        font-weight: 500;
        transition: color 0.3s ease, background 0.3s ease;
    }

    .nav-link:hover, .dropdown-item:hover {
        color: #ffc107 !important;
        background-color: rgba(255, 255, 255, 0.1);
    }

    .dropdown-menu {
        background-color: #1e1e2f;
        border: none;
        border-radius: 0.5rem;
        box-shadow: 0 6px 12px rgba(0,0,0,0.2);
    }

    .dropdown-item {
        color: #f8f9fa;
        transition: background 0.3s ease;
    }

    .dropdown-item:hover {
        background-color: #343a40;
    }

    .navbar-toggler {
        border-color: #ffc107;
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba%28255,193,7,1%29' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="/JavaWeb/">Aerolineas App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <!-- Menús con submenús -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarAerolineas" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Aerolineas
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarAerolineas">
                        <li><a href='<%=request.getContextPath()%>/aerolineas/listar' class="dropdown-item">Listar Aerolineas</a></li>
                        <li><a href='<%=request.getContextPath()%>/aerolineas/alta' class="dropdown-item">Alta Aerolineas</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarAeropuertos" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Aeropuertos
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarAeropuertos">
                        <li><a href='<%=request.getContextPath()%>/aeropuertos/listar' class="dropdown-item">Listar Aeropuertos</a></li>
                        <li><a href='<%=request.getContextPath()%>/aeropuertos/alta' class="dropdown-item">Alta Aeropuertos</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarAviones" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Aviones
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarAviones">
                        <li><a href='<%=request.getContextPath()%>/aviones/listar' class="dropdown-item">Listar Aviones</a></li>
                        <li><a href='<%=request.getContextPath()%>/aviones/alta' class="dropdown-item">Alta Aviones</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarVuelos" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Vuelos
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarVuelos">
                        <li><a href='<%=request.getContextPath()%>/vuelos/listar' class="dropdown-item">Listar Vuelos</a></li>
                        <li><a href='<%=request.getContextPath()%>/vuelos/alta' class="dropdown-item">Alta Vuelos</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>

    <button class="btn btn-outline-light ms-auto" id="toggleTheme">
        <i class="bi bi-sun-fill" id="themeIcon"></i>
    </button>

</nav>
