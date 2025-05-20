package com.jose.webapp.proyecto.controllers;
import com.jose.webapp.proyecto.models.Aerolinea;
import com.jose.webapp.proyecto.models.enums.Estatus;
import com.jose.webapp.proyecto.models.repositories.AerolineaRepository;
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
import java.util.Optional;

@WebServlet("/aerolineas/actualizar")
public class EditarAerolineaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AerolineaRepository repository = new AerolineaRepository(con);
        long id;
        try {
            id = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e) {
            id= 0L;

        }if (id > 0) {
            try {
                Optional<Aerolinea> aerolinea = repository.buscarPorId(id);
                if (aerolinea.isPresent()) {
                    req.setAttribute("aerolinea", aerolinea.get());
                    getServletContext().getRequestDispatcher("/editaAerolinea.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Aerolinea no encontrada" + id);
                }

            } catch (Exception e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error al consultar " + e.getMessage());
            }
        }else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Id no puede ser nulo");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AerolineaRepository repository = new AerolineaRepository(con);
        Long id = Long.parseLong(req.getParameter("id"));
        String nombre = req.getParameter("nombre");
        String iata = req.getParameter("iata");
        String pais = req.getParameter("pais");
        String fechaFundacion = req.getParameter("fundacion");
        String estatus = req.getParameter("estatus");
        LocalDate fecha;
        try {
            fecha = LocalDate.parse(fechaFundacion, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (DateTimeParseException e) {
            fecha = null;
        }
        Aerolinea aerolinea = new Aerolinea(id, nombre, iata,
                Integer.parseInt(estatus) == 1 ? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE, pais, fecha);
        try {
            repository.actualizar(aerolinea);
            resp.sendRedirect(req.getContextPath() + "/aerolineas/listar");
        } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "ERROR AL EDITAR LA AEROLINEA: " + e.getMessage());
        }
    }
}