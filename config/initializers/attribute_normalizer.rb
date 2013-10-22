# encoding: utf-8
AttributeNormalizer.configure do |config|
  # The default normalizers if no :with option or block is given is to apply
  # the :strip and :blank normalizers (in that order).
  # You can change this if you would like as follows:
  # config.default_normalizers = :strip, :blank

  # You can enable the attribute normalizers automatically if the specified
  # attributes exist in your column_names. It will use
  # the default normalizers for each attribute (e.g.
  # config.default_normalizers)
  config.default_attributes = :nombre, :saga, :nick

  # Also, You can add an specific attribute to default_attributes using one or
  # more normalizers:
  # config.add_default_attribute :name, :with => :truncate

  # Convertir true, 'true', 1 y '1' en true
  config.normalizers[:boolean] = lambda do |value, options|
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean value
  end
end
