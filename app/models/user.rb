# Modèle représentant un utilisateur inscrit sur GossipBook
# Gère l'authentification sécurisée via bcrypt et les associations avec les contenus
class User < ApplicationRecord

  # ── Gestion sécurisée du mot de passe ─────────────────────────────────────
  # Activation de bcrypt pour le hachage des mots de passe
  # Ajoute les méthodes : authenticate(password), password=, password_confirmation=
  # Le mot de passe est stocké dans la colonne password_digest (JAMAIS en clair)
  has_secure_password

  # ── Associations ───────────────────────────────────────────────────────────

  # Un utilisateur peut écrire plusieurs potins
  # dependent: :destroy → si l'utilisateur est supprimé, ses potins le sont aussi
  has_many :gossips, dependent: :destroy

  # Un utilisateur peut écrire plusieurs commentaires
  has_many :comments, dependent: :destroy

  # Un utilisateur peut liker plusieurs potins
  has_many :likes, dependent: :destroy

  # ── Validations ────────────────────────────────────────────────────────────

  # Le nom d'utilisateur est obligatoire et doit être unique (insensible à la casse)
  validates :username,
            presence:   true,
            uniqueness: { case_sensitive: false },
            length:     { minimum: 2, maximum: 30 }

  # L'email est obligatoire, unique, et doit respecter le format standard
  validates :email,
            presence:   true,
            uniqueness: { case_sensitive: false },
            format:     { with: URI::MailTo::EMAIL_REGEXP, message: "n'est pas valide" }

  # Le mot de passe est obligatoire (min 6 car.) lors de la création
  # allow_nil: true autorise la mise à jour sans re-saisir le mot de passe
  validates :password,
            presence: true,
            length:   { minimum: 6 },
            allow_nil: true

  # ── Callbacks ─────────────────────────────────────────────────────────────

  # Normalisation de l'email en minuscules avant chaque sauvegarde
  # Garantit que "Alice@Example.COM" et "alice@example.com" sont traités identiquement
  before_save { self.email = email.downcase }

end
