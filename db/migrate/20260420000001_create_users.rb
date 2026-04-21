# Migration : création de la table 'users' (utilisateurs)
# Cette table stocke les comptes des utilisateurs inscrits sur GossipBook
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    # Création de la table avec contraintes NOT NULL sur les colonnes essentielles
    create_table :users do |t|

      # Nom d'utilisateur public affiché sur les potins et commentaires
      t.string :username, null: false

      # Adresse e-mail servant d'identifiant de connexion
      t.string :email, null: false

      # Hash bcrypt du mot de passe (JAMAIS le mot de passe en clair !)
      # Nommé password_digest par convention de has_secure_password
      t.string :password_digest, null: false

      # Colonnes de timestamps Rails : created_at et updated_at (gérées automatiquement)
      t.timestamps

    end

    # Index UNIQUE sur l'email : empêche deux utilisateurs avec le même email
    # Accélère aussi les recherches par email lors de la connexion
    add_index :users, :email, unique: true

    # Index UNIQUE sur le username : empêche deux utilisateurs avec le même pseudo
    add_index :users, :username, unique: true
  end
end
