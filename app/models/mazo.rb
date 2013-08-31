# encoding: utf-8
class Mazo < Lista
  attr_accessible :formato, :demonio_id
  store :data, accessors: [:formato, :demonio_id]

  validate :tiene_un_demonio

  def demonio
    Version.find(demonio_id) if demonio_id.present?
  end

  def demonio=(version)
    demonio_id = version.id if version.demonio?
  end

  private

    def tiene_un_demonio
      unless demonio_id.present? and Version.find(demonio_id).demonio?
        errors.add :demonio, :falta_un_demonio
      end
    end
end
