package com.jose.webapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/parametros")
public class EjemploServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out =resp.getWriter();
        String saludo = req.getParameter("saludo");
        String nombre = req.getParameter("nombre");

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("   <head> ");
        out.println("       <meta charset=\"UTF-8\">");
        out.println("       <title>Parametros GET de la URL</title>");
        out.println("   </head>");
        out.println("   <body>");
        out.println("       <h1>Parametros GET de la URL</h1>");
        if(saludo != null && nombre !=null){
            out.println("   <h2> El saludo enviado es : " + saludo +
                    ", el nombre enviado es : " + nombre + "</h2>");
        } else if (saludo!=null){
            out.println("   <h2> El saludo enviado es : " + saludo + "</h2>");
        } else if (nombre!=null){
            out.println("   <h2> El nombre enviado es : " + nombre + "</h2>");
        } else {
            out.println("   <h2> NO SE HAN PASADO LOS PARAMETROS SALUDO NI NOMBRE </h2>");
        }
        try {
            int codigo = Integer.parseInt(req.getParameter("codigo"));
            out.println("   <h3> El codigo enviado es : " + codigo + "</h3>");
        }catch (NumberFormatException e){
            out.println("   <h3> El codigo no se ha enviado o no es un valor numerico, es null </h3>");
        }
        out.println("   </body>");
        out.println("</html>");
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String edad = req.getParameter("edad");

        resp.setContentType("text/html");
        PrintWriter out =resp.getWriter();
        out.println("<html><body>");
        out.println("       <h1> Parámetros recibidos </h1>");
        out.println("       <p> Nombre: " + nombre + "</p>");
        out.println("       <p> Edad: " + edad + "</p>");
        out.println("</body></html>");
        out.close();
    }
}

// http://localhost:8080/JavaWeb/parametros?nombre=Christian&saludo=Kepedal&codigo=768