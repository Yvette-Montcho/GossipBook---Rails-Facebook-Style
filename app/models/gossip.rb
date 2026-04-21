# Modèle représentant un potin publié par un utilisateur dans une ville
# Entité centrale de GossipBook autour de laquelle s'organisent commentaires et likes
class Gossip < ApplicationRecord

  # ── Associations ───────────────────────────────────────────────────────────

  # Un potin appartient à un utilisateur (son auteur)
  # La clé étrangère user_id doit être renseignée (NOT NULL en base)
  belongs_to :user

  # Un potin est rattaché à une ville
  # La clé étrangère city_id doit être renseignée (NOT NULL en base)
  belongs_to :city

  # Un potin peut recevoir plusieurs commentaires
  # dependent: :destroy → les commentaires sont supprimés avec le potin
  has_many :comments, dependent: :destroy

  # Un potin peut recevoir plusieurs likes
  # dependent: :destroy → les likes sont supprimés avec le potin
  has_many :likes, dependent: :destroy

  # ── Validations ────────────────────────────────────────────────────────────

  # Le titre est obligatoire
  validates :title, presence: true

  # Le contenu est obligatoire et doit faire au moins 10 caractères
  validates :content, presence: true, length: { minimum: 10 }

  # ── Méthodes métier ───────────────────────────────────────────────────────

  # Vérifie si un utilisateur donné a déjà liké ce potin
  # Retourne true si un like existe pour cet utilisateur, false sinon
  # Utilisée dans les vues pour afficher le bon bouton (liker / déliker)
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
