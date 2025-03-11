/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.iuc.gestionDossierMedicalAnimaux.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;
/**
 *
 * @author IMPACT TECH
 */
@Entity
@Table(name = "vaccin")

@NamedQueries({
    @NamedQuery(name = "Vaccin.findAll", query = "SELECT v FROM Vaccin v"),
    @NamedQuery(name = "Vaccin.findByIdVaccin", query = "SELECT v FROM Vaccin v WHERE v.idVaccin = :idVaccin"),
    @NamedQuery(name = "Vaccin.findByTypeVaccin", query = "SELECT v FROM Vaccin v WHERE v.typeVaccin = :typeVaccin"),
    @NamedQuery(name = "Vaccin.findByDateVaccin", query = "SELECT v FROM Vaccin v WHERE v.dateVaccin = :dateVaccin"),
    @NamedQuery(name = "Vaccin.findByDateRappel", query = "SELECT v FROM Vaccin v WHERE v.dateRappel = :dateRappel"),
    @NamedQuery(name = "Vaccin.findByStatut", query = "SELECT v FROM Vaccin v WHERE v.statut = :statut")})
public class Vaccin implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_VACCIN")
    private Integer idVaccin;
    @Basic(optional = false)
    @Column(name = "TYPE_VACCIN")
    private String typeVaccin;
    @Basic(optional = false)
    @Column(name = "DATE_VACCIN")
    @Temporal(TemporalType.DATE)
    private Date dateVaccin;
    @Basic(optional = false)
    @Column(name = "DATE_RAPPEL")
    @Temporal(TemporalType.DATE)
    private Date dateRappel;
    @Basic(optional = false)
    @Column(name = "STATUT")
    private String statut;
    @JoinColumn(name = "ID_DOSSIERMEDICAL", referencedColumnName = "ID_DOSSIERMEDICAL")
    @ManyToOne(optional = false)
    private Dossiermedical idDossiermedical;

    public Vaccin() {
    }

    public Vaccin(Integer idVaccin) {
        this.idVaccin = idVaccin;
    }

    public Vaccin(Integer idVaccin, String typeVaccin, Date dateVaccin, Date dateRappel, String statut) {
        this.idVaccin = idVaccin;
        this.typeVaccin = typeVaccin;
        this.dateVaccin = dateVaccin;
        this.dateRappel = dateRappel;
        this.statut = statut;
    }

    public Integer getIdVaccin() {
        return idVaccin;
    }

    public void setIdVaccin(Integer idVaccin) {
        this.idVaccin = idVaccin;
    }

    public String getTypeVaccin() {
        return typeVaccin;
    }

    public void setTypeVaccin(String typeVaccin) {
        this.typeVaccin = typeVaccin;
    }

    public Date getDateVaccin() {
        return dateVaccin;
    }

    public void setDateVaccin(Date dateVaccin) {
        this.dateVaccin = dateVaccin;
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

    public Dossiermedical getIdDossiermedical() {
        return idDossiermedical;
    }

    public void setIdDossiermedical(Dossiermedical idDossiermedical) {
        this.idDossiermedical = idDossiermedical;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idVaccin != null ? idVaccin.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Vaccin)) {
            return false;
        }
        Vaccin other = (Vaccin) object;
        if ((this.idVaccin == null && other.idVaccin != null) || (this.idVaccin != null && !this.idVaccin.equals(other.idVaccin))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Vaccin[ idVaccin=" + idVaccin + " ]";
    }
    
}
