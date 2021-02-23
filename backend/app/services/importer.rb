class Importer
  attr_reader :file

  def initialize(file)
    @file = File.open(file)&.readlines
  end

  def import_and_create_data
    return false unless file

    file.each do |line|
      data = convert_line_to_hash(line)
      provider = find_or_create_provider(data['provider'])
      customer = find_or_create_customer(data['customer'])
      data_transaction = data['transaction'].merge({ customer_id: customer.reload.id, provider_id: provider.reload.id })

      Transaction.create(data_transaction)
    end

    true
  end

  private

  def find_or_create_provider(provider)
    object = Provider.find_by(name_provider: provider[:name_provider])

    return object if object.present?
    Provider.create!(provider)
  end

  def find_or_create_customer(customer)
    object = Customer.find_by(cpf: customer[:cpf])

    return object if object.present?
    Customer.create!(customer)
  end

  def convert_line_to_hash(line)
    type =  line[0, 1].strip
    date = Date.parse(line[1, 8].strip).strftime("%d/%m/%Y")
    value = (line[9, 10].strip.to_f) / 100
    cpf = line[19, 11].strip
    card = line[30, 12].strip
    hour = line[42, 6].strip.scan(/[0-9]{2}/).join(':')
    name_owner = line[48, 14].strip
    name_provider = line[62, 19].strip

    {
      'transaction' => { type_transaction: type.to_i, date_transaction: date, value: value, hour: hour, number_card: card },
      'customer' => { cpf: cpf },
      'provider' => { name_owner: name_owner, name_provider: name_provider}
    }
  end
end
