package com.jose.webapp.proyecto.models;

import com.jose.webapp.proyecto.models.enums.Estatus;

import java.time.LocalDateTime;

public class Vuelo {

    private Long id;
    private String codigoVuelo;
    private Avion avion;
    private Aeropuerto origen;
    private Aeropuerto destino;
    private LocalDateTime fechaSalida;
    private Estatus estatus;

    public Vuelo() {
    }

    public Vuelo(Long id, String codigoVuelo, Avion avion, Aeropuerto origen, Aeropuerto destino, LocalDateTime fechaSalida, Estatus estatus) {
        this.id = id;
        this.codigoVuelo = codigoVuelo;
        this.avion = avion;
        this.origen = origen;
        this.destino = destino;
        this.fechaSalida = fechaSalida;
        this.estatus = estatus;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCodigoVuelo() {
        return codigoVuelo;
    }

    public void setCodigoVuelo(String codigoVuelo) {
        this.codigoVuelo = codigoVuelo;
    }

    public Avion getAvion() {
        return avion;
    }

    public void setAvion(Avion avion) {
        this.avion = avion;
    }

    public Aeropuerto getOrigen() {
        return origen;
    }

    public void setOrigen(Aeropuerto origen) {
        this.origen = origen;
    }

    public Aeropuerto getDestino() {
        return destino;
    }

    public void setDestino(Aeropuerto destino) {
        this.destino = destino;
    }

    public LocalDateTime getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(LocalDateTime fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public Estatus getEstatus() {
        return estatus;
    }

    public void setEstatus(Estatus estatus) {
        this.estatus = estatus;
    }
}
