class Person < ApplicationRecord
  audited
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  private

  def cpf_or_cnpj
    if !CPF.valid?(national_id) && !CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end
end
