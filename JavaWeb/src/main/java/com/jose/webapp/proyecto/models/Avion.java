package com.jose.webapp.proyecto.models;

import com.jose.webapp.proyecto.models.enums.Estatus;

import java.time.LocalDate;

public class Avion {

    private Long id;
    private String numRegistro;
    private String tipo;
    private String codigoModelo;
    private int capacidad;
    private LocalDate fechaPrimerVuelo;
    private Estatus estatus;
    private Aerolinea aerolinea;

    public Avion() {
    }

    public Avion(Long id, String numRegistro, String tipo, String codigoModelo, int capacidad, LocalDate fechaPrimerVuelo, Estatus estatus, Aerolinea aerolinea) {
        this.id = id;
        this.numRegistro = numRegistro;
        this.tipo = tipo;
        this.codigoModelo = codigoModelo;
        this.capacidad = capacidad;
        this.fechaPrimerVuelo = fechaPrimerVuelo;
        this.estatus = estatus;
        this.aerolinea = aerolinea;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumRegistro() {
        return numRegistro;
    }

    public void setNumRegistro(String numRegistro) {
        this.numRegistro = numRegistro;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getCodigoModelo() {
        return codigoModelo;
    }

    public void setCodigoModelo(String codigoModelo) {
        this.codigoModelo = codigoModelo;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }

    public LocalDate getFechaPrimerVuelo() {
        return fechaPrimerVuelo;
    }

    public void setFechaPrimerVuelo(LocalDate fechaPrimerVuelo) {
        this.fechaPrimerVuelo = fechaPrimerVuelo;
    }

    public Estatus getEstatus() {
        return estatus;
    }

    public void setEstatus(Estatus estatus) {
        this.estatus = estatus;
    }

    public Aerolinea getAerolinea() {
        return aerolinea;
    }

    public void setAerolinea(Aerolinea aerolinea) {
        this.aerolinea = aerolinea;
    }
}


