#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#execute 'add-apt-repository ppa:openjdk-r/ppa'
apt_repository 'openjdk' do
  uri 'ppa:openjdk-r/ppa'
end

apt_update

package 'openjdk-7-jre'

group 'tomcat' 

user 'tomcat' do
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
  home '/opt/tomcat'
end

# http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27.tar.gz
remote_file '/tmp/apache-tomcat-8.5.27.tar.gz' do
  source 'http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27.tar.gz'
end

directory '/opt/tomcat' do
  owner 'tomcat'
  group 'tomcat'
  recursive true
  action :create
end

execute 'tar xvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

directory '/opt/tomcat/conf' do
  mode '0040'
  recursive true
end

execute 'sudo chmod -R g+r /opt/tomcat/conf'

directory '/opt/tomcat/conf' do
  mode '0050'
end

directory '/opt/tomcat' do
  group 'tomcat'
  recursive true
end

%w[ webapps work temp logs ].each do |path|
  directory path do
    owner 'tomcat'
    recursive true
  end
end

execute 'chgrp -R tomcat /opt/tomcat'

execute 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/'

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'
#execute 'systemctl start tomcat'
#execute 'systemctl enable tomcat'

service 'tomcat' do
  action [:start, :enable]
end

execute 'curl http://localhost:8080'
