class Customer < ApplicationRecord
  validate :valid_cpf, on: [ :create ]
  validate :valid_register, on: [ :create ]

  def valid_cpf
    return errors.add(:base, "CPF #{self.cpf} inválido.") unless CPF.valid?(self.cpf)
  end

  def valid_register
    return errors.add(:base, "CPF #{self.cpf} já cadastrado.") if register_exists?
  end

  private

  def register_exists?
    return true if Customer.find_by_cpf(self.cpf).present?
    false
  end
end
