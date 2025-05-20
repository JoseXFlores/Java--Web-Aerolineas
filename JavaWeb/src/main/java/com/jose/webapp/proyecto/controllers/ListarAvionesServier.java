package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.Avion;
import com.jose.webapp.proyecto.models.repositories.AvionRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/aviones/listar")
public class ListarAvionesServier extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AvionRepository repository = new AvionRepository(con);
        List<Avion> aviones;
        try {
            aviones = repository.listar();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("aviones", aviones);
        getServletContext().getRequestDispatcher("/listarAviones.jsp").forward(req,resp);
    }
}
