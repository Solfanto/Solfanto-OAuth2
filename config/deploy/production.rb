# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

# role :app, %w{example.com}
# role :web, %w{example.com}
# role :db,  %w{example.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

credentials = YAML.load(`rails credentials:show`)

server credentials['production']['server'], user: credentials['production']['server_user'], roles: %w{web app db}

set :server_name, credentials['production']['domain_name']

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

set :deploy_user, credentials['production']['deploy_user']
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

set :rails_env, :production
set :enable_ssl, true
set :force_ssl, false

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
set :ssh_options, {
  keys: [credentials['production']['ssh_key_path']],
  forward_agent: false,
  auth_methods: %w(publickey)
}
