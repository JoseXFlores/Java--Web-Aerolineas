package com.jose.webapp.proyecto.controllers;

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

@WebServlet("/vuelos/alta")
public class RegistrarVuelosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");

        AvionRepository avionRepository = new AvionRepository(con);
        AeropuertoRepository aeropuertoRepository = new AeropuertoRepository(con);

        try {
            List<Avion> aviones = avionRepository.listar();
            List<Aeropuerto> aeropuertos = aeropuertoRepository.listar();

            req.setAttribute("aviones", aviones);
            req.setAttribute("aeropuertos", aeropuertos);

            getServletContext().getRequestDispatcher("/altaVuelo.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Error al obtener datos para el formulario de alta de vuelos", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");

        VueloRepository vueloRepository = new VueloRepository(con);
        AvionRepository avionRepository = new AvionRepository(con);
        AeropuertoRepository aeropuertoRepository = new AeropuertoRepository(con);

        String codigoVuelo = req.getParameter("codigoVuelo");
        Long idAvion = Long.parseLong(req.getParameter("avion"));
        Long idOrigen = Long.parseLong(req.getParameter("origen"));
        Long idDestino = Long.parseLong(req.getParameter("destino"));
        String fechaSalida = req.getParameter("fechaSalida");
        String estatus = req.getParameter("estatus");

        LocalDateTime fecha = LocalDateTime.parse(fechaSalida);
        try {
            fecha = LocalDateTime.parse(fechaSalida, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (DateTimeParseException ignored) {}

        try {
            Optional<Avion> avionOpt = avionRepository.buscarPorId(idAvion);
            Optional<Aeropuerto> origenOpt = aeropuertoRepository.buscarPorId(idOrigen);
            Optional<Aeropuerto> destinoOpt = aeropuertoRepository.buscarPorId(idDestino);

            if (avionOpt.isPresent() && origenOpt.isPresent() && destinoOpt.isPresent()) {
                Vuelo vuelo = new Vuelo(
                        null,
                        codigoVuelo,
                        avionOpt.get(),
                        origenOpt.get(),
                        destinoOpt.get(),
                        fecha,
                        "1".equals(estatus) ? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE
                );
                vueloRepository.crear(vuelo);
                resp.sendRedirect(req.getContextPath() + "/vuelos/listar");
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Datos inválidos para crear el vuelo");
            }

        } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"ERROR AL CREAR: " + e.getMessage());
        }
    }
}

