class MateriaController < ApplicationController
  before_action :set_materium, only: %i[ show edit update destroy ]

  # GET /materia or /materia.json
  def index
    @materia = Materium.all
  end

  # GET /materia/1 or /materia/1.json
  def show
  end

  # GET /materia/new
  def new
    @materium = Materium.new
  end

  # GET /materia/1/edit
  def edit
  end

  # POST /materia or /materia.json
  def create
    @materium = Materium.new(materium_params)

    respond_to do |format|
      if @materium.save
        format.html { redirect_to @materium, notice: "Materium was successfully created." }
        format.json { render :show, status: :created, location: @materium }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @materium.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /materia/1 or /materia/1.json
  def update
    respond_to do |format|
      if @materium.update(materium_params)
        format.html { redirect_to @materium, notice: "Materium was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @materium }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @materium.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /materia/1 or /materia/1.json
  def destroy
    @materium.destroy!

    respond_to do |format|
      format.html { redirect_to materia_path, notice: "Materium was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materium
      @materium = Materium.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def materium_params
      params.expect(materium: [ :Nome, :Codigo, :Semestre, :idDepartamento ])
    end
end
