/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gestionAnimaux.entites;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;


/**
 *
 * @author IMPACT TECH
 */
@Entity
@Table(name = "animal")

@NamedQueries({
    @NamedQuery(name = "Animal.findAll", query = "SELECT a FROM Animal a"),
    @NamedQuery(name = "Animal.findByIdAnimal", query = "SELECT a FROM Animal a WHERE a.idAnimal = :idAnimal"),
    @NamedQuery(name = "Animal.findByNomAnimal", query = "SELECT a FROM Animal a WHERE a.nomAnimal = :nomAnimal"),
    @NamedQuery(name = "Animal.findByAgeAnimal", query = "SELECT a FROM Animal a WHERE a.ageAnimal = :ageAnimal"),
    @NamedQuery(name = "Animal.findBySexeAnimal", query = "SELECT a FROM Animal a WHERE a.sexeAnimal = :sexeAnimal"),
    @NamedQuery(name = "Animal.findByCouleurAnimal", query = "SELECT a FROM Animal a WHERE a.couleurAnimal = :couleurAnimal")})
public class Animal implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
   
    @Basic(optional = false)
    @Column(name = "ID_ANIMAL")
    private String idAnimal;
    @Basic(optional = false)
    @Column(name = "NOM_ANIMAL")
    private String nomAnimal;
    @Basic(optional = false)
    @Column(name = "AGE_ANIMAL")
    private String ageAnimal;
    @Basic(optional = false)
    @Column(name = "SEXE_ANIMAL")
    private String sexeAnimal;
    @Basic(optional = false)
    @Column(name = "COULEUR_ANIMAL")
    private String couleurAnimal;
    
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idAnimal")
    private List<Rappel> rappelList;
    
    
    @JoinColumn(name = "ID_ESPECE", referencedColumnName = "ID_ESPECE")
    @ManyToOne(optional = false)
    private Espece espece;
    
    
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "animal")
    private Dossiermedical dossiermedical;

    
    @JoinColumn(name = "ID_PROPRIETAIRE", referencedColumnName = "ID_PROPRIETAIRE")
    @ManyToOne(optional = false)
    private Proprietaire proprietaire;
    
    @ManyToOne
    @JoinColumn(name = "ID_VETERINAIRE", referencedColumnName = "ID_VETERINAIRE")
    private Veterinaire veterinaire;

    
    
    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "animal")
    private List<Rendezvous> rendezvous;

    public Animal() {
    }

    public Animal(String idAnimal) {
        this.idAnimal = idAnimal;
    }

    public Animal(String idAnimal, String nomAnimal, String ageAnimal, String sexeAnimal, String couleurAnimal) {
        this.idAnimal = idAnimal;
        this.nomAnimal = nomAnimal;
        this.ageAnimal = ageAnimal;
        this.sexeAnimal = sexeAnimal;
        this.couleurAnimal = couleurAnimal;
    }

    public String getIdAnimal() {
        return idAnimal;
    }

    public void setIdAnimal(String idAnimal) {
        this.idAnimal = idAnimal;
    }

    public String getNomAnimal() {
        return nomAnimal;
    }

    public void setNomAnimal(String nomAnimal) {
        this.nomAnimal = nomAnimal;
    }

    public String getAgeAnimal() {
        return ageAnimal;
    }

    public void setAgeAnimal(String string) {
        this.ageAnimal = string;
    }

    public String getSexeAnimal() {
        return sexeAnimal;
    }

    public void setSexeAnimal(String sexeAnimal) {
        this.sexeAnimal = sexeAnimal;
    }

    public String getCouleurAnimal() {
        return couleurAnimal;
    }

    public void setCouleurAnimal(String couleurAnimal) {
        this.couleurAnimal = couleurAnimal;
    }

  
    public List<Rappel> getRappelList() {
        return rappelList;
    }

    public void setRappelList(List<Rappel> rappelList) {
        this.rappelList = rappelList;
    }

    public Dossiermedical getDossiermedical() {
        return dossiermedical;
    }

    public void setDossiermedical(Dossiermedical dossiermedical) {
        this.dossiermedical = dossiermedical;
    }
  
    public Espece getEspece() {
		return espece;
	}

	public void setEspece(Espece espece) {
		this.espece = espece;
	}

	public Proprietaire getProprietaire() {
		return proprietaire;
	}

	public void setProprietaire(Proprietaire proprietaire) {
		this.proprietaire = proprietaire;
	}

	public List<Rendezvous> getRendezvous() {
        return rendezvous;
    }

    public void setRendezvousList(List<Rendezvous> rendezvous) {
        this.rendezvous = rendezvous;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idAnimal != null ? idAnimal.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Animal)) {
            return false;
        }
        Animal other = (Animal) object;
        if ((this.idAnimal == null && other.idAnimal != null) || (this.idAnimal != null && !this.idAnimal.equals(other.idAnimal))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Animal[ idAnimal=" + idAnimal + " ]";
    }

	public Veterinaire getVeterinaire() {
		return veterinaire;
	}

	public void setVeterinaire(Veterinaire veterinaire) {
		this.veterinaire = veterinaire;
	}

	public void setRendezvous(List<Rendezvous> rendezvous) {
		this.rendezvous = rendezvous;
	}
    
    
}
