class Position < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}

  belongs_to :coin
  belongs_to :portfolio
  belongs_to :user
  validates :quantity, presence: true, numericality: {greater_than: 0}

  def value
    self.coin.value * self.quantity
  end

end
