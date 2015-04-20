vagrant snap rollback master.inf.puppetlabs.demo --name demo_start
vagrant snap rollback jenkins.inf.puppetlabs.demo --name demo_start
vagrant snap rollback wordpress-staging.pdx.puppetlabs.demo --name demo_start
vagrant snap rollback wordpress.pdx.puppetlabs.demo --name demo_start

cd ~/projects/cloudbees/cloudbees-profile
git co nginx
git reset --hard d47163a
git push ccaum nginx --force
git co master
git reset --hard 239c066
git push puppetlabs master --force
git pull_request -b puppetlabs:master --title "Use nginx intead of apache"

cd ~/projects/cloudbees/cloudbees-site
git co staging
git reset --hard a836317
git push puppetlabs staging --force
git co production
git reset --hard 0ca6aeb
git push puppetlabs production --force
