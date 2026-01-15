# Test de connexion à la base de données

## � ERREUR 401 (Unauthorized) - SOLUTION

### Causes possibles :
1. ❌ **Aucun token d'authentification** → L'utilisateur n'est pas connecté
2. ❌ **Token expiré** → L'utilisateur doit se reconnecter
3. ❌ **Token invalide** → Problème lors de la connexion

### ✅ Solutions :

#### 1. Vérifier si l'utilisateur est connecté
```dart
// Dans la console, cherchez :
❌ AUCUN TOKEN - L'utilisateur doit se connecter
```

➡️ **Action** : Connectez-vous d'abord avant d'accéder à l'historique

#### 2. Le token est présent mais invalide
```dart
// Dans la console, cherchez :
✅ Token injecté: eyJhbGciOiJIUzI1NiIsI...
🛑 Erreur 401 sur : https://api.villageconnecte.voisilab.online/api/forfaits
🚨 ERREUR 401 - Token invalide ou expiré
```

➡️ **Action** : Déconnectez-vous puis reconnectez-vous

#### 3. Vérifier le token manuellement
Ouvrez un terminal PowerShell et testez l'API :

```powershell
# Remplacez YOUR_TOKEN par votre token
curl -H "Authorization: Bearer YOUR_TOKEN" https://api.villageconnecte.voisilab.online/api/forfaits
```

---

## 📡 Endpoints configurés :

1. **Principal** : `https://api.villageconnecte.voisilab.online/api/forfaits`
2. **Fallback 1** : `https://api.villageconnecte.voisilab.online/api/user-access`
3. **Fallback 2** : `https://api.villageconnecte.voisilab.online/api/historique/achats`

---

## 🔍 Logs à surveiller dans la console :

### ✅ Connexion réussie :
```
🔄 [REPOSITORY] Chargement de l'historique depuis la BASE DE DONNÉES...
📡 [HISTORY API] Récupération des forfaits achetés (BASE DE DONNÉES)...
🌐 [GET] https://api.villageconnecte.voisilab.online/api/forfaits
✅ Token injecté: eyJhbGciOiJIUzI1NiIsI...
✅ [HISTORY API] Réponse reçue - Status: 200
📦 [HISTORY API] Données RÉELLES (forfaits): [...]
✅ [REPOSITORY] 5 achats RÉELS récupérés de la BASE
```

### ❌ Erreur d'authentification :
```
🌐 [GET] https://api.villageconnecte.voisilab.online/api/forfaits
❌ AUCUN TOKEN - L'utilisateur doit se connecter
🛑 Erreur 401 sur : https://api.villageconnecte.voisilab.online/api/forfaits
🚨 ERREUR 401 - Token invalide ou expiré
🗑️ Token supprimé - Reconnexion nécessaire
```

---

## 🚀 Test rapide :

1. **Lancez l'app** :
   ```powershell
   flutter run -d windows
   ```

2. **Connectez-vous d'abord** avec vos identifiants

3. **Allez sur l'onglet Historique**

4. **Consultez les logs** pour voir si les données proviennent de la base

---

## 📊 Format JSON attendu de l'API `/forfaits` :

```json
[
  {
    "id": "1",
    "nom": "Forfait 3h",
    "date": "2026-01-15",
    "code": "ABC123",
    "prix": 1500,
    "devise": "FCFA",
    "actif": true,
    "utilisation": "2h 30min"
  }
]
```

Ou avec structure objet :
```json
{
  "data": [...],
  "forfaits": [...]
}
```
