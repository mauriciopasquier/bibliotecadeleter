# encoding: utf-8
class Ability
  include CanCan::Ability

  @@canones = [Carta, Expansion, Version, Artista, Imagen, Formato]
  @@apocrifos = [
    Lista, Mazo, Link, Coleccion, Reserva, Principal, Suplente, Diseno, Torneo,
    Inscripcion
  ]
  @@modelos = @@canones + @@apocrifos

  cattr_reader :canones, :apocrifos, :modelos

  def initialize(usuario = nil)
    alias_action :buscar, :info, :panel, :sobre, :todo, to: :read
    alias_action :carnet, :avatar, to: :update

    # Iniciar un invitado si no hay usuario logueado
    @usuario = usuario || Usuario.new

    # Permisos para todos y todas
    anonimo

    medallas_por_prioridad.each do |permisos|
      send permisos
    end
  end

  private

    # :manage es cualquier acción, no sólo CRUD
    def bibliotecario
      can :manage, canones
    end

    def socio
      can :create, apocrifos
      can :manage, [Diseno, Lista, Mazo], usuario_id: @usuario.id
      can :manage, Usuario, id: @usuario.id

      # Puede organizar sus propios torneos
      can :manage, Torneo, organizador_id: @usuario.id
      can :manage, Inscripcion, torneo_id: @usuario.torneos_organizado_ids

      # Puede leer documentos de búsqueda de recursos no visibles si son suyos
      [Mazo, Lista].each do |modelo|
        can :read, PgSearch::Document,
          searchable_type: modelo.name,
          searchable_id: @usuario.send("#{modelo.name.downcase}_ids")
      end
    end

    def anonimo
      can :read, :all
      cannot :read, [Mazo, Lista], visible: false

      # No puede leer documentos de búsqueda de recursos no visibles
      [Mazo, Lista].each do |modelo|
        cannot :read, PgSearch::Document,
          searchable_type: modelo.name,
          searchable_id: modelo.where(visible: false).pluck(:id)
      end
    end

    # Ordenadas por prioridad de mayor a menor, para la aplicación de reglas
    def medallas_por_prioridad
      @usuario.medallas.sort do |medalla|
        medalla.custom_fields[:prioridad]
      end.collect(&:name)
    end
end
