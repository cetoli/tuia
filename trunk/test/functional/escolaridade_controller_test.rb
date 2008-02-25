require File.dirname(__FILE__) + '/../test_helper'
require 'escolaridade_controller'

# Re-raise errors caught by the controller.
class EscolaridadeController; def rescue_action(e) raise e end; end

class EscolaridadeControllerTest < Test::Unit::TestCase
  def setup
    @controller = EscolaridadeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
