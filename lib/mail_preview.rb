# encoding: utf-8
# En development, muestra los mails que la aplicación manda en
# http://localhost:3000/mail
class MailPreview < MailView
  include FactoryGirl::Syntax::Methods

  def devise_confirmation_instructions
    Devise::Mailer.confirmation_instructions(usuario, token)
  end

  def devise_reset_password_instructions
    Devise::Mailer.reset_password_instructions(usuario, token)
  end

  def devise_unlock_instructions
    Devise::Mailer.unlock_instructions(usuario, token)
  end

  def forem_topic_reply
    Forem::SubscriptionMailer.topic_reply(post, usuario)
  end

  private

    def usuario
      Usuario.last
    end

    def token
      "40f51dd303bf6b0f1dcfc6ebae2d126331a6af01147e7cde08eb5eed4f15eb16"
    end

    def post
      Forem::Post.offset(rand(Forem::Post.count)).first
    end
end
