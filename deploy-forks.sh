#!/bin/bash

deploy_site () {
  cd $1
  git fetch forked-repo
  git rebase forked-repo/master
  git push -f origin master
}

deploy_site_vallons () {
  echo 'Debut deploiement vallons'
  deploy_site '../vallons-website'
  echo 'Fin deploiement vallons'
}

deploy_site_broceliande () {
  echo 'Debut deploiement broceliande'
  deploy_site '../broceliande-website'
  git push -f scalingo master
  echo 'Fin deploiement broceliande'
}

deploy_site_vallons
deploy_site_broceliande