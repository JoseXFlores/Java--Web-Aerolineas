package com.jose.webapp.proyecto.models.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface IRepository<T> {
    List<T> listar()  throws SQLException;
    Optional<T> buscarPorId(Long id) throws SQLException;
    void crear(T elemento) throws SQLException;
    void actualizar(T elemento) throws SQLException ;
    void eliminar(Long id ) throws SQLException;
    T obtenerDato(ResultSet rs) throws SQLException;


}
