require File.dirname(__FILE__) + '/../test_helper'
require 'dado_academico_controller'

# Re-raise errors caught by the controller.
class DadoAcademicoController; def rescue_action(e) raise e end; end

class DadoAcademicoControllerTest < Test::Unit::TestCase
  def setup
    @controller = DadoAcademicoController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
