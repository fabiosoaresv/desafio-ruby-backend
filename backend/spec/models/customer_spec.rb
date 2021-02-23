require 'rails_helper'

describe Customer do
  context 'when create a new Customer with valid CPF and' do
    it 'create with successful' do
      expect(Customer.create(cpf: Faker::CPF.numeric.to_s)).to be_valid
    end
  end

  context 'when create a new Customer with invalid CPF and' do
    let(:customer) { Customer.create(cpf: '1234') }

    it 'fails with message' do
      expect(customer).to be_invalid
    end
  end

  context 'when try create a Customer but it already exists and' do
    let(:cpf) { Faker::CPF.numeric.to_s }
    let(:customer) { Customer.create(cpf: cpf) }
    let(:customer2) { Customer.create(cpf: cpf) }

    it 'fails' do
      expect(customer).to be_valid
      expect(customer2.save).to eq(false)
      expect { customer2.save! }.to raise_error
    end
  end

  context 'when try make update a Customer with invalid CPF and' do
    let!(:customer) { Customer.create(cpf: Faker::CPF.numeric.to_s) }

    it 'fails' do
      expect(customer.update(cpf: '1234')).to eq(false)
      expect { customer.update!(cpf: '1234') }.to raise_error
    end
  end
end
