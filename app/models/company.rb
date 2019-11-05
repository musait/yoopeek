class Company < ApplicationRecord
  belongs_to :worker, :class_name => "Worker", :foreign_key => "worker_id"
  belongs_to :address
  accepts_nested_attributes_for :address
  validates_with IbanValidator, if: -> {!self.iban.blank?}
  validates :vat_number, :valvat => {:lookup => true,:allow_blank => true}
  after_create :create_address

  def create_address
    self.build_address
    self.save
  end

  def is_subject_to_vat?
    self.subject_to_vat == true
  end
end
