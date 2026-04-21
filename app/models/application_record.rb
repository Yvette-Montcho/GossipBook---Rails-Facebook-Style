# Classe de base abstraite dont héritent TOUS les modèles de l'application
# Toute configuration commune à tous les modèles peut être ajoutée ici
class ApplicationRecord < ActiveRecord::Base
  # Déclare cette classe comme abstraite : elle n'a pas de table associée en BDD
  # Tous les modèles qui héritent de cette classe héritent d'ActiveRecord::Base
  primary_abstract_class
end
