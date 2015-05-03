# encoding: utf-8
require './test/test_helper'

describe Ability do
  describe 'los bibliotecarios' do
    before do
      @usuario = create(:usuario)
      @usuario.add_badge BIBLIOTECARIO.id
    end

    subject { Ability.new @usuario }

    it 'manejan el cánon' do
      subject.canones.each do |modelo|
        subject.can?(:manage, modelo).must_equal true
      end
    end
  end

  describe 'los socios' do
    before do
      @usuario = create(:usuario)
      @usuario.add_badge SOCIO.id
    end

    subject { Ability.new @usuario }

    it 'crean listas y mazos, y las manejan' do
      subject.apocrifos.each do |modelo|
        subject.can?(:create, modelo).must_equal true, "No crea #{modelo}"
      end
      subject.can?(:manage, @usuario.coleccion).must_equal true
      subject.can?(:manage, @usuario.reserva).must_equal true
    end

    it 'leen todo' do
      subject.modelos.each do |modelo|
        subject.can?(:read, modelo).must_equal true, "No lee #{modelo}"
      end
    end

    it 'no leen cosas privadas de otros usuarios' do
      [:mazo, :lista].each do |modelo|
        recurso = build_stubbed(modelo, visible: false, usuario: @usuario)

        subject.can?(:read, recurso).must_equal true,
          "No lee #{recurso.class.name} privado propio"
      end

      otro = create(:usuario)

      [:mazo, :lista].each do |modelo|
        recurso = build_stubbed(modelo, visible: false, usuario: otro)

        subject.can?(:read, recurso).wont_equal true,
          "Lee #{recurso.class.name} privado ajeno"
      end

      subject.can?(:read, otro.coleccion).wont_equal true
      subject.can?(:read, otro.reserva).wont_equal true
    end

    it 'leen cosas públicas de otros usuarios' do
      otro = create(:usuario)

      [:mazo, :lista].each do |modelo|
        recurso = build_stubbed(modelo, visible: true, usuario: otro)

        subject.can?(:read, recurso).must_equal true,
          "No lee #{recurso.class.name} público ajeno"
      end

      [otro.coleccion, otro.reserva].each do |recurso|
        recurso.toggle! :visible
        subject.can?(:read, recurso).must_equal true,
          "No lee #{recurso.class.name} público ajeno"
      end
    end

    it 'no editan el canon' do
      subject.canones.each do |modelo|
        subject.can?(:update, modelo).wont_equal true, "Edita #{modelo}"
      end
    end

    it 'se manejan a sí mismos y a nadie más' do
      subject.can?(:manage, @usuario).must_equal true
      subject.can?(:manage, create(:usuario)).wont_equal true
    end

    it 'no cambian slots ajenos' do
      [:lista, :reserva, :coleccion].each do |modelo|
        recurso = build_stubbed(modelo, visible: true)

        subject.can?(:update_slot, recurso).wont_equal true,
          "Edita slots de #{recurso.class.name.pluralize}"
      end
    end

    it 'cambian slots propios' do
      [:lista, :reserva, :coleccion].each do |modelo|
        recurso = build_stubbed(modelo, usuario: @usuario)

        subject.can?(:update_slot, recurso).must_equal true,
          "No edita slots propios de #{recurso.class.name.pluralize}"
      end
    end
  end

  describe 'los anónimos' do
    subject { Ability.new }

    it 'leen todo lo público' do
      subject.modelos.each do |modelo|
        subject.can?(:read, modelo).must_equal true, "No lee #{modelo}"
      end
    end

    it 'no leen cosas privadas' do
      [:mazo, :lista].each do |modelo|
        recurso = build_stubbed(modelo, visible: false)

        subject.can?(:read, recurso).wont_equal true,
          "Lee #{recurso.class.name} privado"
      end
    end

    it 'no crean nada' do
      Ability.modelos.each do |modelo|
        subject.can?(:create, modelo).wont_equal true,
          "Crea #{modelo.name.pluralize}"
      end
    end

    it 'no editan nada' do
      [:mazo, :lista, :diseno, :torneo, :inscripcion].each do |modelo|
        recurso = create modelo

        subject.can?(:update, recurso).wont_equal true,
          "Edita #{recurso.class.name.pluralize}"
      end
    end

    it 'no cambian slots' do
      [:lista, :reserva, :coleccion].each do |modelo|
        recurso = build_stubbed(modelo, visible: true)

        subject.can?(:update_slot, recurso).wont_equal true,
          "Edita slots de #{recurso.class.name.pluralize}"
      end
    end
  end
end
