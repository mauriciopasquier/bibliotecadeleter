# encoding: utf-8
AttributeNormalizer.configure do |config|
  # The default normalizers if no :with option or block is given is to apply
  # the :strip and :blank normalizers (in that order).
  # config.default_normalizers = :strip, :blank

  # FIXME revisar los datos, nunca se aplicó esta configuración
  # You can enable the attribute normalizers automatically if the specified
  # attributes exist in your column_names. It will use
  # the default normalizers for each attribute (e.g.
  # config.default_normalizers)
  config.default_attributes = :nombre, :saga, :nick

  # Also, You can add an specific attribute to default_attributes using one or
  # more normalizers:
  # config.add_default_attribute :name, :with => :truncate

  # Todo en mayúsculas
  config.normalizers[:upcase] = lambda do |value, options|
    value.is_a?(String) ? value.upcase : value
  end
end
