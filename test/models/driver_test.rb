require 'test_helper'

class DriverTest < ActiveSupport::TestCase
  def setup
    @driver = Driver.new(name: "John Test",email: "john.test@example.com", password: "password", password_confirmation: "password")
  end
  test "Should be valid" do
    assert @driver.valid?
  end
  test "Name should be present" do
    @driver.name = " "
    assert_not @driver.valid?
  end
  test "Email should accept correct format" do
    valid_emails =  %w[user@example.com user2@example.co.uk user.third@city.gov.uk]
    valid_emails.each do |valids|
      @driver.email = valids
      assert @driver.valid?, "#{valids.inspect} should be valid."
    end
  end
  test "Email should reject incorrect format" do
    invalid_emails =  %w[user@example user2@example,com user3@example. user4@ @example.com user5@foo+bar.com]
    invalid_emails.each do |invalids|
      @driver.email = invalids
      assert_not @driver.valid?, "#{invalids.inspect} should be invalid."
    end
  end
  test "Email should be unique and case insensitive" do
    duplicate_driver = @driver.dup
    duplicate_driver.email = @driver.email.upcase
    @driver.save
    assert_not duplicate_driver.valid?
  end
  test "Email should be lower case before hitting db" do
    mixed_email = "User@Example.com"
    @driver.email = mixed_email
    @driver.save
    assert_equal mixed_email.downcase, @driver.reload.email
  end
  test "Password should be present" do
    @driver.password = @driver.password_confirmation = " "
    assert_not @driver.valid?
  end
  test "Password should be 8 or more characters long" do
    @driver.password = @driver.password_confirmation = "a" * 5
    assert_not @driver.valid?
  end
end