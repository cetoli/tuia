require File.dirname(__FILE__) + '/../test_helper'
require 'cadastro_controller'

# Re-raise errors caught by the controller.
class CadastroController; def rescue_action(e) raise e end; end

class CadastroControllerTest < Test::Unit::TestCase
  def setup
    @controller = CadastroController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
