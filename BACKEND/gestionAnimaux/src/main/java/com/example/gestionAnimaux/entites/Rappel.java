/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gestionAnimaux.entites;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;

/**
 *
 * @author IMPACT TECH
 */
@Entity
@Table(name = "rappel")

@NamedQueries({
    @NamedQuery(name = "Rappel.findAll", query = "SELECT r FROM Rappel r"),
    @NamedQuery(name = "Rappel.findByIdRappel", query = "SELECT r FROM Rappel r WHERE r.idRappel = :idRappel"),
    @NamedQuery(name = "Rappel.findByTypeRappel", query = "SELECT r FROM Rappel r WHERE r.typeRappel = :typeRappel"),
    @NamedQuery(name = "Rappel.findByDateRappel", query = "SELECT r FROM Rappel r WHERE r.dateRappel = :dateRappel"),
    @NamedQuery(name = "Rappel.findByStatut", query = "SELECT r FROM Rappel r WHERE r.statut = :statut")})
public class Rappel implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
  
    @Basic(optional = false)
    @Column(name = "ID_RAPPEL")
    private String idRappel;
    @Basic(optional = false)
    @Column(name = "TYPE_RAPPEL")
    private String typeRappel;
    @Basic(optional = false)
    @Column(name = "DATE_RAPPEL")
    @Temporal(TemporalType.DATE)
    private Date dateRappel;
    @Column(name = "STATUT")
    private String statut;
    @JoinColumn(name = "ID_ANIMAL", referencedColumnName = "ID_ANIMAL")
    @ManyToOne(optional = false)
    private Animal idAnimal;

    public Rappel() {
    }

    public Rappel(String idRappel) {
        this.idRappel = idRappel;
    }

    public Rappel(String idRappel, String typeRappel, Date dateRappel) {
        this.idRappel = idRappel;
        this.typeRappel = typeRappel;
        this.dateRappel = dateRappel;
    }

    public String getIdRappel() {
        return idRappel;
    }

    public void setIdRappel(String idRappel) {
        this.idRappel = idRappel;
    }

    public String getTypeRappel() {
        return typeRappel;
    }

    public void setTypeRappel(String typeRappel) {
        this.typeRappel = typeRappel;
    }

    public Date getDateRappel() {
        return dateRappel;
    }

    public void setDateRappel(Date dateRappel) {
        this.dateRappel = dateRappel;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Animal getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(Animal idAnimal) {
        this.idAnimal = idAnimal;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRappel != null ? idRappel.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Rappel)) {
            return false;
        }
        Rappel other = (Rappel) object;
        if ((this.idRappel == null && other.idRappel != null) || (this.idRappel != null && !this.idRappel.equals(other.idRappel))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Rappel[ idRappel=" + idRappel + " ]";
    }
    
}
