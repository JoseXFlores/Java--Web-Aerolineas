package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.Aerolinea;
import com.jose.webapp.proyecto.models.Avion;
import com.jose.webapp.proyecto.models.enums.Estatus;
import com.jose.webapp.proyecto.models.repositories.AerolineaRepository;
import com.jose.webapp.proyecto.models.repositories.AvionRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Optional;

@WebServlet("/aviones/alta")
public class RegistrarAvionesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AerolineaRepository aerolineaRepository = new AerolineaRepository(con);
        try {
            List<Aerolinea> aerolineas = aerolineaRepository.listar();
            req.setAttribute("aerolineas", aerolineas);
            getServletContext().getRequestDispatcher("/altaAvion.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AvionRepository repository = new AvionRepository(con);
        AerolineaRepository aerolineaRepository = new AerolineaRepository(con);

        String numRegistro = req.getParameter("numRegistro");
        String tipo = req.getParameter("tipo");
        String codigoModelo = req.getParameter("codigoModelo");
        int capacidad = Integer.parseInt(req.getParameter("capacidad"));
        String fechaPrimerVuelo = req.getParameter("fechaPrimerVuelo");
        String estatus = req.getParameter("estatus");
        Long idAerolinea = Long.parseLong(req.getParameter("aerolinea"));
        LocalDate fecha;
        try {
            fecha = LocalDate.parse(fechaPrimerVuelo, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (DateTimeParseException e) {
            fecha = null;
        }
        try {
            Optional<Aerolinea> aerolinea = aerolineaRepository.buscarPorId(idAerolinea);
            Aerolinea aerolinea1 = aerolinea.orElse(null);
            Avion avion = new Avion(0L, numRegistro, tipo, codigoModelo, capacidad, fecha,
                    Integer.parseInt(estatus) == 1 ? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE,
                    aerolinea1);
            repository.crear(avion);
            resp.sendRedirect(req.getContextPath() + "/aviones/listar");
        } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ERROR AL CREAR AVION: "+  e.getMessage());
        }
    }
}


