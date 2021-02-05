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

  validates :name, :birth_date, :sex, :description, :color, presence: true

  def age
    p ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

end
