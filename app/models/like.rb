# Modèle représentant un "like" (j'aime) d'un utilisateur sur un potin
# Table de jointure enrichie entre users et gossips
class Like < ApplicationRecord

  # ── Associations ───────────────────────────────────────────────────────────

  # Un like est posé par un utilisateur
  belongs_to :user

  # Un like est associé à un potin
  belongs_to :gossip

  # ── Validations ────────────────────────────────────────────────────────────

  # Contrainte d'unicité : un utilisateur ne peut liker un potin qu'une seule fois
  # scope: :gossip_id → l'unicité est vérifiée par paire (user_id, gossip_id)
  # Cette validation est doublée par l'index unique en base de données
  validates :user_id,
            uniqueness: {
              scope:   :gossip_id,
              message: "a déjà liké ce potin"
            }

end
