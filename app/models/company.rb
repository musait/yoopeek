class Company < ApplicationRecord
  belongs_to :worker, :class_name => "Worker", :foreign_key => "worker_id"
  belongs_to :address
  accepts_nested_attributes_for :address
  validates_with IbanValidator, if: -> {!self.iban.empty?}
  validates :vat_number, :valvat => {:lookup => true,:allow_blank => true}
end
