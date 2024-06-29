class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    if !params[:active].nil?
      if params[:active] == 'true'
        @active = true
      else
        @active = false
      end
    else
      @active = true
    end

    @people = Person.includes(:user).where(active: @active).paginate(page: params[:page]).order(id: :desc)
  end

  def search
    @people = Person.where(active: true).
      where("UPPER(name) LIKE ?", "#{params[:q].upcase}%").
      order(:name).
      limit(10)

    respond_to do |format|
      format.html { render :search, layout: false }
      format.json { render json: @people.to_json }
    end
  end

  def show
  end

  def new
    @person = Person.new active: true
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    @person.user = current_user

    respond_to do |format|
      if @person.save
        format.html { redirect_to person_url(@person), notice: "Criado com sucesso." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to person_url(@person), notice: "Atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy!

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Removido." }
      format.json { head :no_content }
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:name, :phone_number, :national_id, :active)
    end
end
