Kaminari.configure do |config|
  config.default_per_page = 12
  # config.max_per_page = nil
  config.window = 2
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  config.page_method_name = :pagina
  config.param_name = :pagina
end
