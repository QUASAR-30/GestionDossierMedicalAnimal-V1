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
@Table(name = "dossiermedical")

@NamedQueries({
    @NamedQuery(name = "Dossiermedical.findAll", query = "SELECT d FROM Dossiermedical d"),
    @NamedQuery(name = "Dossiermedical.findByIdDossiermedical", query = "SELECT d FROM Dossiermedical d WHERE d.idDossiermedical = :idDossiermedical"),
    @NamedQuery(name = "Dossiermedical.findByDatecreation", query = "SELECT d FROM Dossiermedical d WHERE d.datecreation = :datecreation")})
public class Dossiermedical implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
   
    @Basic(optional = false)
    @Column(name = "ID_DOSSIERMEDICAL")
    private String idDossiermedical;
    @Basic(optional = false)
    @Column(name = "DATECREATION")
    @Temporal(TemporalType.DATE)
    private Date datecreation;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDossiermedical")
    private List<Vaccin> vaccinList;
    @JoinColumn(name = "ID_ANIMAL", referencedColumnName = "ID_ANIMAL")
    @OneToOne(optional = false)
    private Animal idAnimal;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDossiermedical")
    private List<Consultation> consultationList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDossiermedical")
    private List<Maladie> maladieList;

    public Dossiermedical() {
    }

    public Dossiermedical(String idDossiermedical) {
        this.idDossiermedical = idDossiermedical;
    }

    public Dossiermedical(String idDossiermedical, Date datecreation) {
        this.idDossiermedical = idDossiermedical;
        this.datecreation = datecreation;
    }

    public String getIdDossiermedical() {
        return idDossiermedical;
    }

    public void setIdDossiermedical(String idDossiermedical) {
        this.idDossiermedical = idDossiermedical;
    }

    public Date getDatecreation() {
        return datecreation;
    }

    public void setDatecreation(Date datecreation) {
        this.datecreation = datecreation;
    }

    public List<Vaccin> getVaccinList() {
        return vaccinList;
    }

    public void setVaccinList(List<Vaccin> vaccinList) {
        this.vaccinList = vaccinList;
    }

    public Animal getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(Animal idAnimal) {
        this.idAnimal = idAnimal;
    }

    public List<Consultation> getConsultationList() {
        return consultationList;
    }

    public void setConsultationList(List<Consultation> consultationList) {
        this.consultationList = consultationList;
    }

  
    public List<Maladie> getMaladieList() {
        return maladieList;
    }

    public void setMaladieList(List<Maladie> maladieList) {
        this.maladieList = maladieList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idDossiermedical != null ? idDossiermedical.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Dossiermedical)) {
            return false;
        }
        Dossiermedical other = (Dossiermedical) object;
        if ((this.idDossiermedical == null && other.idDossiermedical != null) || (this.idDossiermedical != null && !this.idDossiermedical.equals(other.idDossiermedical))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Dossiermedical[ idDossiermedical=" + idDossiermedical + " ]";
    }
    
}
