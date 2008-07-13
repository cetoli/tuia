require File.dirname(__FILE__) + '/../test_helper'
require 'manual_controller'

# Re-raise errors caught by the controller.
class ManualController; def rescue_action(e) raise e end; end

class ManualControllerTest < Test::Unit::TestCase
  def setup
    @controller = ManualController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
