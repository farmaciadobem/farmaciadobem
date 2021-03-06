class EnderecosController < ApplicationController
  before_action :carrega_usuario
  before_action :set_endereco, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /enderecos
  # GET /enderecos.json
  def index
    @enderecos = Endereco.all
  end

  # GET /enderecos/1
  # GET /enderecos/1.json
  def show
    begin
      @endereco = Endereco.find(params[:id])
      if @endereco.user_id == current_user.id || @user.admin?
        respond_to do |format|
          format.html # show.html.erb
          format.json { render :show, status: :created, location: @endereco }
        end
      else
        respond_to do |format|
          format.html { redirect_to home_index_path}
          format.json { render :show, status: :created, location: home_index_path }
        end
      end
    end
  end

  # GET /enderecos/new
  def new
    @endereco = Endereco.new
  end

  # GET /enderecos/1/edit
  def edit
  end

  # POST /enderecos
  # POST /enderecos.json
  def create
    @endereco = Endereco.new(endereco_params)

    respond_to do |format|
      if @endereco.save
        format.html { redirect_to @endereco, notice: 'Endereco was successfully created.' }
        format.json { render :show, status: :created, location: @endereco }
      else
        format.html { render :new }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enderecos/1
  # PATCH/PUT /enderecos/1.json
  def update
    respond_to do |format|
      if @endereco.update(endereco_params)
        format.html { redirect_to @endereco, notice: 'Endereco was successfully updated.' }
        format.json { render :show, status: :ok, location: @endereco }
      else
        format.html { render :edit }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enderecos/1
  # DELETE /enderecos/1.json
  def destroy
    @endereco.destroy
    respond_to do |format|
      format.html { redirect_to enderecos_url, notice: 'Endereco was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endereco
      @endereco = Endereco.find(params[:id])
    end

    def carrega_usuario
      @user = User.find(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def endereco_params
      params.require(:endereco).permit(:nome, :rua, :numero, :bairro, :cidade, :estado, :cep, :user_id)
    end
end
