/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.iuc.gestionDossierMedicalAnimaux.entities;

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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_TYPERENDEZVOUS")
    private Integer idTyperendezvous;
    @Basic(optional = false)
    @Column(name = "NOM")
    private String nom;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTyperendezvous")
    private List<Rendezvous> rendezvousList;

    public TypeRendezvous() {
    }

    public TypeRendezvous(Integer idTyperendezvous) {
        this.idTyperendezvous = idTyperendezvous;
    }

    public TypeRendezvous(Integer idTyperendezvous, String nom) {
        this.idTyperendezvous = idTyperendezvous;
        this.nom = nom;
    }

    public Integer getIdTyperendezvous() {
        return idTyperendezvous;
    }

    public void setIdTyperendezvous(Integer idTyperendezvous) {
        this.idTyperendezvous = idTyperendezvous;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }


    public List<Rendezvous> getRendezvousList() {
        return rendezvousList;
    }

    public void setRendezvousList(List<Rendezvous> rendezvousList) {
        this.rendezvousList = rendezvousList;
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
