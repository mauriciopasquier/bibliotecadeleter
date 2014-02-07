# encoding: utf-8
require "./test/test_helper"

describe Reglas do
  describe 'sin cambios' do
    describe 'cantidad de demonios' do
      subject { Reglas.new build(:formato, demonios: 2) }

      it 'falla sin demonios' do
        subject.mazo = create(:mazo)
        subject.demonios_validos?.wont_equal true
      end

      it 'falla con demonios insuficientes' do
        subject.mazo = create(:mazo_con_demonios, cantidad: 1)
        subject.demonios_validos?.wont_equal true
      end

      it 'falla con demonios de más' do
        subject.mazo = create(:mazo_con_demonios, cantidad: 3)
        subject.demonios_validos?.wont_equal true
      end

      it 'pasa con la cantidad exacta' do
        subject.mazo = create(:mazo_con_demonios, cantidad: 2)
        subject.demonios_validos?.must_equal true
      end
    end

    describe 'cantidad en el mazo principal' do
      subject { Reglas.new build(:formato, principal: 10) }

      it 'falla con cartas insuficientes' do
        subject.mazo = create(:mazo, principal_attributes: {
          slots: [build(:slot, cantidad: 5)]
        })
        subject.mazo_principal_valido?.wont_equal true
      end

      it 'falla con cartas de más' do
        subject.mazo = create(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 15) ]
        })
        subject.mazo_principal_valido?.wont_equal true
      end

      it 'pasa con la cantidad exacta' do
        subject.mazo = create(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 10) ]
        })
        subject.mazo_principal_valido?.must_equal true
      end
    end

    describe 'cantidad en el mazo suplente' do
      subject { Reglas.new build(:formato, suplente: 10) }

      it 'falla con cartas insuficientes' do
        subject.mazo = create(:mazo, suplente_attributes: {
          slots: [ build(:slot, cantidad: 5) ]
        })
        subject.mazo_suplente_valido?.wont_equal true
      end

      it 'falla con cartas de más' do
        subject.mazo = create(:mazo, suplente_attributes: {
          slots: [build(:slot, cantidad: 15)]
        })
        subject.mazo_suplente_valido?.wont_equal true
      end

      it 'pasa con cero cartas' do
        subject.mazo = create(:mazo, suplente_attributes: { slots: [ ] })
        subject.mazo_suplente_valido?.must_equal true
      end

      it 'pasa sin mazo suplente' do
        subject.mazo = build(:mazo, suplente: nil)
        subject.mazo_suplente_valido?.must_equal true
      end

      it 'pasa con la cantidad exacta' do
        subject.mazo = create(:mazo, suplente_attributes: {
          slots: [ build(:slot, cantidad: 10) ]
        })
        subject.mazo_suplente_valido?.must_equal true
      end
    end

    describe 'cantidad de copias válidas' do
      subject { Reglas.new build(:formato, copias: 2) }

      it 'falla con más copias de las permitidas' do
        subject.mazo = create(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 3) ]
        })
        subject.copias_validas?.wont_equal true
      end

      it 'pasa con las Ilimitadas' do
        subject.mazo = create(:mazo, principal_attributes: {
          slots:  [ build(:slot, cantidad: 3,
                    version: create(:version_con_carta, supertipo: 'Algo Ilimitado Pasa')) ]
        })
        subject.copias_validas?.must_equal true
      end

      it 'considera las copias totales (principal y suplente)' do
        misma_carta = create(:version_con_carta)
        subject.mazo = create(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 2, version: misma_carta) ]
        }, suplente_attributes: {
          slots: [ build(:slot, cantidad: 2, version: misma_carta) ]
        })
        subject.copias_validas?.wont_equal true
      end
    end

    describe 'cartas prohibidas' do
      subject do
        @prohibida = create(:carta_con_versiones, nombre: 'prohibida')
        @mazo = create(:mazo)
        Reglas.new create(:formato, cartas_prohibidas: [ @prohibida ]), @mazo
      end

      it 'pasa si el formato no tiene cartas prohibidas' do
        Reglas.new(build(:formato)).cartas_permitidas?.must_equal true
      end

      it 'pasa si el mazo no usa cartas prohibidas' do
        subject.mazo.update(principal_attributes: {
          slots: [
            create(:slot, cantidad: 1, version: create(:version_con_carta), inventario: subject.mazo)
          ]
        })
        subject.cartas_permitidas?.must_equal true
      end

      it 'falla si el mazo usa cartas prohibidas' do
        subject.mazo.update(principal_attributes: {
          slots: [
            create(:slot, cantidad: 1, inventario: subject.mazo, version: @prohibida.canonica)
          ]
        })
        subject.cartas_permitidas?.wont_equal true
      end
    end

    describe 'expansiones' do
      subject do
        @expansion = create(:expansion)
        @mazo = create(:mazo)
        Reglas.new create(:formato, expansiones: [ @expansion ]), @mazo
      end

      it 'pasa sin expansiones definidas' do
        Reglas.new(build(:formato)).expansiones_validas?.must_equal true
      end

      it 'pasa si todas las cartas son de expansiones permitidas' do
        subject.mazo.update(principal_attributes: {
          slots: [
            create(:slot, cantidad: 1, inventario: subject.mazo,
              version: create(:version_con_carta, expansion_id: @expansion.id))
          ]
        })
        subject.expansiones_validas?.must_equal true
      end

      it 'falla si alguna carta no es de expansiones permitidas' do
        subject.mazo.update(principal_attributes: {
          slots: [
            create(:slot, cantidad: 1, inventario: subject.mazo, version: create(:version_con_carta))
          ]
        })
        subject.expansiones_validas?.wont_equal true
      end

      it 'falla si algún demonio no es de expansiones permitidas' do
        subject.mazo = create(:mazo, slots: [
          create(:slot, cantidad: 1, inventario: subject.mazo,
            version: create(:version_con_carta, supertipo: 'Demonio'))
          ], principal_attributes: {
          slots: [
            create(:slot, cantidad: 1, inventario: subject.mazo,
            version: create(:version_con_carta, expansion_id: @expansion.id))
        ]})
        subject.expansiones_validas?.wont_equal true
      end
    end
  end

  describe 'con cambios no persistidos' do
    describe 'cantidad de demonios' do
      subject { Reglas.new build(:formato, demonios: 2) }

      it 'falla sin demonios' do
        subject.mazo = build(:mazo)
        subject.demonios_validos?.wont_equal true
      end

      it 'falla con demonios insuficientes' do
        subject.mazo = build(:mazo_con_demonios, cantidad: 1)
        subject.demonios_validos?.wont_equal true
      end

      it 'falla con demonios de más' do
        subject.mazo = build(:mazo_con_demonios, cantidad: 3)
        subject.demonios_validos?.wont_equal true
      end

      it 'pasa con la cantidad exacta' do
        subject.mazo = build(:mazo_con_demonios, cantidad: 2)
        subject.demonios_validos?.must_equal true
      end
    end

    describe 'cantidad en el mazo principal' do
      subject { Reglas.new build(:formato, principal: 10) }

      it 'falla con cartas insuficientes' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [build(:slot, cantidad: 5)]
        })
        subject.mazo_principal_valido?.wont_equal true
      end

      it 'falla con cartas de más' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 15) ]
        })
        subject.mazo_principal_valido?.wont_equal true
      end

      it 'pasa con la cantidad exacta' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 10) ]
        })
        subject.mazo_principal_valido?.must_equal true
      end

      it 'falla sin mazo principal' do
        subject.mazo = build(:mazo, principal: nil)
        subject.mazo_principal_valido?.wont_equal true
      end
    end

    describe 'cantidad en el mazo suplente' do
      subject { Reglas.new build(:formato, suplente: 10) }

      it 'falla con cartas insuficientes' do
        subject.mazo = build(:mazo, suplente_attributes: {
          slots: [ build(:slot, cantidad: 5) ]
        })
        subject.mazo_suplente_valido?.wont_equal true
      end

      it 'falla con cartas de más' do
        subject.mazo = build(:mazo, suplente_attributes: {
          slots: [build(:slot, cantidad: 15)]
        })
        subject.mazo_suplente_valido?.wont_equal true
      end

      it 'pasa con cero cartas' do
        subject.mazo = build(:mazo, suplente_attributes: { slots: [ ] })
        subject.mazo_suplente_valido?.must_equal true
      end

      it 'pasa sin mazo suplente' do
        subject.mazo = build(:mazo, suplente: nil)
        subject.mazo_suplente_valido?.must_equal true
      end

      it 'pasa con la cantidad exacta' do
        subject.mazo = build(:mazo, suplente_attributes: {
          slots: [ build(:slot, cantidad: 10) ]
        })
        subject.mazo_suplente_valido?.must_equal true
      end
    end

    describe 'cantidad de copias válidas' do
      subject { Reglas.new build(:formato, copias: 2) }

      it 'falla con más copias de las permitidas' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 3) ]
        })
        subject.copias_validas?.wont_equal true
      end

      it 'pasa con las Ilimitadas' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots:  [ build(:slot, cantidad: 3,
                    version: create(:version_con_carta, supertipo: 'Algo Ilimitado Pasa')) ]
        })
        subject.copias_validas?.must_equal true
      end

      it 'considera las copias totales (principal y suplente)' do
        misma_carta = create(:version_con_carta)
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 2, version: misma_carta) ]
        }, suplente_attributes: {
          slots: [ build(:slot, cantidad: 2, version: misma_carta) ]
        })
        subject.copias_validas?.wont_equal true
      end
    end

    describe 'cartas prohibidas' do
      subject do
        @prohibida = create(:carta_con_versiones, nombre: 'prohibida')
        Reglas.new create(:formato, cartas_prohibidas: [ @prohibida ])
      end

      it 'pasa si el formato no tiene cartas prohibidas' do
        Reglas.new(build(:formato)).cartas_permitidas?.must_equal true
      end

      it 'pasa si el mazo no usa cartas prohibidas' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 1, version: create(:version_con_carta)) ]
        })
        subject.cartas_permitidas?.must_equal true
      end

      it 'falla si el mazo usa cartas prohibidas' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 1, version: @prohibida.canonica) ]
        })
        subject.cartas_permitidas?.wont_equal true
      end
    end

    describe 'expansiones' do
      subject do
        @expansion = create(:expansion)
        Reglas.new create(:formato, expansiones: [ @expansion ])
      end

      it 'pasa sin expansiones definidas' do
        Reglas.new(build(:formato)).expansiones_validas?.must_equal true
      end

      it 'pasa si todas las cartas son de expansiones permitidas' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [
            build(:slot, cantidad: 1, version: create(:version_con_carta,
            expansion_id: @expansion.id))
          ]
        })
        subject.expansiones_validas?.must_equal true
      end

      it 'falla si alguna carta no es de expansiones permitidas' do
        subject.mazo = build(:mazo, principal_attributes: {
          slots: [ build(:slot, cantidad: 1, version: create(:version_con_carta)) ]
        })
        subject.expansiones_validas?.wont_equal true
      end

      it 'falla si algún demonio no es de expansiones permitidas' do
        subject.mazo = build(:mazo, slots: [
          build(:slot, cantidad: 1,
            version: create(:version_con_carta, supertipo: 'Demonio'))
          ], principal_attributes: {
          slots: [
            build(:slot, cantidad: 1, version: create(:version_con_carta,
            expansion_id: @expansion.id))
        ]})
        subject.expansiones_validas?.wont_equal true
      end
    end
  end
end
