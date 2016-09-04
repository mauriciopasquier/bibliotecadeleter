# encoding: utf-8
require './test/test_helper'

describe Torneo do
  it 'es válido' do
    build(:torneo).must_be :valid?
  end

  describe '#posiciones' do
    subject { build(:torneo) }

    it 'delega a las inscripciones' do
      mock = MiniTest::Mock.new.expect(:posicionadas, nil)

      subject.stub :inscripciones, mock do
        subject.posiciones
        mock.verify
      end
    end
  end

  describe '#posiciones_en' do
    subject { build(:torneo) }

    it 'delega a las inscripciones' do
      mock = MiniTest::Mock.new.expect(:posicionadas, nil)

      subject.stub :inscripciones, mock do
        subject.posiciones
        mock.verify
      end
    end
  end
end
