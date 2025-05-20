package com.jose.webapp.proyecto.controllers;

import com.jose.webapp.proyecto.models.repositories.AvionRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet ("/aviones/eliminar")
public class EliminarAvionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection con = (Connection) req.getAttribute("conn");
        AvionRepository repository = new AvionRepository(con);
        long id;
        try{
            id = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e) {
            id = 0L;
        }
        if(id>0){
            try{
                repository.eliminar(id);
                resp.sendRedirect(req.getContextPath() + "/aviones/listar");
            } catch(SQLException e){
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"ERROR AL ELIMINAR: " + e.getMessage());
            }
        }else{
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "EL ID NO PUEDE SER NULO");
        }
    }
}
