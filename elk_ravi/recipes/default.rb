#
# Cookbook Name:: elk_ravi
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#execute "install java" do
#command "wget --no-cookies --no-check-certificate --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie\" \"http://do
wnload.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.rpm\""
#end
include_recipe "yum"

#execute "install java" do
#  command "yum -y jdk"
#end

#execute "install java" do
#  command "sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch"
#end

cookbook_file "/etc/yum.repos.d/elasticsearch.repo" do
  source "elasticsearch.repo"
  mode "0644"
end

cookbook_file "/etc/yum.repos.d/kibana.repo" do
  source "kibana.repo"
  mode "0644"
end

cookbook_file "/etc/yum.repos.d/logstash.repo" do
  source "logstash.repo"
  mode "0644"
end

execute "install elasticseach" do
  command "yum -y install elasticsearch"
end

cookbook_file "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml"
  mode "0644"
end

service 'elasticsearch' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

execute "install kibana" do
  command "yum -y install kibana"
end

service 'kibana' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

execute "install logstash" do
  command "yum -y install logstash"
end
include_recipe "elk_ravi::nginx"

service 'logstash' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
#cookbook_file "/etc/pki/tls/openssl.cnf" do
#  source "openssl.cnf"
#  mode "0644"
#end

#execute "crt logstash" do
#  command "openssl req -config /etc/pki/tls/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-
forwarder.crt"
#  cwd  /etc/pki/tls
#end

cookbook_file "/etc/logstash/conf.d/02-beats-input.conf" do
  source "02-beats-input.conf"
  mode "0644"
end

cookbook_file "/etc/logstash/conf.d/10-syslog-filter.conf" do
  source "10-syslog-filter.conf"
  mode "0644"
end

cookbook_file "/etc/logstash/conf.d/30-elasticsearch-output.conf" do
  source "30-elasticsearch-output.conf"
  mode "0644"
end
