# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord

    validates :cat_id, :start_date, :end_date, :status, presence: true

    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status, dummy"}

    validate :does_not_overlap_approved_request

    def overlapping_requests
        CatRentalRequest
        .select(:id)
        .where(cat_id: cat_id)
        .where.not("start_date > ? OR end_date < ?", end_date, start_date)
    end

    def overlapping_approved_requests
        self.overlapping_requests
        .where(status: 'APPROVED')
    end

    def does_not_overlap_approved_request
        if overlapping_approved_requests.exists?
            errors.add(:base, "that request timeframe is not available")
        end
    end

    def approve!
        CatRentalRequest.transaction do
            self.status = 'APPROVED'
            self.save!

            self.overlapping_pending_requests.each do |req|
                req.update!(status: 'DENIED')
            end
        end
    end

    def overlapping_pending_requests
        self.overlapping_requests.where(status: 'PENDING')
    end

    def deny!
        self.status = 'DENIED'
        self.save!
    end

    belongs_to :cat

end
