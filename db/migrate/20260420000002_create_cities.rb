# Migration : création de la table 'cities' (villes)
# Chaque potin est associé à une ville pour le filtrage géographique
class CreateCities < ActiveRecord::Migration[7.1]
  def change
    # Création de la table des villes
    create_table :cities do |t|

      # Nom de la ville (ex: "Paris", "Lyon", "Marseille")
      t.string :name, null: false

      # Colonnes de timestamps automatiques
      t.timestamps

    end

    # Index UNIQUE sur le nom : évite les doublons de villes
    add_index :cities, :name, unique: true
  end
end
