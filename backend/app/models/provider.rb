class Provider < ApplicationRecord
  validate :valid_name_provider, on: [ :create ]

  def valid_name_provider
    return errors.add(:base, "Nome da Loja #{self.name_provider} já cadastrado.") if name_provider_exists?
  end

  private

  def name_provider_exists?
    return true if Provider.where('lower(name_provider) LIKE ?', "%#{self.name_provider.downcase}%").present?
    false
  end
end
