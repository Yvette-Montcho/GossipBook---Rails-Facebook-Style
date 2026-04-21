# Migration : création de la table 'gossips' (potins)
# Un potin est publié par un utilisateur dans une ville donnée
class CreateGossips < ActiveRecord::Migration[7.1]
  def change
    # Création de la table principale du projet
    create_table :gossips do |t|

      # Titre court et accrocheur du potin
      t.string :title, null: false

      # Corps du potin : texte long autorisant plusieurs paragraphes
      t.text :content, null: false

      # Clé étrangère vers users : l'auteur du potin
      # null: false → un potin DOIT avoir un auteur
      # foreign_key: true → contrainte d'intégrité référentielle en base
      t.references :user, null: false, foreign_key: true

      # Clé étrangère vers cities : la ville associée au potin
      # null: false → un potin DOIT être rattaché à une ville
      t.references :city, null: false, foreign_key: true

      # Colonnes de timestamps automatiques
      t.timestamps

    end
  end
end
