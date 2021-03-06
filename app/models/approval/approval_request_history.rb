class Approval::ApprovalRequestHistory < ActiveRecord::Base
  include Sys::Model::Base

  REASON_OPTIONS = [['承認', 'approve'], ['差し戻し', 'passback'], ['引き戻し', 'pullback']]

  belongs_to :request, :class_name => 'Approval::ApprovalRequest'
  validates_presence_of :request_id
  belongs_to :operator, :foreign_key => :user_id, :class_name => 'Sys::User'
  validates_presence_of :user_id

  def reason_title
    REASON_OPTIONS.detect{|o| o.last == reason }.try(:first)
  end
end
