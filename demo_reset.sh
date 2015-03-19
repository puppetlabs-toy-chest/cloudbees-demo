vagrant snap rollback master.inf.puppetlabs.demo --name demo_start
vagrant snap rollback jenkins.inf.puppetlabs.demo --name demo_start
vagrant snap rollback wordpress-staging.pdx.puppetlabs.demo --name demo_start
vagrant snap rollback wordpress.pdx.puppetlabs.demo --name demo_start

cd ~/cloudbees/profile
git co nginx
git reset --hard d7d2094
git push ccaum nginx --force
git co master
git reset --hard 3502b10
git push puppetlabs master --force

cd ~/cloudbees/site
git co staging
git reset --hard 2b68ec1
git push puppetlabs staging --force
git co production
git reset --hard 7679357
git push puppetlabs production --force

cd ~/projects/cloudbees-demo
JENKINS_IP=`vagrant ssh jenkins.inf.puppetlabs.demo -c 'facter ipaddress_enp0s8'`
ps aux | grep jnlp | grep -v grep || javaws http://$JENKINS_IP:8080/computer/provisioner/slave-agent.jnlp
