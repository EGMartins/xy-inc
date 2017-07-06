class TestesController < ApplicationController
	before_action :set_teste, only: [:show, :edit, :update, :destroy]
	respond_to :json

	def index
		@testes = Teste.all
		respond_with @testes
	end

	def show
		respond_with @teste
	end

	def new
		@teste = Teste.new
		respond_with @teste
	end

	def edit
		respond_with @teste
	end

	def create
		@teste = Teste.new(teste_params)
		flash[:notice]='teste created!' if @teste.save
		respond_with @teste
	end

	 def update
		flash[:notice]='teste updated!'if @teste.update(teste_params)
		respond_with @teste
	end

	 def destroy
		@teste.destroy
		respond_with @teste
	end

 private

	def set_teste
		@teste = Teste.find(params[:id])
	end

	def teste_params
		params.require(:teste).permit(  )
	end

end