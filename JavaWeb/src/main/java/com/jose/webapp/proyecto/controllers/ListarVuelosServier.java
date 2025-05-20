package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.Vuelo;
import com.jose.webapp.proyecto.models.repositories.VueloRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/vuelos/listar")
public class ListarVuelosServier extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        VueloRepository repository = new VueloRepository(con);
        List<Vuelo> vuelos;
        try {
            vuelos = repository.listar();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("vuelos", vuelos);
        getServletContext().getRequestDispatcher("/listarVuelos.jsp").forward(req, resp);
    }
}
