# encoding: utf-8
class InicioController < ApplicationController
  skip_authorization_check

  def cambios
    changelog = Kramdown::Document.new(
      File.open(Rails.root.join('CHANGELOG.mdwn')).read
    )
    render inline: changelog.to_html, layout: 'application'
  end
end
