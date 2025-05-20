package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.Aeropuerto;
import com.jose.webapp.proyecto.models.enums.Estatus;

import com.jose.webapp.proyecto.models.repositories.AeropuertoRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet("/aeropuertos/actualizar")
public class EditarAeropuertoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AeropuertoRepository repository = new AeropuertoRepository(con);
        long id;
        try {
            id = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e) {
            id= 0L;

        }if (id > 0) {
            try {
                Optional<Aeropuerto> aeropuerto = repository.buscarPorId(id);
                if (aeropuerto.isPresent()) {
                    req.setAttribute("aeropuerto", aeropuerto.get());
                    getServletContext().getRequestDispatcher("/editaAeropuerto.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Aeropuerto no encontrado" + id);
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
        AeropuertoRepository repository = new AeropuertoRepository(con);

        Long id = Long.parseLong(req.getParameter("id"));
        String nombre = req.getParameter("nombre");
        String codigo = req.getParameter("codigo");
        String latitud = req.getParameter("latitud");
        String longitud = req.getParameter("longitud");
        String pais = req.getParameter("pais");
        String estatusParam = req.getParameter("estatus");

        Estatus estatus = null;
        if ("1".equals(estatusParam)) {
            estatus = Estatus.DISPONIBLE;
        } else if ("2".equals(estatusParam)) {
            estatus = Estatus.NO_DISPONIBLE;
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Estatus inválido.");
            return;
        }

        Aeropuerto aeropuerto = new Aeropuerto(id, nombre, codigo, latitud, longitud, pais, estatus);

        try {
            repository.actualizar(aeropuerto);
            resp.sendRedirect(req.getContextPath() + "/aeropuertos/listar");
        } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "ERROR AL ACTUALIZAR EL AEROPUERTO: " + e.getMessage());
        }
    }
}


