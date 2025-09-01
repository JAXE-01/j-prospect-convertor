-- Table des entreprises (clients)
CREATE TABLE entreprises (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    api_key VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des abonnements des entreprises
CREATE TABLE abonnements (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_entreprise INT NOT NULL,
    plan VARCHAR(50) NOT NULL, -- 'Standard', 'Premium', etc.
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    FOREIGN KEY (id_entreprise) REFERENCES entreprises(id)
);

-- Table des transactions de paiement
CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_abonnement INT NOT NULL,
    montant DECIMAL(10, 2) NOT NULL,
    methode_paiement VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    date_transaction TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_abonnement) REFERENCES abonnements(id)
);

-- Table des managers (responsables commerciaux)
CREATE TABLE managers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_entreprise INT NOT NULL,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_entreprise) REFERENCES entreprises(id)
);

-- Table des agents commerciaux
CREATE TABLE agents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_manager INT NOT NULL,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_manager) REFERENCES managers(id)
);

-- Table des statuts de prospect
CREATE TABLE prospects_statuts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL
);

-- Table des prospects
CREATE TABLE prospects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_entreprise INT NOT NULL,
    id_agent INT, -- Peut être NULL si le prospect n'est pas encore assigné
    id_statut INT NOT NULL,
    nom VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telephone VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_entreprise) REFERENCES entreprises(id),
    FOREIGN KEY (id_agent) REFERENCES agents(id),
    FOREIGN KEY (id_statut) REFERENCES prospects_statuts(id)
);

-- Table de l'historique des actions
CREATE TABLE historiques (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_prospect INT NOT NULL,
    id_agent INT NOT NULL,
    action VARCHAR(255) NOT NULL, -- "Appel", "Email", "Note", etc.
    commentaire TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_prospect) REFERENCES prospects(id),
    FOREIGN KEY (id_agent) REFERENCES agents(id)
);

-- Table des messages prédéfinis
CREATE TABLE messages_predefinis (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sujet VARCHAR(255),
    contenu TEXT NOT NULL
);

-- Table des objections et réponses
CREATE TABLE objections_reponses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    objection VARCHAR(255) NOT NULL,
    reponse TEXT NOT NULL
);
