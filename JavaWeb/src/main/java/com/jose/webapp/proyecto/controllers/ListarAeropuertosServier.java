package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.Aerolinea;
import com.jose.webapp.proyecto.models.Aeropuerto;
import com.jose.webapp.proyecto.models.repositories.AeropuertoRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/aeropuertos/listar")
public class ListarAeropuertosServier extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AeropuertoRepository repository = new AeropuertoRepository(con);

        List<Aeropuerto> aeropuertos;
        try {
            aeropuertos = repository.listar();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("aeropuertos", aeropuertos);
        getServletContext().getRequestDispatcher("/listarAeropuertos.jsp").forward(req, resp);
    }
}
