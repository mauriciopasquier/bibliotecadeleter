# encoding: utf-8
module ReservasHelper
  include PaginacionHelper

   def titulo
    case params[:action]
      when 'show'
        'Tu reserva de cartas'
      when 'edit'
        'Editando la reserva'
      else
        nil
    end
  end
end
