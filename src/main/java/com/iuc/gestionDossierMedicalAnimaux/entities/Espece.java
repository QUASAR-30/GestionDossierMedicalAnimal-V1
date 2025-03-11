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
@Table(name = "espece")

@NamedQueries({
    @NamedQuery(name = "Espece.findAll", query = "SELECT e FROM Espece e"),
    @NamedQuery(name = "Espece.findByIdEspece", query = "SELECT e FROM Espece e WHERE e.idEspece = :idEspece"),
    @NamedQuery(name = "Espece.findByType", query = "SELECT e FROM Espece e WHERE e.type = :type")})
public class Espece implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_ESPECE")
    private Integer idEspece;
    @Basic(optional = false)
    @Column(name = "TYPE")
    private String type;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idEspece")
    private List<Animal> animalList;

    public Espece() {
    }

    public Espece(Integer idEspece) {
        this.idEspece = idEspece;
    }

    public Espece(Integer idEspece, String type) {
        this.idEspece = idEspece;
        this.type = type;
    }

    public Integer getIdEspece() {
        return idEspece;
    }

    public void setIdEspece(Integer idEspece) {
        this.idEspece = idEspece;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Animal> getAnimalList() {
        return animalList;
    }

    public void setAnimalList(List<Animal> animalList) {
        this.animalList = animalList;
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
        return "newpackage.Espece[ idEspece=" + idEspece + " ]";
    }
    
}
