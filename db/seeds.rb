# Fichier de données initiales (seeds) pour GossipBook
# Exécuter avec : rails db:seed
# Ou en repartant de zéro : rails db:drop db:create db:migrate db:seed

# ── Nettoyage préalable ───────────────────────────────────────────────────────
# Suppression dans l'ordre inverse des dépendances (clés étrangères)
puts "🧹 Nettoyage de la base de données..."
Like.destroy_all
Comment.destroy_all
Gossip.destroy_all
City.destroy_all
User.destroy_all

# ── Création des villes ────────────────────────────────────────────────────
puts "🏙️  Création des villes..."
paris     = City.create!(name: "Paris")
lyon      = City.create!(name: "Lyon")
marseille = City.create!(name: "Marseille")
bordeaux  = City.create!(name: "Bordeaux")
nice      = City.create!(name: "Nice")
toulouse  = City.create!(name: "Toulouse")

# ── Création des utilisateurs ──────────────────────────────────────────────
# Les mots de passe sont hashés automatiquement par bcrypt via has_secure_password
puts "👤 Création des utilisateurs..."

alice = User.create!(
  username:              "alice_dupont",           # Pseudo affiché publiquement
  email:                 "alice@example.com",      # Email de connexion (unique)
  password:              "password123",            # Mot de passe en clair (hashé par bcrypt)
  password_confirmation: "password123"             # Confirmation obligatoire
)

bob = User.create!(
  username:              "bob_martin",
  email:                 "bob@example.com",
  password:              "password123",
  password_confirmation: "password123"
)

charlie = User.create!(
  username:              "charlie_durand",
  email:                 "charlie@example.com",
  password:              "password123",
  password_confirmation: "password123"
)

diana = User.create!(
  username:              "diana_leblanc",
  email:                 "diana@example.com",
  password:              "password123",
  password_confirmation: "password123"
)

# ── Création des potins ────────────────────────────────────────────────────
puts "📢 Création des potins..."

g1 = Gossip.create!(
  title:   "Scandale au café du commerce",
  content: "On m'a dit que le patron du Café de la Place République servait de la chicorée " \
           "en faisant croire que c'était du vrai café depuis des années. " \
           "Sa clientèle fidèle commence à se douter de quelque chose...",
  user:    alice,    # alice est l'autrice de ce potin
  city:    paris     # potin situé à Paris
)

g2 = Gossip.create!(
  title:   "Le maire aperçu à la pâtisserie",
  content: "Quelqu'un a vu le maire de la ville engloutir trois éclairs au chocolat " \
           "alors qu'il prônait un régime équilibré pour tous les habitants. " \
           "Son attaché de presse n'a pas souhaité commenter.",
  user:    bob,
  city:    lyon
)

g3 = Gossip.create!(
  title:   "Mystère au 3ème étage de la rue de la Canebière",
  content: "Un voisin affirme avoir vu des lumières clignotantes dans l'appartement " \
           "du 3ème étage tous les vendredis après minuit. " \
           "Alien ou soirée secrète ? Le mystère reste entier.",
  user:    charlie,
  city:    marseille
)

g4 = Gossip.create!(
  title:   "La boulangerie Chez Michel : champion secret ?",
  content: "La boulangerie Chez Michel aurait reçu un prix clandestin de la meilleure baguette. " \
           "Personne ne sait où ni quand ce concours a eu lieu, " \
           "mais la baguette est effectivement divine.",
  user:    alice,
  city:    bordeaux
)

g5 = Gossip.create!(
  title:   "La ligue secrète des joggeurs de la Promenade",
  content: "Des joggeurs de la Promenade des Anglais auraient formé une confrérie secrète " \
           "pour réserver les bancs les plus confortables entre 7h et 9h. " \
           "Mot de passe requis pour s'asseoir.",
  user:    bob,
  city:    nice
)

g6 = Gossip.create!(
  title:   "Le pizzaiolo de la rue du Taur cache un secret",
  content: "D'après une source anonyme, le propriétaire de La Bella Pizza utiliserait " \
           "une recette volée à sa grand-mère napolitaine qui lui a formellement interdit " \
           "de divulguer la composition de la sauce tomate.",
  user:    diana,
  city:    toulouse
)

# ── Création des commentaires ──────────────────────────────────────────────
puts "💬 Création des commentaires..."

Comment.create!(content: "C'est incroyable ! J'y vais depuis 10 ans...",  user: bob,     gossip: g1)
Comment.create!(content: "Je confirme, j'ai goûté hier soir. Décevant.",  user: charlie, gossip: g1)
Comment.create!(content: "Haha, typique du maire. Il fait ça depuis 2020.", user: alice, gossip: g2)
Comment.create!(content: "Source fiable ? Qui vous a dit ça exactement ?", user: diana,  gossip: g3)
Comment.create!(content: "Cette baguette est vraiment incroyable, top !",  user: bob,    gossip: g4)
Comment.create!(content: "J'en fais partie. Je ne confirme ni ne démens.", user: charlie, gossip: g5)
Comment.create!(content: "La sauce tomate est effectivement un mystère.",   user: alice,  gossip: g6)

# ── Création des likes ─────────────────────────────────────────────────────
puts "❤️  Création des likes..."

Like.create!(user: alice,   gossip: g2)  # alice aime le potin sur le maire
Like.create!(user: alice,   gossip: g3)  # alice aime le mystère marseillais
Like.create!(user: bob,     gossip: g1)  # bob aime le scandale du café
Like.create!(user: bob,     gossip: g4)  # bob aime la boulangerie
Like.create!(user: charlie, gossip: g1)  # charlie aime le café
Like.create!(user: charlie, gossip: g5)  # charlie aime les joggeurs
Like.create!(user: diana,   gossip: g2)  # diana aime le maire
Like.create!(user: diana,   gossip: g6)  # diana aime la pizza

# ── Récapitulatif ─────────────────────────────────────────────────────────
puts ""
puts "✅ Base de données initialisée avec succès !"
puts "   #{User.count} utilisateurs"
puts "   #{City.count} villes"
puts "   #{Gossip.count} potins"
puts "   #{Comment.count} commentaires"
puts "   #{Like.count} likes"
puts ""
puts "🔐 Connexion avec : alice@example.com / password123"
