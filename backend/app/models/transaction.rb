# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :customer
  belongs_to :provider

  validates_presence_of :type_transaction
  before_save :set_signal_and_nature

  enum type_transaction: {
    debito: 1,
    boleto: 2,
    financiamento: 3,
    credito: 4,
    recebimento: 5,
    vendas: 6,
    recebimento_ted: 7,
    recebimento_doc: 8,
    aluguel: 9
  }

  TYPES_TRANSACTION_SAIDA = %w(boleto financiamento aluguel)

  def set_signal_and_nature
    if TYPES_TRANSACTION_SAIDA.include?(self.type_transaction)
      self.signal = false
      self.nature = 'Saída'
    else
      self.signal = true
      self.nature = 'Entrada'
    end
  end
end
