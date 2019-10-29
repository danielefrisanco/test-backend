class ListaDeTareasController < ApplicationController
  before_action :set_lista_de_tarea, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"],
                               password: ENV["HTTP_BASIC_PASSWORD"],
                               if: -> { ENV["HTTP_BASIC_USER"].present?},
                               only: :lista_de_tareas_with_statuses

  # GET /lista_de_tareas
  # GET /lista_de_tareas.json
  def index
    @lista_de_tareas_pasadas,
    @lista_de_tareas_pendientes,
    @lista_de_tareas_futuras = ListaDeTarea.by_status
  end

  # GET /lista_de_tareas/1
  # GET /lista_de_tareas/1.json
  def show
  end

  # GET /lista_de_tareas/new
  def new
    @lista_de_tarea = ListaDeTarea.new
  end

  # GET /lista_de_tareas/1/edit
  def edit
  end

  # POST /lista_de_tareas
  # POST /lista_de_tareas.json
  def create
    @lista_de_tarea = ListaDeTarea.new(lista_de_tarea_params)

    respond_to do |format|
      if @lista_de_tarea.save
        format.html { redirect_to @lista_de_tarea,
                      notice: 'Lista de tarea was successfully created.' }
        format.json { render :show, status: :created, location: @lista_de_tarea }
      else
        format.html { render :new }
        format.json { render json: @lista_de_tarea.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lista_de_tareas/1
  # PATCH/PUT /lista_de_tareas/1.json
  def update
    respond_to do |format|
      if @lista_de_tarea.update(lista_de_tarea_params)
        format.html { redirect_to @lista_de_tarea,
                      notice: 'Lista de tarea was successfully updated.' }
        format.json { render :show, status: :ok, location: @lista_de_tarea }
      else
        format.html { render :edit }
        format.json { render json: @lista_de_tarea.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lista_de_tareas/1
  # DELETE /lista_de_tareas/1.json
  def destroy
    @lista_de_tarea.destroy
    respond_to do |format|
      format.html { redirect_to lista_de_tareas_url,
                    notice: 'Lista de tarea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /lista_de_tareas_with_statuses/
  def lista_de_tareas_with_statuses
    @lista_de_tareas_with_statuses = ListaDeTarea.all(&:json_with_status)
    respond_to do |format|
       format.json { render json: @lista_de_tareas_with_statuses,
                     status: :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lista_de_tarea
    @lista_de_tarea = ListaDeTarea.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def lista_de_tarea_params
    params.require(:lista_de_tarea)
          .permit(:titulo, :fecha_de_inicio, :fecha_de_fin, :correo)
  end
end
