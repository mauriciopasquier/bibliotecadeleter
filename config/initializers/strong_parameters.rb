# https://github.com/rails/strong_parameters
# Proteger a todos los recursos por default.
# TODO sacar con rails 4
ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)
