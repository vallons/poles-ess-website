class Subscription < ApplicationRecord

  # Associations ===============================================================
  belongs_to :formation
  has_many :participants, inverse_of: :subscription, dependent: :destroy

  attr_accessor :save_subscription

  accepts_nested_attributes_for :participants, reject_if: :all_blank, allow_destroy: true

  # Callbacks ========================================

  private def notify_participant
    p "notify_participant ================================================="
    participants.each do |participant|
      ParticipantMailer.with(participant: participant).new_subscription.deliver_now
    end
  end
  after_create :notify_participant


  # Validations ========================================
  
  def at_least_one_participant
    return true if participants.any?
    errors.add(:base, :at_least_one_participant)
    false
  end
  validate :at_least_one_participant

  # Scopes ====================================================================

  scope :by_formation, -> (val) {
    where(formation_id: val)
  }

  # Instance methods ====================================================


end
