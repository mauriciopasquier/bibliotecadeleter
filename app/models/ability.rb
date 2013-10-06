# encoding: utf-8
class Ability
  include CanCan::Ability

  @@canones = [ Carta, Expansion, Version, Artista, Imagen ]
  @@apocrifos = [ Lista, Mazo, Link, Coleccion, Reserva, Principal, Suplente ]
  @@modelos = @@canones + @@apocrifos

  cattr_reader :canones, :apocrifos, :modelos

  def initialize(usuario = nil)
    alias_action :buscar, to: :read

    @usuario = usuario || Usuario.new # guest user (not logged in)

    # Permisos para todos y todas
    anonimo

    medallas_por_prioridad.each do |permisos|
      send permisos
    end
  end

  private

    def bibliotecario
      can :manage, canones
    end

    def socio
      can :create, apocrifos
      can :manage, [ Lista, Mazo ], usuario_id: @usuario.id
      can :manage, Usuario, id: @usuario.id
    end

    def anonimo
      can :read, :all
      cannot :read, [ Mazo, Lista ], visible: false
    end

    # Ordenadas por prioridad de mayor a menor, para la aplicación de reglas
    def medallas_por_prioridad
      if @usuario.persisted?
        @usuario.badges.sort do |medalla|
          medalla.custom_fields[:prioridad]
        end.collect(&:name)
      else
        []
      end
    end

end
