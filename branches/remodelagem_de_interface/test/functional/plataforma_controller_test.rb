require File.dirname(__FILE__) + '/../test_helper'
require 'plataforma_controller'

# Re-raise errors caught by the controller.
class PlataformaController; def rescue_action(e) raise e end; end

class PlataformaControllerTest < Test::Unit::TestCase
  def setup
    @controller = PlataformaController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
