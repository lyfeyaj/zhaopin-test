set :deploy_to, "/var/www/edgepeek/apps/#{application}"

set :user, "www-data"
server "edgepeek", :app, :web, :db, :primary => true

set :asset_env, "RAILS_RELATIVE_URL_ROOT=/#{application}"
