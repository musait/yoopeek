class NotInPastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, "can't be blank")
    elsif value <= Time.zone.today
      record.errors.add(attribute,:cant_be_in_past)
    end
  end
end
