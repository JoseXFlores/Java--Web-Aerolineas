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

@WebServlet ("/aviones/actualizar")
public class EditarAvionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AvionRepository repository = new AvionRepository(con);
        AerolineaRepository aerolineaRepository = new AerolineaRepository(con);
        Long id;
        try {
            id = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e) {
            id = 0L;
        }
        if (id > 0) {
            try {
                Optional<Avion> avion = repository.buscarPorId(id);
                if (avion.isPresent()) {
                    List<Aerolinea> aerolineas = aerolineaRepository.listar();
                    req.setAttribute("avion", avion.get());
                    req.setAttribute("aerolineas", aerolineas);
                    getServletContext().getRequestDispatcher("/editaAvion.jsp").forward(req, resp);
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
        AvionRepository repository = new AvionRepository(con);
        AerolineaRepository aerolineaRepository = new AerolineaRepository(con);

        Long id = Long.valueOf(req.getParameter("id"));
        String numRegistro = req.getParameter("numRegistro");
        String tipo = req.getParameter("tipo");
        String codigoModelo = req.getParameter("codigoModelo");
        int capacidad = Integer.parseInt(req.getParameter("capacidad"));
        String fechaPrimerVuelo = req.getParameter("fechaPrimerVuelo");
        String estatus = req.getParameter("estatus");
        Long idAerolinea = Long.parseLong(req.getParameter("aerolinea"));
        LocalDate fecha;
        try{
            fecha = LocalDate.parse(fechaPrimerVuelo, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        }catch (DateTimeParseException e){
            fecha=null;
        }
        try {
            Optional<Aerolinea> aerolinea = aerolineaRepository.buscarPorId(idAerolinea);
            Aerolinea aerolinea1 = aerolinea.orElse(null);

            Avion avion = new Avion(id, numRegistro, tipo, codigoModelo, capacidad, fecha,
                    Integer.parseInt(estatus) == 1 ? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE, aerolinea1);
            repository.actualizar(avion);
            resp.sendRedirect(req.getContextPath() + "/aviones/listar");
            } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ERROR AL EDITAR AVION: "+  e.getMessage());
        }
    }
}
