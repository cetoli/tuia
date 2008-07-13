require File.dirname(__FILE__) + '/../test_helper'
require 'turma_controller'

# Re-raise errors caught by the controller.
class TurmaController; def rescue_action(e) raise e end; end

class TurmaControllerTest < Test::Unit::TestCase
  def setup
    @controller = TurmaController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
