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
@Table(name = "espece")

@NamedQueries({
    @NamedQuery(name = "Espece.findAll", query = "SELECT e FROM Espece e"),
    @NamedQuery(name = "Espece.findByIdEspece", query = "SELECT e FROM Espece e WHERE e.idEspece = :idEspece"),
    @NamedQuery(name = "Espece.findByType", query = "SELECT e FROM Espece e WHERE e.type = :type")})
public class Espece implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id

    @Basic(optional = false)
    @Column(name = "ID_ESPECE")
    private String idEspece;
    @Basic(optional = false)
    @Column(name = "TYPE")
    private String type;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "espece")
    private List<Animal> animal;

    public Espece() {
    }

    public Espece(String idEspece) {
        this.idEspece = idEspece;
    }

    public Espece(String idEspece, String type) {
        this.idEspece = idEspece;
        this.type = type;
    }

    public String getIdEspece() {
        return idEspece;
    }

    public void setIdEspece(String idEspece) {
        this.idEspece = idEspece;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Animal> getAnimal() {
        return animal;
    }

    public void setAnimalList(List<Animal> animal) {
        this.animal = animal;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idEspece != null ? idEspece.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Espece)) {
            return false;
        }
        Espece other = (Espece) object;
        if ((this.idEspece == null && other.idEspece != null) || (this.idEspece != null && !this.idEspece.equals(other.idEspece))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
    	return "com.iuc.gestionDossierMedicalAnimaux.entities.Espece[ idEspece=" + idEspece + " ]";
    }
    
}
