FactoryGirl.define do
  factory :inscripcion do
    torneo
    participante  { generate :cadena_unica }
    codigo        { generate :cadena_unica }
  end
end
