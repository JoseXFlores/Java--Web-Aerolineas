package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.Aerolinea;
import com.jose.webapp.proyecto.models.Aeropuerto;
import com.jose.webapp.proyecto.models.Avion;
import com.jose.webapp.proyecto.models.Vuelo;
import com.jose.webapp.proyecto.models.enums.Estatus;

import com.jose.webapp.proyecto.models.repositories.AeropuertoRepository;
import com.jose.webapp.proyecto.models.repositories.AvionRepository;
import com.jose.webapp.proyecto.models.repositories.VueloRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Optional;

@WebServlet("/vuelos/actualizar")
public class EditarVueloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        VueloRepository repository = new VueloRepository(con);
        AvionRepository avionRepository = new AvionRepository(con);
        AeropuertoRepository aeropuertoRepository = new AeropuertoRepository(con);
        Long id;
        try {
            id = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e) {
            id = 0L;
        }
        if (id > 0) {
            try {
                Optional<Vuelo> vuelo = repository.buscarPorId(id);
                if (vuelo.isPresent()) {
                    List<Avion> aviones = avionRepository.listar();
                    List<Aeropuerto> aeropuertos = aeropuertoRepository.listar();

                    req.setAttribute("aviones", aviones);
                    req.setAttribute("aeropuertos", aeropuertos);
                    req.setAttribute("vuelo", vuelo.get());

                    getServletContext().getRequestDispatcher("/editaVuelo.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "NO EXISTE EL AVION CON EL ID" + id);
                }
            } catch (Exception e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error al consultar " + e.getMessage());
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Id no puede ser nulo");

        }

    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");

        VueloRepository repository = new VueloRepository(con);
        AvionRepository avionRepository = new AvionRepository(con);
        AeropuertoRepository aeropuertoRepository = new AeropuertoRepository(con);

        Long id = Long.valueOf(req.getParameter("id"));
        String codigoVuelo = req.getParameter("codigoVuelo");
        Long idAvion = Long.parseLong(req.getParameter("avion"));
        Long idOrigen = Long.parseLong(req.getParameter("origen"));
        Long idDestino = Long.parseLong(req.getParameter("destino"));
        String fechaSalida = req.getParameter("fechaSalida");
        LocalDateTime fecha = LocalDateTime.parse(fechaSalida);
        String estatus = req.getParameter("estatus");

        try {
            fecha = LocalDateTime.parse(fechaSalida, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (DateTimeParseException ignored) {}

        try {
            Optional<Avion> avionOpt = avionRepository.buscarPorId(idAvion);
            Avion avion1 = avionOpt.orElse(null);

            Optional<Aeropuerto> origenOpt = aeropuertoRepository.buscarPorId(idOrigen);
            Aeropuerto aeropuerto = origenOpt.orElse(null);

            Optional<Aeropuerto> destinoOpt = aeropuertoRepository.buscarPorId(idDestino);
            Aeropuerto aeropuerto2 = destinoOpt.orElse(null);

                Vuelo vuelo = new Vuelo(id, codigoVuelo, avion1, aeropuerto,aeropuerto2, fecha,
                        Integer.parseInt(estatus) == 1 ? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE);
                repository.actualizar(vuelo);
                resp.sendRedirect(req.getContextPath() + "/vuelos/listar");
            } catch (SQLException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ERROR AL EDITAR EL VUELO: "+  e.getMessage());
            }
    }
}
