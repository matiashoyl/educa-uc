class StatisticsController < ApplicationController

  def index
  end

  def center_comparison
    @schools = School.all
    @scales = Scale.all

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @schools }
    end
  end

  def room_comparison_one
    @schools = School.all
    @scales = Scale.all
    @items = Item.all.map { |i| [i.id, "#{i.name} - #{i.subscale.scale.name}"] }
    @rooms = []
    
    Evaluation.where(:school_id => @schools.first).each do |eval|
      @rooms << eval.room
    end

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @schools }
    end
  end

  def update_rooms
    @rooms = []
    Evaluation.where(:school_id => params[:school_id]).each do |eval|
      @rooms << eval.room
    end
    
    respond_to do |format|
      format.js { @rooms }
    end
  end

  # Grafico center_comparison
  def show_graphic_one
    @chart = LazyHighCharts::HighChart.new('bar') do |f|
      
      params[:school][:school_id].each do |school|
        if !school.empty?
          s = School.find(school)
          f.series(:name => s.name,:data=> s.get_average(params[:theme].to_i))
          f.title({:text=>"Comparacion entre centros"})
        end
      end

      f.options[:chart][:defaultSeriesType]="column"
    end

    respond_to do |format|
      format.js { render 'show_graphic'}
    end
  end

  # Grafico mismo establecimiento
  def show_graphic_two
    @chart = LazyHighCharts::HighChart.new('bar') do |f|

      params[:room][:school_id].each do |room|
        if !room.empty?
          s=Evaluation.where(:school_id => params[:school][:school_id], :room => room)
          f.series(:name=>room,:data=> get_item_score_by_room(params[:school][:school_id], room, params[:item][:school_id]))
          f.title({:text=>"Comparacion entre centros"})
        end
      end

        f.options[:chart][:defaultSeriesType]="column"
    end

    respond_to do |format|
      format.js { render 'show_graphic'}
    end
  end

  def get_item_score_by_room(school, room, item)
    @item_scores = []
    @item = Item.find(item)
    evaluations = []
      
    evaluations << Evaluation.where(:school_id => school, :room => room).first
    
    evaluations.each do |e|
      @item_scores << e.get_item_score(@item)
    end
    return @item_scores
  end

end
