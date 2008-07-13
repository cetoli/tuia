require File.dirname(__FILE__) + '/../test_helper'
require 'area_interess_controller'

# Re-raise errors caught by the controller.
class AreaInteressController; def rescue_action(e) raise e end; end

class AreaInteressControllerTest < Test::Unit::TestCase
  def setup
    @controller = AreaInteressController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
