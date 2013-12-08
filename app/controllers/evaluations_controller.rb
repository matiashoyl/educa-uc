# encoding: utf-8

require 'data_file'

class EvaluationsController < ApplicationController
  # GET /evaluations
  # GET /evaluations.json
  def index
    @evaluations = Evaluation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @evaluations }
      format.xls
    end
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
    @evaluation = Evaluation.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/new
  # GET /evaluations/new.json
  def new
    @evaluation = Evaluation.new
    @scales = Scale.all
    @schools = School.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/1/edit
  def edit
    @evaluation = Evaluation.find(params[:id])
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = Evaluation.new(params[:evaluation])
    @evaluation.start_time = Time.now
    @evaluation.user = current_user

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to evaluate_path(@evaluation) }
        format.json { render json: @evaluation, status: :created, location: @evaluation }
      else
        format.html { render action: "new" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /evaluations/1
  # PUT /evaluations/1.json
  def update
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation = Evaluation.find(params[:id])
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to evaluations_url }
      format.json { head :no_content }
    end
  end

  def evaluate
    @evaluation = Evaluation.find(params[:id])
    #@evaluation = Evaluation.create(:school_id => params[:school][:school_id], :user_id => current_user.id)

    @subscales = Subscale.where(:scale_id => @evaluation.scale_id)
 

    respond_to do |format|
      format.html { render action: "evaluate" }
      format.json { head :no_content }
    end
  end

  def receive
    evaluation = Evaluation.find(params[:evaluation_id])
    evaluation.finish_time = Time.now
    evaluation.save
    if not params[:evaluation].nil?
      params[:evaluation].each do |indicator|
        Score.create(:evaluation_id => evaluation.id, :indicator_id => indicator[0],
          :value => indicator[1])  
      end
    end

    respond_to do |format|
      flash[:notice] = "Evaluation was successfully commited."
      format.html { redirect_to :action => "show", :id => params[:evaluation_id] }
      format.json { head :no_content }
    end
  end

  def generate_inform
    evaluation = Evaluation.find(params[:id])
    school = School.find(evaluation.school_id)
    month = t("month_names")[evaluation.created_at.month]
    year = evaluation.created_at.year
    scale = Scale.find(evaluation.scale_id)
    subscales = scale.subscales
    subscales_scores = [] 
    subscales.each do |subscale|
      evaluation.get_subscale_score(subscale)
    end
    total_score = evaluation.get_total_score

     File.open("public/Informe.xml","w+"){|f| f.write(evaluation.get_xml)}



     mime_type = 
      "application/vnd.openxmlformats-
      officedocument.wordprocessingml.document"
    

    DataFile.save(school, month, year, subscales_scores, total_score)
    
    # Send the new file with the wordprocessingml document
    # content type.
    send_file("public/resources/newdoc.docx",
      :filename=> "newdoc.docx",
      :type=>mime_type)
  end

  def write_xml
    "<?xml version='1.0' encoding='UTF-8'?>
<Center>
  <name>Establecimiento 1</name>
  <month>Junio</month>
  <inform_year>2013</inform_year>
  <year>2000</year>
  <director>Pedro Perez</director>
  <Subscale name='Espacio y Muebles'>
      <Score>1</Score>
  </Subscale>
  <Subscale name='Rutinas de cuidado personal'>
      <Score>2</Score>
  </Subscale>
  <Subscale name='Escuchar y hablar  / Lenguaje y razonamiento'>
      <Score>3</Score>
  </Subscale>
  <Subscale name='Actividades'>
      <Score>4</Score>
  </Subscale>
  <Subscale name='Interacción'>
      <Score>5</Score>
  </Subscale>
  <Subscale name='Estructura del programa'>
      <Score>6</Score>
  </Subscale>
  <Subscale name='Padres y personal'>
      <Score>7</Score>
  </Subscale>
  <TotalScore>4</TotalScore>
  <Room>
    <Name>Sala 1</Name>
    <Level>Nivel 1</Level>
    <Date>24/06/2013</Date>
    <Duration>Medio Dia</Duration>
    <Adults>5</Adults>
    <Kids>30</Kids>
    <MKids>20</MKids>
    <Capacity>40</Capacity>
    <Scale>ITERS-C</Scale>
      <Subscale name='Espacio y Muebles'>
        <Score>1</Score>
      </Subscale>
      <Subscale name='Rutinas de cuidado personal'>
        <Score>2</Score>
      </Subscale>
      <Subscale name='Escuchar y hablar  / Lenguaje y razonamiento'>
        <Score>3</Score>
      </Subscale>
      <Subscale name='Actividades'>
        <Score>4</Score>
      </Subscale>
      <Subscale name='Interacción'>
        <Score>5</Score>
      </Subscale>
      <Subscale name='Estructura del programa'>
        <Score>6</Score>
      </Subscale>
      <Subscale name='Padres y personal'>
        <Score>7</Score>
      </Subscale>
      <TotalScore>40</TotalScore>
  </Room>
  <Room>
    <Name>Sala 2</Name>
    <Level>Nivel 1</Level>
    <Date>24/06/2013</Date>
    <Duration>Medio Dia</Duration>
    <Adults>5</Adults>
    <Kids>30</Kids>
    <MKids>20</MKids>
    <Capacity>40</Capacity>
    <Scale>ITERS-C</Scale>
      <Subscale name='Espacio y Muebles'>
        <Score>1</Score>
            <Item_greater_than_three>
              <Name>Item 1</Name>
              <Score>4</Score>
            </Item_greater_than_three>
            <Item_greater_than_three>
              <Name>Item 2</Name>
              <Score>4</Score>
            </Item_greater_than_three>
            <Item_greater_than_three>
              <Name>Item 3</Name>
              <Score>4</Score>
              <Indicators>
                <Indicator>
                  <Name>Indicador 1</Name>
                </Indicator>
                <Indicator>
                  <Name>Indicador 2</Name>
                </Indicator>
                <Indicator>
                  <Name>Indicador 3</Name>
                </Indicator>
              </Indicators>
            </Item_greater_than_three>
      </Subscale>
      <Subscale name='Rutinas de cuidado personal'>
        <Score>2</Score>
      </Subscale>
      <Subscale name='Escuchar y hablar  / Lenguaje y razonamiento'>
        <Score>3</Score>
      </Subscale>
      <Subscale name='Actividades'>
        <Score>4</Score>
      </Subscale>
      <Subscale name='Interacción'>
        <Score>5</Score>
      </Subscale>
      <Subscale name='Estructura del programa'>
        <Score>6</Score>
      </Subscale>
      <Subscale name='Padres y personal'>
        <Score>7</Score>
      </Subscale>
      <TotalScore>40</TotalScore>
  </Room>
</Center>"
  end
end
