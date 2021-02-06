# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  birth_date  :date             not null
#  color       :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  COLORS = %w(black white ginger striped wild)
  SEXES = %w(M F Q A)

  validates :name, :birth_date, :sex, :color, presence: true
  validates :color, inclusion: { in: %w(black white ginger striped wild),
    message: "%{value} is not a valid cat color, dummy" }
  validates :sex, inclusion: { in: %w(M F Q A),
    message: "%{value} is not a valid sex at this time. We're working on becoming more progressive" }

  def age
    p ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

end
