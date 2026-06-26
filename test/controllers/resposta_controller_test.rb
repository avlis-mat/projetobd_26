require "test_helper"

class RespostaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @respostum = resposta(:one)
  end

  test "should get index" do
    get resposta_url
    assert_response :success
  end

  test "should get new" do
    get new_respostum_url
    assert_response :success
  end

  test "should create respostum" do
    assert_difference("Respostum.count") do
      post resposta_url, params: { respostum: { conteudo: @respostum.conteudo, idAluno: @respostum.idAluno, idFormulario: @respostum.idFormulario, idQuestao: @respostum.idQuestao, respondido_em: @respostum.respondido_em } }
    end

    assert_redirected_to respostum_url(Respostum.last)
  end

  test "should show respostum" do
    get respostum_url(@respostum)
    assert_response :success
  end

  test "should get edit" do
    get edit_respostum_url(@respostum)
    assert_response :success
  end

  test "should update respostum" do
    patch respostum_url(@respostum), params: { respostum: { conteudo: @respostum.conteudo, idAluno: @respostum.idAluno, idFormulario: @respostum.idFormulario, idQuestao: @respostum.idQuestao, respondido_em: @respostum.respondido_em } }
    assert_redirected_to respostum_url(@respostum)
  end

  test "should destroy respostum" do
    assert_difference("Respostum.count", -1) do
      delete respostum_url(@respostum)
    end

    assert_redirected_to resposta_url
  end
end
