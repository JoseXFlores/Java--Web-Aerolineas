package com.jose.webapp.proyecto.models.repositories;

import com.jose.webapp.proyecto.models.Aeropuerto;
import com.jose.webapp.proyecto.models.Avion;
import com.jose.webapp.proyecto.models.Vuelo;
import com.jose.webapp.proyecto.models.enums.Estatus;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class VueloRepository implements IRepository<Vuelo>{
    private final Connection conn;

    public VueloRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Vuelo> listar() throws SQLException {
        List<Vuelo> vuelos = new ArrayList<>();
        try(Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM VUELO");) {
            while (rs.next()){
                vuelos.add(obtenerDato(rs));
            }
        }catch (SQLException e){
            throw new RuntimeException(e.getMessage());
        }
        return vuelos;
    }


    @Override
    public Optional<Vuelo> buscarPorId(Long id) throws SQLException {
        Vuelo vuelo = null;
        String query = "SELECT * FROM VUELO WHERE ID_VUELO = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    vuelo = obtenerDato(rs);
                }
            }
        }
        return Optional.ofNullable(vuelo);
    }

    @Override
    public void crear(Vuelo elemento) throws SQLException {
        String sql = "{ CALL CREAR_O_ACTUALIZAR_VUELO(?,?,?,?,?,?,?)}";
        try(CallableStatement cs = conn.prepareCall(sql)){
            cs.setNull(1, Types.NULL);
            //cs.setLong(1,0L); //si trabaja con 0
            cs.setString(2, elemento.getCodigoVuelo());
            cs.setLong(3, elemento.getAvion().getId());
            cs.setLong(4, elemento.getOrigen().getId());
            cs.setLong(5, elemento.getDestino().getId());
            cs.setTimestamp(6, Timestamp.valueOf(elemento.getFechaSalida()));
            cs.setLong(7, elemento.getEstatus()== Estatus.DISPONIBLE? 1:2);
            cs.executeUpdate();
        }
    }

    @Override
    public void actualizar(Vuelo elemento) throws SQLException {
        String sql = "{ CALL CREAR_O_ACTUALIZAR_VUELO(?,?,?,?,?,?,?)}";
        try(CallableStatement cs = conn.prepareCall(sql)){
            cs.setLong(1, elemento.getId());
            //cs.setLong(1,0L); //si trabaja con 0
            cs.setString(2, elemento.getCodigoVuelo());
            cs.setLong(3, elemento.getAvion().getId());
            cs.setLong(4, elemento.getOrigen().getId());
            cs.setLong(5, elemento.getDestino().getId());
            cs.setTimestamp(6, Timestamp.valueOf(elemento.getFechaSalida()));
            cs.setLong(7, elemento.getEstatus()== Estatus.DISPONIBLE? 1:2);
            cs.executeUpdate();
        }

    }

    @Override
    public void eliminar(Long id) throws SQLException {
        String sql ="{ CALL ELIMINAR_VUELO(?)}";
        try ( CallableStatement cs = conn.prepareCall(sql)) {
            cs.setLong(1,id);
            cs.executeUpdate();
        }

    }

    @Override
    public Vuelo obtenerDato(ResultSet rs) throws SQLException {
        Vuelo vuelo = new Vuelo();
        vuelo.setId(rs.getLong("ID_VUELO"));
        vuelo.setCodigoVuelo(rs.getString("CODIGO_VUELO"));

        AvionRepository avionRepository = new AvionRepository(conn);
        AeropuertoRepository aeropuertoRepository = new AeropuertoRepository(conn);

        // Establecer avión (si existe)
        Optional<Avion> avion = avionRepository.buscarPorId(rs.getLong("ID_AVION"));
        avion.ifPresent(vuelo::setAvion);

        // Establecer origen (si existe)
        Optional<Aeropuerto> origen = aeropuertoRepository.buscarPorId(rs.getLong("ID_ORIGEN"));
        origen.ifPresent(vuelo::setOrigen);

        // Establecer destino (si existe)
        Optional<Aeropuerto> destino = aeropuertoRepository.buscarPorId(rs.getLong("ID_DESTINO"));
        destino.ifPresent(vuelo::setDestino);
        vuelo.setFechaSalida(rs.getTimestamp("FECHA_SALIDA").toLocalDateTime());

        vuelo.setEstatus(rs.getInt("ID_ESTATUS") == 1? Estatus.DISPONIBLE : Estatus.NO_DISPONIBLE );
        return vuelo;
    }
}
