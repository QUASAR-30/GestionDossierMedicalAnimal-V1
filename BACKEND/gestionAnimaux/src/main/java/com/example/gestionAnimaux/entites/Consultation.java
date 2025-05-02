/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.gestionAnimaux.entites;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.*;

/**
 *
 * @author IMPACT TECH
 */
@Entity
@Table(name = "consultation")

@NamedQueries({
    @NamedQuery(name = "Consultation.findAll", query = "SELECT c FROM Consultation c"),
    @NamedQuery(name = "Consultation.findByIdConsultation", query = "SELECT c FROM Consultation c WHERE c.idConsultation = :idConsultation"),
    @NamedQuery(name = "Consultation.findByDateConsultation", query = "SELECT c FROM Consultation c WHERE c.dateConsultation = :dateConsultation")})
public class Consultation implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
   
    @Basic(optional = false)
    @Column(name = "ID_CONSULTATION")
    private String idConsultation;
    @Basic(optional = false)
    @Lob
    @Column(name = "SYNTOME")
    private String syntome;
    @Basic(optional = false)
    @Lob
    @Column(name = "DIAGNOSTIC")
    private String diagnostic;
    
    @Basic(optional = false)
    @Column(name = "DATE_CONSULTATION")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date dateConsultation;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "consultation")
    private List<TraitementPrescription> traitementPrescription;
    
    @JoinColumn(name = "ID_DOSSIERMEDICAL", referencedColumnName = "ID_DOSSIERMEDICAL")
    @ManyToOne(optional = false)
    private Dossiermedical dossiermedical;

    public Consultation() {
    }

    public Consultation(String idConsultation) {
        this.idConsultation = idConsultation;
    }

    public Consultation(String idConsultation, String syntome, String diagnostic, Date dateConsultation) {
        this.idConsultation = idConsultation;
        this.syntome = syntome;
        this.diagnostic = diagnostic;
        this.dateConsultation = dateConsultation;
    }

    public String getIdConsultation() {
        return idConsultation;
    }

    public void setIdConsultation(String idConsultation) {
        this.idConsultation = idConsultation;
    }

    public String getSyntome() {
        return syntome;
    }

    public void setSyntome(String syntome) {
        this.syntome = syntome;
    }

    public String getDiagnostic() {
        return diagnostic;
    }

    public void setDiagnostic(String diagnostic) {
        this.diagnostic = diagnostic;
    }

    public Date getDateConsultation() {
        return dateConsultation;
    }

    public void setDateConsultation(Date dateConsultation) {
        this.dateConsultation = dateConsultation;
    }

   
    public List<TraitementPrescription> getTraitementPrescription() {
        return traitementPrescription;
    }

    public void setTraitementPrescriptionList(List<TraitementPrescription> traitementPrescription) {
        this.traitementPrescription = traitementPrescription;
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
        hash += (idConsultation != null ? idConsultation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Consultation)) {
            return false;
        }
        Consultation other = (Consultation) object;
        if ((this.idConsultation == null && other.idConsultation != null) || (this.idConsultation != null && !this.idConsultation.equals(other.idConsultation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "newpackage.Consultation[ idConsultation=" + idConsultation + " ]";
    }
    
}
