class TorneosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'fecha asc' }, only: :index

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource
  skip_authorization_check only: [ :index, :show ]

  def index
    @busqueda = apply_scopes @torneos
    @torneos = PaginadorDecorator.decorate @busqueda.result

    respond_with @torneos
  end

  def show
    respond_with @torneo
  end

  def new
    respond_with @torneo
  end

  def edit
    respond_with @torneo
  end

  def create
    @torneo.organizador = current_usuario
    @torneo.save
    respond_with @torneo
  end

  def update
    @torneo.organizador = current_usuario
    @torneo.update_attributes(parametros_permitidos)
    respond_with @torneo
  end

  def destroy
    @torneo.destroy
    respond_with @torneo
  end

  # Acciones para rondas en masa (es más práctico que un nested resource)
  def nueva_ronda
    respond_with @torneo
  end

  def crear_ronda
    @torneo.jugado = true if @torneo.valid?
    @torneo.update_attributes(parametros_permitidos)
    @torneo.puntuar
    respond_with @torneo,
      location: ronda_torneo_path(@torneo, @torneo.ultima_ronda)
  end

  def deshacer_ronda
    @torneo.rondas.where(numero: params[:numero]).destroy_all
    redirect_to @torneo.rondas.any? ? nueva_ronda_torneo_path(@torneo) : @torneo
  end

  def mostrar_ronda
    respond_with @torneo
  end

  private

    def cargar_recurso
      @torneo = Torneo.new(parametros_permitidos)
    end

    def parametros_permitidos
      params.require(:torneo).permit(
        :fecha, :direccion, :juez_principal, :tienda_id, :lugar, :formato_id,
        inscripciones_attributes: [
          :id, :_destroy, :codigo, :participante, rondas_attributes: [
            :id, :_destroy, :oponente_id, :partidas_ganadas, :numero
          ]
        ]
      )
    end
end
