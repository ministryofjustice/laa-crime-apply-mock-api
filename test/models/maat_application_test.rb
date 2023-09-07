require "test_helper"

class MaatApplicationTest < ActiveSupport::TestCase
  test "should not save without a title" do
    maat_application = MaatApplication.new
    assert_not maat_application.save
  end
end
