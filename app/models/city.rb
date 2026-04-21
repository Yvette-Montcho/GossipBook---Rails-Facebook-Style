# Modèle représentant une ville dans laquelle des potins peuvent être postés
# Permet le filtrage géographique des potins
class City < ApplicationRecord

  # ── Associations ───────────────────────────────────────────────────────────

  # Une ville peut contenir plusieurs potins
  # Pas de dependent: :destroy → on garde les potins même si une ville disparaît
  has_many :gossips

  # ── Validations ────────────────────────────────────────────────────────────

  # Le nom de la ville est obligatoire et doit être unique
  validates :name, presence: true, uniqueness: true

end
