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
@Table(name = "rendezvous")

@NamedQueries({
    @NamedQuery(name = "Rendezvous.findAll", query = "SELECT r FROM Rendezvous r"),
    @NamedQuery(name = "Rendezvous.findByIdRendezvous", query = "SELECT r FROM Rendezvous r WHERE r.idRendezvous = :idRendezvous"),
    @NamedQuery(name = "Rendezvous.findByDateRendezvous", query = "SELECT r FROM Rendezvous r WHERE r.dateRendezvous = :dateRendezvous"),
    @NamedQuery(name = "Rendezvous.findByStatut", query = "SELECT r FROM Rendezvous r WHERE r.statut = :statut")})
public class Rendezvous implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
   
    @Basic(optional = false)
    @Column(name = "ID_RENDEZVOUS")
    private String idRendezvous;
    
    @Basic(optional = false)
    @Column(name = "DATE_RENDEZVOUS")
    @Temporal(TemporalType.DATE)
    private Date dateRendezvous;
    
    @Basic(optional = false)
    @Lob
    @Column(name = "OBJET")
    private String objet;
    
    @Basic(optional = false)
    @Column(name = "STATUT")
    private String statut;
    
    @JoinColumn(name = "ID_ANIMAL", referencedColumnName = "ID_ANIMAL")
    @ManyToOne(optional = false)
    private Animal animal;
    
    @JoinColumn(name = "ID_TYPERENDEZVOUS", referencedColumnName = "ID_TYPERENDEZVOUS")
    @ManyToOne(optional = false)
    private TypeRendezvous typerendezvous;
    
    @JoinColumn(name = "ID_VETERINAIRE", referencedColumnName = "ID_VETERINAIRE")
    @ManyToOne(optional = false)
    private Veterinaire veterinaire;

    public Rendezvous() {
    }

    public Rendezvous(String idRendezvous) {
        this.idRendezvous = idRendezvous;
    }

    public Rendezvous(String idRendezvous, Date dateRendezvous, String objet, String statut) {
        this.idRendezvous = idRendezvous;
        this.dateRendezvous = dateRendezvous;
        this.objet = objet;
        this.statut = statut;
    }

    public String getIdRendezvous() {
        return idRendezvous;
    }

    public void setIdRendezvous(String idRendezvous) {
        this.idRendezvous = idRendezvous;
    }

    public Date getDateRendezvous() {
        return dateRendezvous;
    }

    public void setDateRendezvous(Date dateRendezvous) {
        this.dateRendezvous = dateRendezvous;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
    
    public Animal getAnimal() {
		return animal;
	}

	public void setAnimal(Animal animal) {
		this.animal = animal;
	}

	public TypeRendezvous getTyperendezvous() {
		return typerendezvous;
	}

	public void setTyperendezvous(TypeRendezvous typerendezvous) {
		this.typerendezvous = typerendezvous;
	}

	public Veterinaire getVeterinaire() {
		return veterinaire;
	}

	public void setVeterinaire(Veterinaire veterinaire) {
		this.veterinaire = veterinaire;
	}

	@Override
    public int hashCode() {
        int hash = 0;
        hash += (idRendezvous != null ? idRendezvous.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Rendezvous)) {
            return false;
        }
        Rendezvous other = (Rendezvous) object;
        if ((this.idRendezvous == null && other.idRendezvous != null) || (this.idRendezvous != null && !this.idRendezvous.equals(other.idRendezvous))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Rendezvous[ idRendezvous=" + idRendezvous + " ]";
    }
    
}
