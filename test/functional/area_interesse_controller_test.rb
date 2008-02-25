require File.dirname(__FILE__) + '/../test_helper'
require 'area_interesse_controller'

# Re-raise errors caught by the controller.
class AreaInteresseController; def rescue_action(e) raise e end; end

class AreaInteresseControllerTest < Test::Unit::TestCase
  def setup
    @controller = AreaInteresseController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
