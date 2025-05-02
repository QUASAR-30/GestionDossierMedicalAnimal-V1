/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gestionAnimaux.entites;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

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
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date datecreation;
    
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dossiermedical")
    private List<Vaccin> vaccin;
    
    @JoinColumn(name = "ID_ANIMAL", referencedColumnName = "ID_ANIMAL")
    @ManyToOne(optional = false)
    private Animal animal;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dossiermedical")
    private List<Consultation> consultation;
    
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "dossiermedical")
    private List<Maladie> maladie;

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

   
   

    public List<Vaccin> getVaccin() {
		return vaccin;
	}

	public void setVaccin(List<Vaccin> vaccin) {
		this.vaccin = vaccin;
	}

	public Animal getAnimal() {
		return animal;
	}

	public void setAnimal(Animal animal) {
		this.animal = animal;
	}

	

    public List<Consultation> getConsultation() {
		return consultation;
	}

	public void setConsultation(List<Consultation> consultation) {
		this.consultation = consultation;
	}

	public List<Maladie> getMaladie() {
		return maladie;
	}

	public void setMaladie(List<Maladie> maladie) {
		this.maladie = maladie;
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
