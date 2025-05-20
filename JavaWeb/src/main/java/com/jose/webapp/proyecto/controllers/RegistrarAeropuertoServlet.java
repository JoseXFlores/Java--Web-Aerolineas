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

@WebServlet ("/aeropuertos/alta")
public class RegistrarAeropuertoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/altaAeropuerto.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AeropuertoRepository repository = new AeropuertoRepository(con);

        String nombre = req.getParameter("nombre");
        String codigo = req.getParameter("codigo");
        String latitud = req.getParameter("latitud");
        String longitud = req.getParameter("longitud");
        String pais = req.getParameter("pais");
        String estatus = req.getParameter("estatus");

        Aeropuerto aeropuerto = new Aeropuerto(null, nombre, codigo, latitud, longitud, pais,
                Integer.parseInt(estatus) == 1 ? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE
                );

        try {
            repository.crear(aeropuerto);
            resp.sendRedirect(req.getContextPath() + "/aeropuertos/listar");
        } catch (SQLException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"ERROR AL CREAR AEROPUERTO: " + e.getMessage());

        }

    }
}

