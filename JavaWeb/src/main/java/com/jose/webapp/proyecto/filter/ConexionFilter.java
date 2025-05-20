package com.jose.webapp.proyecto.filter;

import com.jose.webapp.proyecto.utils.ConexionDB;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebFilter("/*")
public class ConexionFilter implements Filter {

    private Connection getConnection(){
        return ConexionDB.getInstance();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        Connection con = null;
        try {
            con = this.getConnection();
            servletRequest.setAttribute("conn",con);
            filterChain.doFilter(servletRequest,servletResponse);
        } finally{
            if(con != null){
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
