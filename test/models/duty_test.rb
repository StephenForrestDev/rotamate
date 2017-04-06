require 'test_helper'

class DutyTest < ActiveSupport::TestCase
  def setup
    @driver = Driver.create!(name: "Stephen", email: "Stephen@example.com", password: "password", password_confirmation: "password")
    @duty = @driver.duties.build(dutynum: "1111", starttime: '07:00', endtime:'18:30', paytime: '8:00', notes: "Long duty")
  end
  test "Duty should be valid" do
    assert @duty.valid?
  end
  test "Duty without driver should be invalid" do
    @duty.driver_id = nil
    assert_not @duty.valid?
  end
  test "Duty Num should be present" do
    @duty.dutynum = ""
    assert_not @duty.valid?
  end
  test "starttime should be present" do
    @duty.starttime = ""
    assert_not @duty.valid?
  end
  test "Duty num should be more than 3 characters" do
    @duty.dutynum = "ab"
    assert_not @duty.valid?
  end
  test "Duty times should accept correct format" do
    valid_times = %w[07:00 19:00 23:59 00:00]
    valid_times.each do |valids|
      @duty.paytime = valids
      assert @duty.valid?, "#{valids.inspect} should be valid."
    end
  end
  test "Duty times should reject incorrect format" do
    invalid_times = %w[-10:00 23:60 00:-1 25:24 two:thirty]
    invalid_times.each do |invalids|
      @duty.paytime = invalids
      assert_not @duty.valid?, "#{invalids.inspect} should be invalid."
    end
  end
  
end

