package com.example.gestionAnimaux.entites;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Entity
public class Notification {
	  @Id
	    private String id;

	    private String type; 
	    private String contenu;
	    private boolean lu;
	    private LocalDateTime timestamp;

	    @ManyToOne
	    @JoinColumn(name = "idVeterinaire")
	    private Veterinaire veterinaire;

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public String getContenu() {
			return contenu;
		}

		public void setContenu(String contenu) {
			this.contenu = contenu;
		}

		public boolean isLu() {
			return lu;
		}

		public void setLu(boolean lu) {
			this.lu = lu;
		}

		public LocalDateTime getTimestamp() {
			return timestamp;
		}

		public void setTimestamp(LocalDateTime timestamp) {
			this.timestamp = timestamp;
		}

		public Veterinaire getVeterinaire() {
			return veterinaire;
		}

		public void setVeterinaire(Veterinaire veterinaire) {
			this.veterinaire = veterinaire;
		}

		public Notification(String type, String contenu, boolean lu, LocalDateTime timestamp, Veterinaire veterinaire) {
			super();
			this.type = type;
			this.contenu = contenu;
			this.lu = lu;
			this.timestamp = timestamp;
			this.veterinaire = veterinaire;
		}

		public Notification() {
			super();
		}
	    
	    
	    
}
