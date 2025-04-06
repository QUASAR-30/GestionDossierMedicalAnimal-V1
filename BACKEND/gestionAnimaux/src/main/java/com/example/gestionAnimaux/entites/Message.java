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
@Table(name = "message")

@NamedQueries({
    @NamedQuery(name = "Message.findAll", query = "SELECT m FROM Message m"),
    @NamedQuery(name = "Message.findByIdMessage", query = "SELECT m FROM Message m WHERE m.idMessage = :idMessage"),
    @NamedQuery(name = "Message.findByDateEnvoi", query = "SELECT m FROM Message m WHERE m.dateEnvoi = :dateEnvoi"),
    @NamedQuery(name = "Message.findByLu", query = "SELECT m FROM Message m WHERE m.lu = :lu"),
    @NamedQuery(name = "Message.findByTypeExpediteur", query = "SELECT m FROM Message m WHERE m.typeExpediteur = :typeExpediteur")})
public class Message implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
  
    @Basic(optional = false)
    @Column(name = "ID_MESSAGE")
    private String idMessage;
    @Basic(optional = false)
    @Lob
    @Column(name = "CONTENU")
    private String contenu;
    @Basic(optional = false)
    @Column(name = "DATE_ENVOI")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateEnvoi;
    @Column(name = "LU")
    private Boolean lu;
    @Basic(optional = false)
    @Column(name = "TYPE_EXPEDITEUR")
    private String typeExpediteur;
    @JoinColumn(name = "ID_DESTINATAIRE", referencedColumnName = "ID_VETERINAIRE")
    @ManyToOne(optional = false)
    private Veterinaire idDestinataire;
    @JoinColumn(name = "ID_EXPEDITEUR", referencedColumnName = "ID_PROPRIETAIRE")
    @ManyToOne(optional = false)
    private Proprietaire idExpediteur;

    public Message() {
    }

    public Message(String idMessage) {
        this.idMessage = idMessage;
    }

    public Message(String idMessage, String contenu, Date dateEnvoi, String typeExpediteur) {
        this.idMessage = idMessage;
        this.contenu = contenu;
        this.dateEnvoi = dateEnvoi;
        this.typeExpediteur = typeExpediteur;
    }

    public String getIdMessage() {
        return idMessage;
    }

    public void setIdMessage(String idMessage) {
        this.idMessage = idMessage;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public Date getDateEnvoi() {
        return dateEnvoi;
    }

    public void setDateEnvoi(Date dateEnvoi) {
        this.dateEnvoi = dateEnvoi;
    }

    public Boolean getLu() {
        return lu;
    }

    public void setLu(Boolean lu) {
        this.lu = lu;
    }

    public String getTypeExpediteur() {
        return typeExpediteur;
    }

    public void setTypeExpediteur(String typeExpediteur) {
        this.typeExpediteur = typeExpediteur;
    }

    public Veterinaire getIdDestinataire() {
        return idDestinataire;
    }

    public void setIdDestinataire(Veterinaire idDestinataire) {
        this.idDestinataire = idDestinataire;
    }

    public Proprietaire getIdExpediteur() {
        return idExpediteur;
    }

    public void setIdExpediteur(Proprietaire idExpediteur) {
        this.idExpediteur = idExpediteur;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMessage != null ? idMessage.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Message)) {
            return false;
        }
        Message other = (Message) object;
        if ((this.idMessage == null && other.idMessage != null) || (this.idMessage != null && !this.idMessage.equals(other.idMessage))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Message[ idMessage=" + idMessage + " ]";
    }
    
}
