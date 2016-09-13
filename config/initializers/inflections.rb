ActiveSupport::Inflector.inflections do |i|
  i.irregular 'linkeable', 'linkeables'
  i.irregular 'link', 'links'
  i.irregular 'slot', 'slots'

  # Merit
  i.irregular 'score', 'scores'
  i.irregular 'point', 'points'

  # Rails
  i.irregular 'schema_migration', 'schema_migrations'
end
