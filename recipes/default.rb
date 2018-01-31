#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package 'java-1.7.0-openjdk-devel'

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
  recursive 'true'
  action :create
end

execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

directory '/opt/tomcat/conf' do
  mode '0050'
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'
execute 'systemctl start tomcat'
execute 'systemctl enable tomcat'
