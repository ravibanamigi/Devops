include_recipe "yum"
execute "add repo" do
  command "yum -y install epel-release"
end

execute "install nginx" do
  command "yum -y install nginx httpd-tools"
end

cookbook_file "/etc/nginx/conf.d/kibana.conf" do
  source "kibana.conf"
  mode "0644"
end
#htpasswd "/etc/nginx/htpassword" do
#  user "kibanaadmin"
#  password "kibanaadmin"
#end


service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

#cookbook_file "/etc/yum.repos.d/elasticsearch.repo" do
#  source "elasticsearch.repo"
#  mode "0644"
#end
