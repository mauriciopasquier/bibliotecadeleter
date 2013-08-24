# encoding: utf-8
# En development, muestra los mails que la aplicación manda en
# http://localhost:3000/mail
class MailPreview < MailView
  include FactoryGirl::Syntax::Methods

  # Devise
  def confirmation_instructions
    arnes do |u|
      Devise::Mailer.confirmation_instructions(u)
    end
  end

  # Devise
  def reset_password_instructions
    arnes do |u|
      Devise::Mailer.reset_password_instructions(u)
    end
  end

  # Devise
  def unlock_instructions
    arnes do |u|
      Devise::Mailer.unlock_instructions(u)
    end
  end

  private

    # Todos los mails necesitan un usuario. Nos aseguramos que es destruido una
    # vez generado el mail.
    def arnes
      usuario = create :usuario
      begin
        debe_ser_un_mail = yield usuario
      rescue Exception => e
      ensure
        usuario.destroy
      end
      debe_ser_un_mail
    end
end
