#!/bin/bash
echo "PATH=/opt/puppet/bin:$PATH" >> /root/.bashrc

cat << EOF > /etc/r10k.yaml
---
:cachedir: /var/cache/r10k
:sources:
  :local:
    remote: https://github.com/puppetlabs/cloudbees-site
    basedir: /etc/puppetlabs/puppet/environments
EOF

/opt/puppet/bin/puppet config set autosign true --section master

rm -rf /etc/puppetlabs/puppet/environments/*
/opt/puppet/bin/gem install r10k
yum install -y git
/opt/puppet/bin/r10k deploy environment -p

rm /etc/puppetlabs/puppet/hiera.yaml
ln -s /etc/puppetlabs/puppet/environments/production/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml

/bin/bash /vagrant/scripts/refresh_classes.sh
/bin/bash /vagrant/scripts/classifier.sh
/bin/bash /vagrant/scripts/rbac.sh

/bin/bash /vagrant/scripts/connect_ds.sh

/opt/puppet/bin/puppet agent --onetime --no-daemonize --color=false --verbose
