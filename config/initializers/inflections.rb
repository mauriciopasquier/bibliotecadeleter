ActiveSupport::Inflector.inflections do |i|
  i.irregular 'linkeable', 'linkeables'
  i.irregular 'link', 'links'
  i.irregular 'slot', 'slots'

  # Merit
  i.irregular 'score', 'scores'
  i.irregular 'point', 'points'

  # Rails
  i.irregular 'schema_migration', 'schema_migrations'

  # Forem
  i.irregular 'category',         'categories'
  i.irregular 'forum',            'forums'
  i.irregular 'topic',            'topics'
  i.irregular 'post',             'posts'
  i.irregular 'view',             'views'
  i.irregular 'subscription',     'subscriptions'
  i.irregular 'group',            'groups'
  i.irregular 'membership',       'memberships'
  i.irregular 'moderator_group',  'moderator_groups'
end
