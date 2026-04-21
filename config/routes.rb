# Fichier de définition des routes HTTP de l'application GossipBook
# Chaque route associe une URL + un verbe HTTP à une action de contrôleur
Rails.application.routes.draw do

  # ── Route racine ────────────────────────────────────────────────────────────
  # GET / → GossipsController#index (page d'accueil = liste des potins)
  root to: 'gossips#index'

  # ── Routes d'inscription utilisateur ────────────────────────────────────────
  # GET  /signup → UsersController#new    (affiche le formulaire d'inscription)
  # POST /signup → UsersController#create (traite la soumission du formulaire)
  get  '/signup', to: 'users#new',    as: 'signup'
  post '/signup', to: 'users#create'

  # ── Routes de session (connexion / déconnexion) ───────────────────────────
  # GET    /login  → SessionsController#new     (affiche le formulaire de login)
  # POST   /login  → SessionsController#create  (authentifie l'utilisateur)
  # DELETE /logout → SessionsController#destroy (détruit la session = logout)
  get    '/login',  to: 'sessions#new',     as: 'login'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # ── Routes CRUD des potins avec ressources imbriquées ────────────────────
  # Génère automatiquement les 7 routes RESTful pour les potins :
  #   GET    /gossips           → index
  #   GET    /gossips/new       → new
  #   POST   /gossips           → create
  #   GET    /gossips/:id       → show
  #   GET    /gossips/:id/edit  → edit
  #   PATCH  /gossips/:id       → update
  #   DELETE /gossips/:id       → destroy
  resources :gossips do

    # Ressource imbriquée : commentaires d'un potin
    # POST /gossips/:gossip_id/comments → CommentsController#create
    resources :comments, only: [:create]

    # Ressource imbriquée : likes d'un potin
    # POST   /gossips/:gossip_id/likes     → LikesController#create
    # DELETE /gossips/:gossip_id/likes/:id → LikesController#destroy
    resources :likes, only: [:create, :destroy]

  end

  # ── Routes des villes ────────────────────────────────────────────────────
  # GET /cities/:id → CitiesController#show (affiche les potins d'une ville)
  resources :cities, only: [:show]

end
