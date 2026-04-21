# Modèle représentant un commentaire laissé par un utilisateur sur un potin
class Comment < ApplicationRecord

  # ── Associations ───────────────────────────────────────────────────────────

  # Un commentaire appartient à un utilisateur (son auteur)
  belongs_to :user

  # Un commentaire appartient à un potin
  belongs_to :gossip

  # ── Validations ────────────────────────────────────────────────────────────

  # Le contenu du commentaire est obligatoire
  validates :content, presence: true

end
