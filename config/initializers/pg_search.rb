PgSearch.multisearch_options = {
  ignoring: :accents,
  using: {
    tsearch: {
      prefix: true,
      dictionary: 'spanish',
      normalization: 2
    }
  }
}
