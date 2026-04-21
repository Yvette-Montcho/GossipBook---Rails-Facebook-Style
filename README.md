# 📢 GossipBook - Rails Facebook-Style

> Application web de type réseau social de potins, développée en Ruby on Rails.
> Projet pédagogique - Semaine 6 / Jour 4

---

## 🗂️ Table des matières

1. [Description du projet](#description)
2. [Fonctionnalités](#fonctionnalités)
3. [Stack technique](#stack-technique)
4. [Prérequis](#prérequis)
5. [Installation et exécution](#installation-et-exécution)
6. [Exécution avec VS Code](#exécution-avec-vs-code)
7. [Extensions VS Code recommandées](#extensions-vs-code-recommandées)
8. [Structure du projet](#structure-du-projet)
9. [Accès de test](#accès-de-test)
10. [Concepts clés mis en œuvre](#concepts-clés)

---

## 📖 Description du projet <a name="description"></a>

**GossipBook** est une application Rails de partage de potins inspirée de Facebook.
Elle met en œuvre :
- **L'authentification sécurisée** via `bcrypt` (mots de passe hashés, jamais en clair)
- **La gestion des sessions** Rails (connexion / déconnexion)
- **Un système de likes** (j'aime / je n'aime plus)
- **Des associations Active Record** (utilisateurs → potins → commentaires → likes)
- **Des autorisations** (seul l'auteur peut modifier ou supprimer son potin)

---

## ✅ Fonctionnalités <a name="fonctionnalités"></a>

| Fonctionnalité                        | Détail                                          |
|--------------------------------------|-------------------------------------------------|
| Inscription                          | Formulaire email + nom d'utilisateur + mot de passe |
| Connexion / Déconnexion              | Session Rails sécurisée                         |
| Création de potins                   | Titre + contenu + ville                         |
| Affichage des potins                 | Page d'accueil et page de détail                |
| Édition / Suppression des potins     | Restreint à l'auteur                            |
| Commentaires                         | Ajout de commentaires sur un potin              |
| Likes / Délikes                      | Un like par utilisateur par potin               |
| Filtrage par ville                   | Page dédiée par ville                           |
| Protection des routes                | Redirection vers login si non connecté          |
| Navbar dynamique                     | Change selon l'état de connexion                |

---

## 🛠️ Stack technique <a name="stack-technique"></a>

| Composant       | Technologie                     |
|----------------|----------------------------------|
| Framework       | Ruby on Rails 7.1               |
| Langage         | Ruby 3.2                        |
| Base de données | SQLite3 (développement)         |
| Auth sécurité   | gem `bcrypt` + `has_secure_password` |
| CSS / UI        | Bootstrap 5.3 (CDN)             |
| Icônes          | Bootstrap Icons 1.11            |
| Serveur         | Puma                            |

---

## 📋 Prérequis <a name="prérequis"></a>

Avant de commencer, assurez-vous d'avoir installé :

- **Ruby** 3.2+ → [https://www.ruby-lang.org/fr/downloads/](https://www.ruby-lang.org/fr/downloads/)
- **Ruby on Rails** 7.1+ → `gem install rails`
- **Bundler** → `gem install bundler`
- **Git** → [https://git-scm.com/](https://git-scm.com/)
- **VS Code** → [https://code.visualstudio.com/](https://code.visualstudio.com/)

Vérification des versions :
```bash
ruby -v      # ruby 3.2.x
rails -v     # Rails 7.1.x
bundler -v   # Bundler 2.x
```

---

## 🚀 Installation et exécution <a name="installation-et-exécution"></a>

### Étape 1 - Cloner et initialiser l'application Rails

```bash
# Cloner le dépôt
git clone https://github.com/VOTRE_USERNAME/gossipbook-rails.git
cd gossipbook-rails

# Générer le squelette Rails par-dessus les fichiers du dépôt
rails new . --skip-bundle --skip-git
```

> ⚠️ **Important :** La commande `rails new .` va proposer d'écraser certains fichiers.
> Répondez **n** (non) pour conserver les fichiers personnalisés du dépôt
> (routes.rb, application_controller.rb, application.html.erb, etc.)

### Étape 2 - Installer les dépendances

```bash
bundle install
```

### Étape 3 - Créer et initialiser la base de données

```bash
# Créer la base de données SQLite3
rails db:create

# Exécuter toutes les migrations (créer les tables)
rails db:migrate

# Injecter les données de test (optionnel mais recommandé)
rails db:seed
```

### Étape 4 - Lancer le serveur

```bash
rails server
# ou raccourci :
rails s
```

### Étape 5 - Ouvrir dans le navigateur

Rendez-vous sur → **[http://localhost:3000](http://localhost:3000)**

---

### Commandes utiles

```bash
# Repartir de zéro (supprimer et recréer la BDD)
rails db:drop db:create db:migrate db:seed

# Afficher toutes les routes de l'application
rails routes

# Ouvrir la console Rails (pour tester les modèles)
rails console

# Vérifier les gems installées
bundle list
```

---

## 💻 Exécution avec VS Code <a name="exécution-avec-vs-code"></a>

### Méthode 1 - Terminal intégré VS Code (recommandée)

1. Ouvrir VS Code
2. **Fichier → Ouvrir le dossier** → sélectionner `gossipbook/`
3. Ouvrir le terminal intégré : **Terminal → Nouveau terminal** (ou `Ctrl+ù` / `` Ctrl+` ``)
4. Dans le terminal, exécuter :

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

5. Cliquer sur le lien `http://localhost:3000` dans la sortie du terminal
   (VS Code le rend cliquable automatiquement)

### Méthode 2 - Tâches VS Code (`.vscode/tasks.json`)

Créer le fichier `.vscode/tasks.json` dans le projet :

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Rails Server",
      "type": "shell",
      "command": "rails server",
      "group": { "kind": "build", "isDefault": true },
      "presentation": { "reveal": "always", "panel": "new" }
    },
    {
      "label": "Rails Setup (install + migrate + seed)",
      "type": "shell",
      "command": "bundle install && rails db:create db:migrate db:seed",
      "presentation": { "reveal": "always", "panel": "new" }
    }
  ]
}
```

Lancer via : **Terminal → Exécuter la tâche** → `Rails Server`

### Méthode 3 - Débogage Rails dans VS Code

Installer la gem `debug` (déjà dans le Gemfile) et créer `.vscode/launch.json` :

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Rails Debug",
      "type": "ruby_lsp",
      "request": "launch",
      "program": "${workspaceRoot}/bin/rails",
      "args": ["server", "-p", "3000"]
    }
  ]
}
```

---

## 🧩 Extensions VS Code recommandées <a name="extensions-vs-code-recommandées"></a>

Installer ces extensions avant de travailler sur le projet :

### Essentielles

| Extension | ID | Utilité |
|-----------|-----|---------|
| **Ruby LSP** | `Shopify.ruby-lsp` | IntelliSense, autocomplétion, diagnostics Ruby |
| **ERB Formatter/Beautify** | `aliariff.vscode-erb-beautify` | Formatage automatique des fichiers `.html.erb` |
| **Rails** | `bung87.rails` | Navigation rapide entre controllers, views, models |
| **Rails Go to Spec** | `sporto.rails-go-to-spec` | Navigation entre fichiers et leurs specs |
| **endwise** | `kaiwood.endwise` | Fermeture automatique des blocs `end` en Ruby |

### Fortement recommandées

| Extension | ID | Utilité |
|-----------|-----|---------|
| **GitLens** | `eamodio.gitlens` | Visualisation git avancée dans VS Code |
| **SQLite Viewer** | `qwtel.sqlite-viewer` | Visualiser la base de données SQLite directement |
| **vscode-icons** | `vscode-icons-team.vscode-icons` | Icônes de fichiers pour mieux naviguer |
| **Auto Rename Tag** | `formulahendry.auto-rename-tag` | Renommage automatique des balises HTML |
| **Prettier** | `esbenp.prettier-vscode` | Formatage du code JS/CSS/HTML |

### Installation rapide de toutes les extensions

Dans le terminal VS Code :
```bash
code --install-extension Shopify.ruby-lsp
code --install-extension aliariff.vscode-erb-beautify
code --install-extension bung87.rails
code --install-extension kaiwood.endwise
code --install-extension eamodio.gitlens
code --install-extension qwtel.sqlite-viewer
code --install-extension vscode-icons-team.vscode-icons
```

---

## 🗃️ Structure du projet <a name="structure-du-projet"></a>

```
gossipbook/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb  ← include SessionsHelper, filtre authenticate_user!
│   │   ├── users_controller.rb        ← inscription (new, create)
│   │   ├── sessions_controller.rb     ← login/logout (new, create, destroy)
│   │   ├── gossips_controller.rb      ← CRUD complet des potins
│   │   ├── cities_controller.rb       ← affichage des potins par ville
│   │   ├── comments_controller.rb     ← création de commentaires
│   │   └── likes_controller.rb        ← like et délike
│   ├── helpers/
│   │   ├── application_helper.rb      ← helper full_title
│   │   └── sessions_helper.rb         ← current_user, logged_in?, log_in, log_out
│   ├── models/
│   │   ├── user.rb                    ← has_secure_password, validations
│   │   ├── city.rb                    ← has_many gossips
│   │   ├── gossip.rb                  ← belongs_to user/city, has_many comments/likes
│   │   ├── comment.rb                 ← belongs_to user/gossip
│   │   └── like.rb                    ← belongs_to user/gossip, unicité (user, gossip)
│   └── views/
│       ├── layouts/application.html.erb  ← navbar dynamique + flash
│       ├── shared/_flash.html.erb         ← messages flash Bootstrap
│       ├── users/new.html.erb             ← formulaire inscription
│       ├── sessions/new.html.erb          ← formulaire connexion
│       ├── gossips/
│       │   ├── index.html.erb             ← liste des potins
│       │   ├── show.html.erb              ← détail + commentaires
│       │   ├── new.html.erb               ← création
│       │   ├── edit.html.erb              ← édition
│       │   └── _gossip.html.erb           ← partial réutilisable
│       └── cities/show.html.erb           ← potins par ville
├── config/
│   └── routes.rb                      ← toutes les routes de l'app
├── db/
│   ├── migrate/                        ← 5 migrations (users, cities, gossips, comments, likes)
│   └── seeds.rb                        ← données de test
├── Gemfile                             ← dépendances (bcrypt obligatoire !)
├── .gitignore                          ← fichiers exclus de git
└── README.md                           ← ce fichier
```

---

## 🔐 Accès de test <a name="accès-de-test"></a>

Après `rails db:seed`, vous pouvez vous connecter avec :

| Email | Mot de passe | Nom d'utilisateur |
|-------|-------------|-------------------|
| `alice@example.com` | `password123` | alice_dupont |
| `bob@example.com` | `password123` | bob_martin |
| `charlie@example.com` | `password123` | charlie_durand |
| `diana@example.com` | `password123` | diana_leblanc |

---

## 🧠 Concepts clés mis en œuvre <a name="concepts-clés"></a>

### Hachage des mots de passe (bcrypt)
```ruby
# Dans User :
has_secure_password
# → stocke un hash dans password_digest, jamais le mot de passe en clair
# → fournit user.authenticate("mot_de_passe")
```

### Gestion des sessions
```ruby
# SessionsHelper :
session[:user_id] = user.id    # connexion
session.delete(:user_id)       # déconnexion
User.find_by(id: session[:user_id])  # utilisateur courant
```

### Protection des routes avec before_action
```ruby
# GossipsController :
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
before_action :authorize_author!,  only: [:edit, :update, :destroy]
```

### Système de likes
```ruby
# Like appartient à un User ET un Gossip
# Index unique (user_id, gossip_id) → un like maximum par paire
gossip.liked_by?(current_user)  # true / false
```

---

## 📝 Note pédagogique

> ⚠️ **Gem d'authentification interdite** : Ce projet n'utilise pas Devise ou Clearance.
> L'authentification est implémentée manuellement avec `bcrypt` uniquement,
> conformément aux exigences du cours.

---

*Développé dans le cadre de ETP4A Session 9 - Semaine 6, Jour 4*
