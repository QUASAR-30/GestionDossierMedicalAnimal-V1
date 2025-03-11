/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.iuc.gestionDossierMedicalAnimaux.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;

/**
 *
 * @author IMPACT TECH
 */
@Entity
@Table(name = "notification")

@NamedQueries({
    @NamedQuery(name = "Notification.findAll", query = "SELECT n FROM Notification n"),
    @NamedQuery(name = "Notification.findByIdNotification", query = "SELECT n FROM Notification n WHERE n.idNotification = :idNotification"),
    @NamedQuery(name = "Notification.findByTypeUtilisateur", query = "SELECT n FROM Notification n WHERE n.typeUtilisateur = :typeUtilisateur"),
    @NamedQuery(name = "Notification.findByDateNotification", query = "SELECT n FROM Notification n WHERE n.dateNotification = :dateNotification"),
    @NamedQuery(name = "Notification.findByLu", query = "SELECT n FROM Notification n WHERE n.lu = :lu")})
public class Notification implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_NOTIFICATION")
    private Integer idNotification;
    @Basic(optional = false)
    @Column(name = "TYPE_UTILISATEUR")
    private String typeUtilisateur;
    @Basic(optional = false)
    @Lob
    @Column(name = "MESSAGE")
    private String message;
    @Basic(optional = false)
    @Column(name = "DATE_NOTIFICATION")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateNotification;
    @Column(name = "LU")
    private Boolean lu;
    @JoinColumn(name = "ID_UTILISATEUR", referencedColumnName = "ID_PROPRIETAIRE")
    @ManyToOne(optional = false)
    private Proprietaire idUtilisateur;

    public Notification() {
    }

    public Notification(Integer idNotification) {
        this.idNotification = idNotification;
    }

    public Notification(Integer idNotification, String typeUtilisateur, String message, Date dateNotification) {
        this.idNotification = idNotification;
        this.typeUtilisateur = typeUtilisateur;
        this.message = message;
        this.dateNotification = dateNotification;
    }

    public Integer getIdNotification() {
        return idNotification;
    }

    public void setIdNotification(Integer idNotification) {
        this.idNotification = idNotification;
    }

    public String getTypeUtilisateur() {
        return typeUtilisateur;
    }

    public void setTypeUtilisateur(String typeUtilisateur) {
        this.typeUtilisateur = typeUtilisateur;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDateNotification() {
        return dateNotification;
    }

    public void setDateNotification(Date dateNotification) {
        this.dateNotification = dateNotification;
    }

    public Boolean getLu() {
        return lu;
    }

    public void setLu(Boolean lu) {
        this.lu = lu;
    }

    public Proprietaire getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(Proprietaire idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idNotification != null ? idNotification.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Notification)) {
            return false;
        }
        Notification other = (Notification) object;
        if ((this.idNotification == null && other.idNotification != null) || (this.idNotification != null && !this.idNotification.equals(other.idNotification))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Notification[ idNotification=" + idNotification + " ]";
    }
    
}
