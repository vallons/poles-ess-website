# Poles ESS website

## Infos

Configuration initialisée en m'appuyant sur :
- https://blog.echobind.com/optimal-ruby-on-rails-setup-for-2020-db8ea2b2c798

Staging : https://pole-ess-staging.osc-fr1.scalingo.io/

## Installer le projet

- forker le projet git@github.com:lassembleuse/poles-ess-website.git
- configurer `config/database.yml` sur la base de `config/database.yml.example`
- configurer `db/seeds.rb` avec vos données, sur la base de `db/seeds.exemple.rb`
- supprimer les fichiers de credentials existants : `config/credentials.yml.enc` et  et `config/credentials/development.yml.enc` 
- renseigner les credentials : `EDITOR=vim rails credentials:edit` et `EDITOR=vim rails credentials:edit --environment development`

`config/credentials/development.yml.enc` :
```
openstack:
  container: nom-container
  auth_url: https://auth.cloud.ovh.net/v3
  username: "username"
  api_key: vOtReClE
  region: "GRA"
  temp_url_key: temp_url

mailjet:
  api_key: vOtReClE
  secret_key: vOtReClE
```

Vous aurez peut-être à arrêter spring pour que tout soit pris en compte :
`rails spring stop`

## Déployer

Générer les credentials de production : 
`EDITOR=vim rails credentials:edit --environment production`

Configurer openstack :

```
openstack:
  container: nom-container
  auth_url: https://auth.cloud.ovh.net/v3
  username: "username"
  api_key: vOtReClE
  region: "GRA"
  temp_url_key: temp_url
```

Copier votre clé `production.key` sur scalingo (`RAILS_MASTER_KEY`)

Ajouter le repo de scalingo : ` git remote add scalingo git@ssh.osc-fr1.scalingo.com:xxx.git `  (adresse dans le menu 'Code' de l'interface web de scalingo)

## Se synchroniser avec le repo original forké

```
g remote add forked-repo git@github.com:lassembleuse/poles-ess-website.git
g fetch forked-repo
g rebase forked-repo/master
```



## Commandes utiles

```
$ g push scalingo master
$ scalingo run rails c --app pole-ess-staging
$ scalingo run rails db:migrate --app pole-ess-staging
$ scalingo -a pole-ess-staging logs # -f -> temps reel / -F "web|worker" -> ces 2 process seulement
$ scalingo -a pole-ess-staging logs -n 100000 > logs.txt
$ scalingo -a pole-ess-staging run --env RAILS_MASTER_KEY=value

EDITOR=vim rails credentials:edit --environment staging


Pour déployer les forks :
  `./deploy-forks.sh`
