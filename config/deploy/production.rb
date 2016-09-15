set :branch, 'master'

role :app, %w{153.122.46.13}
role :web, %w{153.122.46.13}
role :db,  %w{153.122.46.13}

server '153.122.46.13', user: 'gravure', port: 10022, roles: %w{web app db}

set :ssh_options, {
    keys: [File.expand_path('~/.ssh/id_rsa')],
    forward_agent: true,
    auth_methods: %w(publickey)
}

set :deploy_to, '/var/www/gravure-tube'
set :current_path, "#{deploy_to}/current"
set :releases_path, "#{deploy_to}/releases"
