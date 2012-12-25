# encoding: utf-8
class Ability
  include CanCan::Ability

  def initialize(usuario = nil)
    @usuario = usuario || Usuario.new # guest user (not logged in)

    if @usuario.persisted?
      registrado
    else
      anonimo
    end
  end

  private

    def registrado
      can :manage, :all
    end

    def anonimo
      can :read, :all
    end

end
