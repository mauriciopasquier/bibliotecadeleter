Forem.user_class = "Usuario"
Forem.email_from_address = "homunculo@bibliotecadeleter.com.ar"
# If you do not want to use gravatar for avatars then specify the method to use here:
Forem.avatar_user_method = :avatar_decorado
Forem.user_profile_links = true
Forem.per_page = 20

# Usar nuestro layout según https://github.com/radar/forem/wiki/Theming
Forem.layout = 'application'

# Rails.application.config.to_prepare do
#   If you want to add your own cancan Abilities to Forem, uncomment and
#   customize the next line:
#   Forem::Ability.register_ability(Ability)
# end
#
# By default, these lines will use the layout located at app/views/layouts/forem.html.erb in your application.

# Incluir nuestros helpers
Forem::TopicsHelper.send :include, PaginacionHelper
