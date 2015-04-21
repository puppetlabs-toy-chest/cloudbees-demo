vagrant snap rollback master.inf.puppetlabs.demo --name demo_start
vagrant snap rollback jenkins.inf.puppetlabs.demo --name demo_start
vagrant snap rollback wordpress-staging.pdx.puppetlabs.demo --name demo_start
vagrant snap rollback wordpress.pdx.puppetlabs.demo --name demo_start

cd ~/projects/cloudbees/cloudbees-profile
git co nginx
git reset --hard e9cf568
git push ccaum nginx --force
git co master
git reset --hard 2d17d09
git push puppetlabs master --force

cd ~/projects/cloudbees/cloudbees-site
git co staging
git reset --hard a836317
git push puppetlabs staging --force
git co production
git reset --hard 0ca6aeb
git push puppetlabs production --force

cd ~/projects/cloudbees-demo
vagrant ssh -c 'sudo /opt/puppet/bin/r10k deploy environment -p production' master.inf.puppetlabs.demo
vagrant ssh -c 'sudo service pe-puppetserver restart' master.inf.puppetlabs.demo
vagrant ssh -c 'sudo /opt/puppet/bin/puppet agent -t' jenkins.inf.puppetlabs.demo
vagrant ssh -c 'sudo /opt/puppet/bin/puppet agent -t' master.inf.puppetlabs.demo
vagrant ssh -c 'sudo service network restart' master.inf.puppetlabs.demo
vagrant ssh -c 'sudo service network restart' jenkins.inf.puppetlabs.demo
vagrant ssh -c 'sudo service network restart' wordpress.pdx.puppetlabs.demo
vagrant ssh -c 'sudo service network restart' wordpress-staging.pdx.puppetlabs.demo
vagrant ssh -c 'sudo service network restart' wordpress-staging.pdx.puppetlabs.demo
vagrant ssh -c 'sudo service pe-mcollective restart' wordpress.pdx.puppetlabs.demo
vagrant ssh -c 'sudo service pe-mcollective restart' wordpress-staging.pdx.puppetlabs.demo
