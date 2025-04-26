# Utilise une image de base avec Python 3.11 (stable et légère)
FROM python:3.11-slim

# Installe les dépendances système nécessaires (pour SQLite et autres)
RUN apt-get update && apt-get install -y \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Définit le répertoire de travail
WORKDIR /app

# Copie uniquement requirements.txt pour profiter du cache Docker
COPY requirements.txt .

# Installe les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copie le reste des fichiers
COPY . .

# Expose le port pour l'API Flask (Fly.io utilise 8080 par défaut)
EXPOSE 8080

# Définit la commande pour lancer le bot
CMD ["python", "bot.py"]
