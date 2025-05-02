/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.example.gestionAnimaux.entites;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

/**
 *
 * @author IMPACT TECH
 */
@Entity
@Table(name = "maladie")

@NamedQueries({
    @NamedQuery(name = "Maladie.findAll", query = "SELECT m FROM Maladie m"),
    @NamedQuery(name = "Maladie.findByIdMaladie", query = "SELECT m FROM Maladie m WHERE m.idMaladie = :idMaladie"),
    @NamedQuery(name = "Maladie.findByNomMaladie", query = "SELECT m FROM Maladie m WHERE m.nomMaladie = :nomMaladie"),
    @NamedQuery(name = "Maladie.findByDateDiagnostic", query = "SELECT m FROM Maladie m WHERE m.dateDiagnostic = :dateDiagnostic")})
public class Maladie implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id

    @Basic(optional = false)
    @Column(name = "ID_MALADIE")
    private String idMaladie;
    
    @Basic(optional = false)
    @Column(name = "NOM_MALADIE")
    private String nomMaladie;
    
    @Basic(optional = false)
    @Column(name = "DATE_DIAGNOSTIC")
    @Temporal(TemporalType.DATE)
    private Date dateDiagnostic;
    
    @Lob
    @Column(name = "COMMENTAIRE")
    private String commentaire;
    
    @JoinColumn(name = "ID_DOSSIERMEDICAL", referencedColumnName = "ID_DOSSIERMEDICAL")
    @ManyToOne(optional = false)
    private Dossiermedical dossiermedical;

    public Maladie() {
    }

    public Maladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public Maladie(String idMaladie, String nomMaladie, Date dateDiagnostic) {
        this.idMaladie = idMaladie;
        this.nomMaladie = nomMaladie;
        this.dateDiagnostic = dateDiagnostic;
    }

    public String getIdMaladie() {
        return idMaladie;
    }

    public void setIdMaladie(String idMaladie) {
        this.idMaladie = idMaladie;
    }

    public String getNomMaladie() {
        return nomMaladie;
    }

    public void setNomMaladie(String nomMaladie) {
        this.nomMaladie = nomMaladie;
    }

    public Date getDateDiagnostic() {
        return dateDiagnostic;
    }

    public void setDateDiagnostic(Date dateDiagnostic) {
        this.dateDiagnostic = dateDiagnostic;
    }

    public String getCommentaire() {
        return commentaire;
    }

    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }

    

    public Dossiermedical getDossiermedical() {
		return dossiermedical;
	}

	public void setDossiermedical(Dossiermedical dossiermedical) {
		this.dossiermedical = dossiermedical;
	}

	@Override
    public int hashCode() {
        int hash = 0;
        hash += (idMaladie != null ? idMaladie.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Maladie)) {
            return false;
        }
        Maladie other = (Maladie) object;
        if ((this.idMaladie == null && other.idMaladie != null) || (this.idMaladie != null && !this.idMaladie.equals(other.idMaladie))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Maladie[ idMaladie=" + idMaladie + " ]";
    }
    
}
