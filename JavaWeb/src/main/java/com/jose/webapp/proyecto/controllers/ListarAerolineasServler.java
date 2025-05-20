package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.Aerolinea;
import com.jose.webapp.proyecto.models.repositories.AerolineaRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/aerolineas/listar")
public class ListarAerolineasServler extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AerolineaRepository repository = new AerolineaRepository(con);

        List<Aerolinea> aerolineas;
        try {
            aerolineas = repository.listar();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("aerolineas", aerolineas);
        getServletContext().getRequestDispatcher("/listarAerolineas.jsp").forward(req, resp);
    }
}
