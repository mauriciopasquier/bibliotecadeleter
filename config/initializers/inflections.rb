# La deshabilito en el Gemfile y la requiero acá porque de otra forma se carga
# después que este archivo y borra las que defina acá.
# TODO Contrib to inflections gem
require 'inflections/es'

ActiveSupport::Inflector.inflections do |i|
  i.irregular 'linkeable', 'linkeables'
  i.irregular 'link', 'links'
end
