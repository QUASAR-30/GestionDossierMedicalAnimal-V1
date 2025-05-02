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
@Table(name = "traitement_prescription")

@NamedQueries({
    @NamedQuery(name = "TraitementPrescription.findAll", query = "SELECT t FROM TraitementPrescription t"),
    @NamedQuery(name = "TraitementPrescription.findByIdTraitement", query = "SELECT t FROM TraitementPrescription t WHERE t.idTraitement = :idTraitement"),
    @NamedQuery(name = "TraitementPrescription.findByDateDebut", query = "SELECT t FROM TraitementPrescription t WHERE t.dateDebut = :dateDebut"),
    @NamedQuery(name = "TraitementPrescription.findByDateFin", query = "SELECT t FROM TraitementPrescription t WHERE t.dateFin = :dateFin"),
    @NamedQuery(name = "TraitementPrescription.findByFrequence", query = "SELECT t FROM TraitementPrescription t WHERE t.frequence = :frequence")})
public class TraitementPrescription implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "ID_TRAITEMENT")
    private String idTraitement;
    @Basic(optional = false)
    @Lob
    @Column(name = "CONTENU_TRAITEMENT")
    private String contenuTraitement;
    @Basic(optional = false)
    @Column(name = "DATE_DEBUT")
    @Temporal(TemporalType.DATE)
    private Date dateDebut;
    @Basic(optional = false)
    @Column(name = "DATE_FIN")
    @Temporal(TemporalType.DATE)
    private Date dateFin;
    @Basic(optional = false)
    @Column(name = "FREQUENCE")
    private String frequence;
    @JoinColumn(name = "ID_CONSULTATION", referencedColumnName = "ID_CONSULTATION")
    @ManyToOne(optional = false)
    private Consultation consultation;

    public TraitementPrescription() {
    }

    public TraitementPrescription(String idTraitement) {
        this.idTraitement = idTraitement;
    }

    public TraitementPrescription(String idTraitement, String contenuTraitement, Date dateDebut, Date dateFin, String frequence) {
        this.idTraitement = idTraitement;
        this.contenuTraitement = contenuTraitement;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.frequence = frequence;
    }

    public String getIdTraitement() {
        return idTraitement;
    }

    public void setIdTraitement(String idTraitement) {
        this.idTraitement = idTraitement;
    }

    public String getContenuTraitement() {
        return contenuTraitement;
    }

    public void setContenuTraitement(String contenuTraitement) {
        this.contenuTraitement = contenuTraitement;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public String getFrequence() {
        return frequence;
    }

    public void setFrequence(String frequence) {
        this.frequence = frequence;
    }

   

    public Consultation getConsultation() {
		return consultation;
	}

	public void setConsultation(Consultation consultation) {
		this.consultation = consultation;
	}

	@Override
    public int hashCode() {
        int hash = 0;
        hash += (idTraitement != null ? idTraitement.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TraitementPrescription)) {
            return false;
        }
        TraitementPrescription other = (TraitementPrescription) object;
        if ((this.idTraitement == null && other.idTraitement != null) || (this.idTraitement != null && !this.idTraitement.equals(other.idTraitement))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.TraitementPrescription[ idTraitement=" + idTraitement + " ]";
    }
    
}
