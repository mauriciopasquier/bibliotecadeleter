require 'inflections/es'
ActiveSupport::Inflector.inflections do |i|
  i.irregular 'linkeable', 'linkeables'
  i.irregular 'link', 'links'
  i.irregular 'slot', 'slots'
end
