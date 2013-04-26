# TODO Sacar cuando actualice a rails 4
class ActionView::Helpers::InstanceTag
  DEFAULT_FIELD_OPTIONS.delete("size")
  DEFAULT_TEXT_AREA_OPTIONS.delete("rows")
  DEFAULT_TEXT_AREA_OPTIONS.delete("cols")
end
