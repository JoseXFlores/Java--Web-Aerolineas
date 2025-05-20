package com.jose.webapp.proyecto.models.repositories;

import com.jose.webapp.proyecto.models.Aerolinea;
import com.jose.webapp.proyecto.models.Avion;
import com.jose.webapp.proyecto.models.enums.Estatus;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AvionRepository implements IRepository<Avion> {
    private Connection conn;

    public AvionRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Avion> listar() throws SQLException {
        List<Avion> aviones = new ArrayList<>();
        try(Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Avion");) {
            while (rs.next()){
                aviones.add(obtenerDato(rs));
            }
        }
        return aviones;
    }

    @Override
    public Optional<Avion> buscarPorId(Long id) throws SQLException{
        Avion avion = null;
        String query = "SELECT * FROM AVION WHERE ID_AVION = ?";
        try(PreparedStatement stmt = conn.prepareStatement(query)){
            stmt.setLong(1,id);
            try (ResultSet rs = stmt.executeQuery()){
                if(rs.next()) {
                    avion = obtenerDato(rs);
                }
            }
        }
        return Optional.ofNullable(avion);
    }

    @Override
    public void crear(Avion elemento) throws SQLException {
        String sql = "{ CALL CREAR_O_ACTUALIZAR_AVION(?,?,?,?,?,?,?,?)}";
        try(CallableStatement cs = conn.prepareCall(sql)){
            cs.setNull(1, Types.NULL);
            //cs.setLong(1,0L); //si trabaja con 0
            cs.setString(2, elemento.getNumRegistro());
            cs.setString(3, elemento.getTipo());
            cs.setString(4, elemento.getCodigoModelo());
            cs.setInt(5, elemento.getCapacidad());
            cs.setDate(6, Date.valueOf(elemento.getFechaPrimerVuelo()));
            cs.setLong(7, elemento.getEstatus()== Estatus.DISPONIBLE? 1:2);
            cs.setLong(8, elemento.getAerolinea().getId());
            cs.executeUpdate();
        }

    }

    @Override
    public void actualizar(Avion elemento) throws SQLException {
        String sql = "{ CALL CREAR_O_ACTUALIZAR_AVION(?,?,?,?,?,?,?,?)}";
        try(CallableStatement cs = conn.prepareCall(sql)){
            cs.setLong(1, elemento.getId());
            //cs.setLong(1,0L); //si trabaja con 0
            cs.setString(2, elemento.getNumRegistro());
            cs.setString(3, elemento.getTipo());
            cs.setString(4, elemento.getCodigoModelo());
            cs.setInt(5, elemento.getCapacidad());
            cs.setDate(6, Date.valueOf(elemento.getFechaPrimerVuelo()));
            cs.setLong(7, elemento.getEstatus()== Estatus.DISPONIBLE? 1:2);
            cs.setLong(8, elemento.getAerolinea().getId());
            cs.executeUpdate();
        }

    }

    @Override
    public void eliminar(Long id) throws SQLException {
        String sql ="{ CALL ELIMINAR_AVION(?)}";
        try ( CallableStatement cs = conn.prepareCall(sql)) {
            cs.setLong(1,id);
            cs.executeUpdate();
        }
    }

    @Override
    public Avion obtenerDato(ResultSet rs) throws SQLException {
        Avion avion = new Avion();
        avion.setId(rs.getLong("ID_AVION"));
        avion.setNumRegistro(rs.getString("NUM_REGISTRO"));
        avion.setTipo(rs.getString("TIPO"));
        avion.setCodigoModelo(rs.getString("CODIGO_MODELO"));
        avion.setCapacidad(rs.getInt("CAPACIDAD"));
        avion.setFechaPrimerVuelo(rs.getDate("FECHA_PRIMER_VUELO").toLocalDate());
        avion.setEstatus(rs.getInt("ID_ESTATUS") == 1 ? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE);

        AerolineaRepository aerolineaRepository=new AerolineaRepository(conn);
        Optional<Aerolinea> aerolinea = aerolineaRepository.buscarPorId(rs.getLong("ID_AEROLINEA"));
        aerolinea.ifPresent(avion::setAerolinea);
        return avion;
    }
}