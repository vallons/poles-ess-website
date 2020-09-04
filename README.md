# Poles ESS website

## Infos

Configuration initialisée en m'appuyant sur : 
- https://blog.echobind.com/optimal-ruby-on-rails-setup-for-2020-db8ea2b2c798

Staging : https://pole-ess-staging.osc-fr1.scalingo.io/

## Todo

- dynamically set css custom property : https://stackoverflow.com/questions/61508409/how-to-change-tailwind-config-js-dynamically-based-on-user-settings-in-rails

Cloud OVH : https://git.happy-dev.fr/snippets/7#ovh-public-cloud-stockage-des-objets-multim%C3%A9dias




## Commandes utiles

  g push scalingo master
  scalingo run rails c --app pole-ess-staging
  scalingo run rails db:migrate --app pole-ess-staging
  scalingo -a pole-ess-staging logs # -f -> temps reel / -F "web|worker" -> ces 2 process seulement
  scalingo -a pole-ess-staging logs -n 100000 > logs.txt
  scalingo run rake salesforce:send_all_automatic_invitations --app pole-ess-staging