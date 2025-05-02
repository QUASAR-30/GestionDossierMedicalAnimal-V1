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
@Table(name = "proprietaire")

@NamedQueries({
    @NamedQuery(name = "Proprietaire.findAll", query = "SELECT p FROM Proprietaire p"),
    @NamedQuery(name = "Proprietaire.findByIdProprietaire", query = "SELECT p FROM Proprietaire p WHERE p.idProprietaire = :idProprietaire"),
    @NamedQuery(name = "Proprietaire.findByNomProprietaire", query = "SELECT p FROM Proprietaire p WHERE p.nomProprietaire = :nomProprietaire"),
    @NamedQuery(name = "Proprietaire.findByPrenomProprietaire", query = "SELECT p FROM Proprietaire p WHERE p.prenomProprietaire = :prenomProprietaire"),
    @NamedQuery(name = "Proprietaire.findByAdresseProprietaire", query = "SELECT p FROM Proprietaire p WHERE p.adresseProprietaire = :adresseProprietaire"),
    @NamedQuery(name = "Proprietaire.findByEmailProprietaire", query = "SELECT p FROM Proprietaire p WHERE p.emailProprietaire = :emailProprietaire"),
    @NamedQuery(name = "Proprietaire.findByNumeroProprietaire", query = "SELECT p FROM Proprietaire p WHERE p.numeroProprietaire = :numeroProprietaire"),
    @NamedQuery(name = "Proprietaire.findByMdpProprietaire", query = "SELECT p FROM Proprietaire p WHERE p.mdpProprietaire = :mdpProprietaire")})
public class Proprietaire implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
 
    @Basic(optional = false)
    @Column(name = "ID_PROPRIETAIRE")
    private String idProprietaire;
    @Basic(optional = false)
    @Column(name = "NOM_PROPRIETAIRE")
    private String nomProprietaire;
    @Basic(optional = false)
    @Column(name = "PRENOM_PROPRIETAIRE")
    private String prenomProprietaire;
    @Basic(optional = false)
    @Column(name = "ADRESSE_PROPRIETAIRE",nullable = false)
    private String adresseProprietaire;
    @Basic(optional = false)
    @Column(name = "EMAIL_PROPRIETAIRE")
    private String emailProprietaire;
    @Basic(optional = false)
    @Column(name = "NUMERO_PROPRIETAIRE")
    private String numeroProprietaire;
    @Basic(optional = false)
    @Column(name = "MDP_PROPRIETAIRE")
    private String mdpProprietaire;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "proprietaire")
    private List<Message> message;
   

    public Proprietaire() {
    }

    public Proprietaire(String idProprietaire) {
        this.idProprietaire = idProprietaire;
    }

    public Proprietaire(String idProprietaire, String nomProprietaire, String prenomProprietaire, String adresseProprietaire, String emailProprietaire, String numeroProprietaire, String mdpProprietaire) {
        this.idProprietaire = idProprietaire;
        this.nomProprietaire = nomProprietaire;
        this.prenomProprietaire = prenomProprietaire;
        this.adresseProprietaire = adresseProprietaire;
        this.emailProprietaire = emailProprietaire;
        this.numeroProprietaire = numeroProprietaire;
        this.mdpProprietaire = mdpProprietaire;
    }
    
    
    public Proprietaire(String emailProprietaire, String mdpProprietaire) {
		super();
		this.emailProprietaire = emailProprietaire;
		this.mdpProprietaire = mdpProprietaire;
	}

	public String getIdProprietaire() {
        return idProprietaire;
    }

    public void setIdProprietaire(String idProprietaire) {
        this.idProprietaire = idProprietaire;
    }

    public String getNomProprietaire() {
        return nomProprietaire;
    }

    public void setNomProprietaire(String nomProprietaire) {
        this.nomProprietaire = nomProprietaire;
    }

    public String getPrenomProprietaire() {
        return prenomProprietaire;
    }
    
    
    public void setPrenomProprietaire(String prenomProprietaire) {
        this.prenomProprietaire = prenomProprietaire;
    }

    public String getAdresseProprietaire() {
        return adresseProprietaire;
    }

    public void setAdresseProprietaire(String adresseProprietaire) {
        this.adresseProprietaire = adresseProprietaire;
    }

    public String getEmailProprietaire() {
        return emailProprietaire;
    }

    public void setEmailProprietaire(String emailProprietaire) {
        this.emailProprietaire = emailProprietaire;
    }

    public String getNumeroProprietaire() {
        return numeroProprietaire;
    }

    public void setNumeroProprietaire(String numeroProprietaire) {
        this.numeroProprietaire = numeroProprietaire;
    }

    public String getMdpProprietaire() {
        return mdpProprietaire;
    }

    public void setMdpProprietaire(String mdpProprietaire) {
    	//BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        //this.mdpProprietaire = encoder.encode(mdpProprietaire);
    	this.mdpProprietaire = mdpProprietaire;
    }
    

    public List<Message> getMessageList() {
        return message;
    }

    public void setMessageList(List<Message> message) {
        this.message = message;
    }

 
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idProprietaire != null ? idProprietaire.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Proprietaire)) {
            return false;
        }
        Proprietaire other = (Proprietaire) object;
        if ((this.idProprietaire == null && other.idProprietaire != null) || (this.idProprietaire != null && !this.idProprietaire.equals(other.idProprietaire))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Proprietaire[ idProprietaire=" + idProprietaire + " ]";
    }
    
}
