class ActionView::Helpers::FormBuilder
  def check_box_bootstrap(method, label_options = { }, check_options = { })

    check_options.reverse_merge! class: 'bootstrap'

    [
      check_box(method, objectify_options(check_options)),
      label(method, '&nbsp;'.html_safe, objectify_options(label_options))
    ].join.html_safe
  end
end
