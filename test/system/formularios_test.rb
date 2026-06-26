require "application_system_test_case"

class FormulariosTest < ApplicationSystemTestCase
  setup do
    @formulario = formularios(:one)
  end

  test "visiting the index" do
    visit formularios_url
    assert_selector "h1", text: "Formularios"
  end

  test "should create formulario" do
    visit formularios_url
    click_on "New formulario"

    fill_in "Criado em", with: @formulario.criado_em
    fill_in "Data fim", with: @formulario.data_fim
    fill_in "Data inicio", with: @formulario.data_inicio
    fill_in "Destinatario", with: @formulario.destinatario
    fill_in "Idmodelo", with: @formulario.idModelo
    fill_in "Idturma", with: @formulario.idTurma
    fill_in "Idusuario", with: @formulario.idUsuario
    fill_in "Instrucoes", with: @formulario.instrucoes
    fill_in "Status", with: @formulario.status
    fill_in "Titulo", with: @formulario.titulo
    click_on "Create Formulario"

    assert_text "Formulario was successfully created"
    click_on "Back"
  end

  test "should update Formulario" do
    visit formulario_url(@formulario)
    click_on "Edit this formulario", match: :first

    fill_in "Criado em", with: @formulario.criado_em.to_s
    fill_in "Data fim", with: @formulario.data_fim
    fill_in "Data inicio", with: @formulario.data_inicio
    fill_in "Destinatario", with: @formulario.destinatario
    fill_in "Idmodelo", with: @formulario.idModelo
    fill_in "Idturma", with: @formulario.idTurma
    fill_in "Idusuario", with: @formulario.idUsuario
    fill_in "Instrucoes", with: @formulario.instrucoes
    fill_in "Status", with: @formulario.status
    fill_in "Titulo", with: @formulario.titulo
    click_on "Update Formulario"

    assert_text "Formulario was successfully updated"
    click_on "Back"
  end

  test "should destroy Formulario" do
    visit formulario_url(@formulario)
    click_on "Destroy this formulario", match: :first

    assert_text "Formulario was successfully destroyed"
  end
end
