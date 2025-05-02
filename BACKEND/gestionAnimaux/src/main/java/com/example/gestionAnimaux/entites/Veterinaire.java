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
@Table(name = "veterinaire")

@NamedQueries({
    @NamedQuery(name = "Veterinaire.findAll", query = "SELECT v FROM Veterinaire v"),
    @NamedQuery(name = "Veterinaire.findByIdVeterinaire", query = "SELECT v FROM Veterinaire v WHERE v.idVeterinaire = :idVeterinaire"),
    @NamedQuery(name = "Veterinaire.findByNomVeterinaire", query = "SELECT v FROM Veterinaire v WHERE v.nomVeterinaire = :nomVeterinaire"),
    @NamedQuery(name = "Veterinaire.findByEmailVeterinaire", query = "SELECT v FROM Veterinaire v WHERE v.emailVeterinaire = :emailVeterinaire"),
    @NamedQuery(name = "Veterinaire.findByNumeroVeterinaire", query = "SELECT v FROM Veterinaire v WHERE v.numeroVeterinaire = :numeroVeterinaire"),
    @NamedQuery(name = "Veterinaire.findByMdpVeterinaire", query = "SELECT v FROM Veterinaire v WHERE v.mdpVeterinaire = :mdpVeterinaire")})
public class Veterinaire implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
 
    @Basic(optional = false)
    @Column(name = "ID_VETERINAIRE")
    private String idVeterinaire;
    @Basic(optional = false)
    @Column(name = "NOM_VETERINAIRE")
    private String nomVeterinaire;
    @Basic(optional = false)
    @Column(name = "EMAIL_VETERINAIRE")
    private String emailVeterinaire;
    @Basic(optional = false)
    @Column(name = "NUMERO_VETERINAIRE")
    private String numeroVeterinaire;
    @Basic(optional = false)
    @Column(name = "MDP_VETERINAIRE")
    private String mdpVeterinaire;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "veterinaire")
    private List<Notification> notification;

    public Veterinaire() {
    }

    public Veterinaire(String idVeterinaire) {
        this.idVeterinaire = idVeterinaire;
    }

    public Veterinaire(String idVeterinaire, String nomVeterinaire, String emailVeterinaire, String numeroVeterinaire, String mdpVeterinaire) {
        this.idVeterinaire = idVeterinaire;
        this.nomVeterinaire = nomVeterinaire;
        this.emailVeterinaire = emailVeterinaire;
        this.numeroVeterinaire = numeroVeterinaire;
        this.mdpVeterinaire = mdpVeterinaire;
    }

    public String getIdVeterinaire() {
        return idVeterinaire;
    }

    public void setIdVeterinaire(String idVeterinaire) {
        this.idVeterinaire = idVeterinaire;
    }

    public String getNomVeterinaire() {
        return nomVeterinaire;
    }

    public void setNomVeterinaire(String nomVeterinaire) {
        this.nomVeterinaire = nomVeterinaire;
    }

    public String getEmailVeterinaire() {
        return emailVeterinaire;
    }

    public void setEmailVeterinaire(String emailVeterinaire) {
        this.emailVeterinaire = emailVeterinaire;
    }

    public String getNumeroVeterinaire() {
        return numeroVeterinaire;
    }

    public void setNumeroVeterinaire(String numeroVeterinaire) {
        this.numeroVeterinaire = numeroVeterinaire;
    }

    public String getMdpVeterinaire() {
        return mdpVeterinaire;
    }

    public void setMdpVeterinaire(String mdpVeterinaire) {
        this.mdpVeterinaire = mdpVeterinaire;
    }

   
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idVeterinaire != null ? idVeterinaire.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Veterinaire)) {
            return false;
        }
        Veterinaire other = (Veterinaire) object;
        if ((this.idVeterinaire == null && other.idVeterinaire != null) || (this.idVeterinaire != null && !this.idVeterinaire.equals(other.idVeterinaire))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Veterinaire[ idVeterinaire=" + idVeterinaire + " ]";
    }

	public List<Notification> getNotification() {
		return notification;
	}

	public void setNotification(List<Notification> notification) {
		this.notification = notification;
	}
    
    
}
