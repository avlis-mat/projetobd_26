require "application_system_test_case"

class ModelosTest < ApplicationSystemTestCase
  setup do
    @modelo = modelos(:one)
  end

  test "visiting the index" do
    visit modelos_url
    assert_selector "h1", text: "Modelos"
  end

  test "should create modelo" do
    visit modelos_url
    click_on "New modelo"

    fill_in "Atualizado em", with: @modelo.Atualizado_em
    fill_in "Criado em", with: @modelo.Criado_em
    fill_in "Descricao", with: @modelo.Descricao
    fill_in "Nome", with: @modelo.Nome
    fill_in "Status", with: @modelo.Status
    fill_in "Versao", with: @modelo.Versao
    fill_in "Idusuario", with: @modelo.idUsuario
    click_on "Create Modelo"

    assert_text "Modelo was successfully created"
    click_on "Back"
  end

  test "should update Modelo" do
    visit modelo_url(@modelo)
    click_on "Edit this modelo", match: :first

    fill_in "Atualizado em", with: @modelo.Atualizado_em.to_s
    fill_in "Criado em", with: @modelo.Criado_em.to_s
    fill_in "Descricao", with: @modelo.Descricao
    fill_in "Nome", with: @modelo.Nome
    fill_in "Status", with: @modelo.Status
    fill_in "Versao", with: @modelo.Versao
    fill_in "Idusuario", with: @modelo.idUsuario
    click_on "Update Modelo"

    assert_text "Modelo was successfully updated"
    click_on "Back"
  end

  test "should destroy Modelo" do
    visit modelo_url(@modelo)
    click_on "Destroy this modelo", match: :first

    assert_text "Modelo was successfully destroyed"
  end
end
