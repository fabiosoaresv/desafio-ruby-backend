class Customer < ApplicationRecord
  validate :valid_cpf, on: [ :create, :update ]
  validates :cpf, presence: true, uniqueness: true

  def valid_cpf
    return errors.add(:base, "CPF #{self.cpf} inválido.") unless CPF.valid?(self.cpf)
  end

  private

  def record_exists?
    return true if Customer.find_by_cpf(self.cpf).present?
    false
  end
end
