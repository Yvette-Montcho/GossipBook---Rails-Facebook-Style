# Source officielle du dépôt des gems Ruby
source 'https://rubygems.org'

# Bloc permettant d'utiliser des gems directement depuis GitHub
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Version de Ruby requise pour ce projet
ruby '3.2.0'

# ── Framework principal ──────────────────────────────────────────────────────

# Rails 7.1 : framework MVC complet pour le développement web en Ruby
gem 'rails', '~> 7.1'

# ── Base de données ──────────────────────────────────────────────────────────

# SQLite3 : base de données légère pour le développement local
gem 'sqlite3', '~> 1.6'

# ── Serveur web ──────────────────────────────────────────────────────────────

# Puma : serveur HTTP haute performance inclus par défaut dans Rails
gem 'puma', '~> 6.0'

# ── Assets ───────────────────────────────────────────────────────────────────

# Sprockets : pipeline de compilation des assets (CSS, JS)
gem 'sprockets-rails'

# ── Sécurité / Authentification ──────────────────────────────────────────────

# bcrypt : hachage cryptographique des mots de passe (OBLIGATOIRE - décommentée)
# Fournit has_secure_password dans les modèles Active Record
gem 'bcrypt', '~> 3.1.7'

# ── Performance ──────────────────────────────────────────────────────────────

# Bootsnap : accélère le démarrage de Rails via la mise en cache du bytecode
gem 'bootsnap', '>= 1.4.4', require: false

# ── Groupes spécifiques aux environnements ────────────────────────────────────

group :development, :test do
  # Debug : débogueur Ruby moderne pour les environnements dev et test
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Web Console : console interactive dans le navigateur lors des erreurs Rails
  gem 'web-console'
end

group :test do
  # Capybara : framework de tests d'intégration simulant un navigateur
  gem 'capybara'
  # Selenium WebDriver : pilote de navigateur pour les tests système Rails
  gem 'selenium-webdriver'
end
