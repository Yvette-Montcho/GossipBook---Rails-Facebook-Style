# Helper de gestion des sessions utilisateur
# Inclus dans ApplicationController → disponible dans TOUS les contrôleurs ET toutes les vues
# Fournit une interface simple pour la connexion, déconnexion et vérification d'état
module SessionsHelper

  # Connecte un utilisateur en stockant son identifiant dans la session du navigateur
  # La session Rails est chiffrée automatiquement → sécurisée contre les manipulations
  # Paramètre : user (instance de User à connecter)
  def log_in(user)
    # Stockage de l'id de l'utilisateur dans le hash session (côté navigateur, chiffré)
    session[:user_id] = user.id
  end

  # Déconnecte l'utilisateur en supprimant son identifiant de la session
  def log_out
    # Suppression de la clé user_id du hash session
    session.delete(:user_id)
    # Réinitialisation de la variable d'instance mémoïsée pour éviter les références obsolètes
    @current_user = nil
  end

  # Retourne l'utilisateur actuellement connecté, ou nil si personne n'est connecté
  # Utilise la mémoïsation (||=) pour ne faire qu'UNE SEULE requête SQL par requête HTTP
  # Évite de multiples appels DB si current_user est appelé plusieurs fois dans une vue
  def current_user
    # Si une session user_id est présente, on cherche l'utilisateur correspondant
    if session[:user_id]
      # ||= : calcule et mémoïse @current_user seulement si nil (optimisation)
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Retourne true si un utilisateur est connecté, false sinon
  # Pratique pour les conditions dans les vues : if logged_in? ... end
  def logged_in?
    # present? retourne false si current_user est nil ou false
    current_user.present?
  end

end
