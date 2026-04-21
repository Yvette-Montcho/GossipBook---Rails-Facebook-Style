# Migration : création de la table 'likes' (j'aime)
# Un like représente l'appréciation d'un utilisateur pour un potin donné
class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    # Création de la table des likes
    create_table :likes do |t|

      # Clé étrangère vers users : l'utilisateur qui a liké
      # null: false → un like DOIT être associé à un utilisateur
      t.references :user, null: false, foreign_key: true

      # Clé étrangère vers gossips : le potin liké
      # null: false → un like DOIT être associé à un potin
      t.references :gossip, null: false, foreign_key: true

      # Colonnes de timestamps automatiques
      t.timestamps

    end

    # Index composite UNIQUE sur (user_id, gossip_id)
    # → Un même utilisateur ne peut liker un même potin qu'UNE SEULE FOIS
    # Cette contrainte est doublée au niveau du modèle Active Record (validates)
    add_index :likes, [:user_id, :gossip_id], unique: true
  end
end
