require 'rails_helper'

describe Transaction do
  let!(:customer) {Customer.create(cpf: Faker::CPF.numeric.to_s) }
  let!(:provider) { Provider.create(name_provider: 'Teste') }

  context 'when create a new Transaction with valid data and' do
    let(:transaction) do
      Transaction.create(
        provider_id: provider.id,
        customer_id: customer.id,
        type_transaction: 1,
        value: 192.0,
        date_transaction: '2019-03-01',
        hour: '17:27:12',
        number_card: '6777****1313'
      )
    end

    it 'create with successful' do
      expect(transaction).to be_valid
      expect(transaction.provider_id).to eq(provider.id)
      expect(transaction.customer_id).to eq(customer.id)
      expect(transaction.type_transaction).to eq('debito')
      expect(transaction.value).to eq(192.0)
      expect(transaction.date_transaction.class).to eq(Date)
      expect(transaction.hour).to eq('17:27:12')
      expect(transaction.number_card).to eq('6777****1313')
    end
  end

  context 'when try create a Transaction without Provider and' do
    let(:transaction) do
      Transaction.create(
        customer_id: customer.id,
        type_transaction: 1,
        value: 192.0,
        date_transaction: '2019-03-01',
        hour: '17:27:12',
        number_card: '6777****1313'
      )
    end

    it 'fails' do
      expect(transaction).to be_invalid
      expect { transaction.save! }.to raise_error
    end
  end

  context 'when try create a Transaction without Customer and' do
    let(:transaction) do
      Transaction.create(
        provider_id: provider.id,
        type_transaction: 1,
        value: 192.0,
        date_transaction: '2019-03-01',
        hour: '17:27:12',
        number_card: '6777****1313'
      )
    end

    it 'fails' do
      expect(transaction).to be_invalid
      expect { transaction.save! }.to raise_error
    end
  end
end
