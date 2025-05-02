/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gestionAnimaux.entites;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
/**
 *
 * @author IMPACT TECH
 */
@Entity
@Table(name = "type_rendezvous")

@NamedQueries({
    @NamedQuery(name = "TypeRendezvous.findAll", query = "SELECT t FROM TypeRendezvous t"),
    @NamedQuery(name = "TypeRendezvous.findByIdTyperendezvous", query = "SELECT t FROM TypeRendezvous t WHERE t.idTyperendezvous = :idTyperendezvous"),
    @NamedQuery(name = "TypeRendezvous.findByNom", query = "SELECT t FROM TypeRendezvous t WHERE t.nom = :nom")})
public class TypeRendezvous implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "ID_TYPERENDEZVOUS")
    private String idTyperendezvous;
    @Basic(optional = false)
    @Column(name = "NOM")
    private String nom;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "typerendezvous")
    private List<Rendezvous> rendezvous;

    public TypeRendezvous() {
    }

    public TypeRendezvous(String idTyperendezvous) {
        this.idTyperendezvous = idTyperendezvous;
    }

    public TypeRendezvous(String idTyperendezvous, String nom) {
        this.idTyperendezvous = idTyperendezvous;
        this.nom = nom;
    }

    public String getIdTyperendezvous() {
        return idTyperendezvous;
    }

    public void setIdTyperendezvous(String idTyperendezvous) {
        this.idTyperendezvous = idTyperendezvous;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }


   

    public List<Rendezvous> getRendezvous() {
		return rendezvous;
	}

	public void setRendezvous(List<Rendezvous> rendezvous) {
		this.rendezvous = rendezvous;
	}

	@Override
    public int hashCode() {
        int hash = 0;
        hash += (idTyperendezvous != null ? idTyperendezvous.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TypeRendezvous)) {
            return false;
        }
        TypeRendezvous other = (TypeRendezvous) object;
        if ((this.idTyperendezvous == null && other.idTyperendezvous != null) || (this.idTyperendezvous != null && !this.idTyperendezvous.equals(other.idTyperendezvous))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.TypeRendezvous[ idTyperendezvous=" + idTyperendezvous + " ]";
    }
    
}
