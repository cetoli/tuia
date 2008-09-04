require File.dirname(__FILE__) + '/../test_helper'
require 'seminario_controller'

# Re-raise errors caught by the controller.
class SeminarioController; def rescue_action(e) raise e end; end

class SeminarioControllerTest < Test::Unit::TestCase
  def setup
    @controller = SeminarioController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
