# Migration : création de la table 'comments' (commentaires)
# Un commentaire est rédigé par un utilisateur sur un potin spécifique
class CreateComments < ActiveRecord::Migration[7.1]
  def change
    # Création de la table des commentaires
    create_table :comments do |t|

      # Texte du commentaire (champ long pour permettre des réponses détaillées)
      t.text :content, null: false

      # Clé étrangère vers users : l'auteur du commentaire
      # null: false → un commentaire DOIT avoir un auteur
      t.references :user, null: false, foreign_key: true

      # Clé étrangère vers gossips : le potin commenté
      # null: false → un commentaire DOIT être rattaché à un potin
      t.references :gossip, null: false, foreign_key: true

      # Colonnes de timestamps automatiques
      t.timestamps

    end
  end
end
