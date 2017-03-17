class Duty < ApplicationRecord
  validates :dutynum, presence: true, length:{minimum: 4, maximum: 10}
  VALID_TIME_REGEX = /\A([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]\z/
  validates :starttime, presence: true, format: {with: VALID_TIME_REGEX}
  validates :endtime, presence: true, format: {with: VALID_TIME_REGEX}
  validates :paytime, presence: true, format: {with: VALID_TIME_REGEX}
  belongs_to :driver
  validates :driver_id, presence: true
end