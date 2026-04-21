# Contrôleur pour afficher les potins filtrés par ville
# Route couverte : GET /cities/:id
class CitiesController < ApplicationController

  # GET /cities/:id
  # Affiche les potins d'une ville donnée
  def show
    # Récupération de la ville par son id (lève ActiveRecord::RecordNotFound si absente)
    @city = City.find(params[:id])

    # Chargement des potins de cette ville avec eager loading pour éviter les N+1
    @gossips = @city.gossips
                    .includes(:user, :comments, :likes)
                    .order(created_at: :desc)
  end

end
