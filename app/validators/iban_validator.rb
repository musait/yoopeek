require 'iban-tools'

class IbanValidator < ActiveModel::Validator
  def validate(record)
    unless IBANTools::IBAN.valid?(record.iban)
      record.errors.add(:iban, I18n.t("errors.messages.company.iban_not_valid"))
    end
  end
end
