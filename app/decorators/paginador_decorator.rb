class PaginadorDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :total_count, :pagina

  # Para los FormBuilder y nested fields
  delegate :build
end
