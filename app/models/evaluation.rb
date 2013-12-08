# encoding: utf-8

class Evaluation < ActiveRecord::Base
  attr_accessible :user_id, :school_id, :scale_id, :personal_members_present, :number_kids, 
  :max_number_kids, :evaluation_date, :number_kids_disability, :physical_disability, 
  :cognitive_disability, :social_disability, :other_disability, :min_birth_date, :max_birth_date, 
  :start_time, :room, :total_score

  belongs_to :user
  belongs_to :school
  belongs_to :scale
  has_many :scores
  has_many :item_evaluations
  has_many :subscale_evaluations

  validates :user_id, :presence => true
  validates :school_id, :presence => true
  validates :personal_members_present, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :number_kids, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :max_number_kids, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :number_kids_disability, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_score, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :scale_id, :presence => true
  validates :evaluation_date, :presence => true
  validates_date :evaluation_date, :after => Date.new(1913,1,1)
  validates :min_birth_date, :presence => true
  validates_date :min_birth_date, :after => Date.new(1913,1,1)
  validates :max_birth_date, :presence => true
  validates_date :max_birth_date, :after => :min_birth_date
  validates :start_time, :presence => true
  validates_date :start_time, :after => Date.new(1913,1,1)
  validates :room, :presence => true
  validates :start_time, :presence => true
  validates :number_kids_disability, :numericality => {:less_than_or_equal_to => :number_kids}

  def get_item_score(item)
    if ItemEvaluation.where(:evaluation_id => self, :item_id => item.id).first.nil?
      result = ItemEvaluation.new(evaluation_id: self.id, item_id: item.id, item_score: 0)
    else
      return ItemEvaluation.where(:evaluation_id => self, :item_id => item.id).first.item_score
    end

  	item.columns.each do |column|
  		if (column.id % 4) == 1
  			true_value = Indicator.includes(:column, :score).where('scores.evaluation_id' => self.id, 'scores.value' => false, 'columns.id' => column.id )
  			if true_value.count == column.indicators.count
  				result.item_score += 1
  			end
  		else
  			true_value = Indicator.includes(:column, :score).where('scores.evaluation_id' => self.id, 'scores.value' => true, 'columns.id' => column.id )
  			if true_value.count == column.indicators.count
  				result.item_score += 2
  			elsif true_value.count >= column.indicators.count
  				result.item_score += 1
  				break	
  			end
  		end
  	end

  	result.save
    result.item_score
  end

  def get_avrg_subscale_score(subscale)
    result = 0
    Evaluation.where(:school_id => self.school_id).each do |e|
      result += e.get_subscale_score(subscale)
    end
    return result.to_f / Evaluation.where(:school_id => self.school_id).count.to_f
  end

  def get_avrg_total
    result = 0
    Subscale.all.each do |subscale|
      result += get_avrg_subscale_score(subscale)
    end
    return result
  end

  def get_subscale_score(subscale)
  	if SubscaleEvaluation.where(:evaluation_id => self, :subscale_id => subscale.id).first.nil?
      result = SubscaleEvaluation.new(evaluation_id: self.id, subscale_id: subscale.id, subscale_score: 0)
    else
      return SubscaleEvaluation.where(:evaluation_id => self, :subscale_id => subscale.id).first.subscale_score
    end
  	Item.where(:subscale_id => subscale.id).all.each do |item|
  		result.subscale_score += get_item_score(item)
  	end

    result.save
    result.subscale_score
  end

  def get_total_score
    if !self.total_score.nil?
      return self.total_score
    end
  	total_score = 0
  	Subscale.all.each do |subscale|
  		total_score += get_subscale_score(subscale)
  	end

  	self.save
  	total_score
  end

  def items_with_over_3
  	result = []
  	Item.all.each do |item|
  		if get_item_score(item) >= 3
  			result << item
  		end
  	end
  	result
  end

  def items_with_less_3
  	result = []
  	Item.all.each do |item|
  		if get_item_score(item) < 3
  			result << item
  		end
  	end
  	result
  end

  def get_xml

    xml = "<Center>
     <name>#{ self.school.name }</name>
     <month>"+ I18n.t("month_names")[Time.now.month]+"</month>
     <inform_year>#{ Time.now.year }</inform_year>
     <year>#{ self.school.created_at.year }</year>
     <director>#{ self.school.director }</director>" 
     Subscale.all.each do |subscale|
      xml += "
        <Subscale name='#{subscale.name} - #{subscale.scale.name}'>
         <Score>#{ self.get_avrg_subscale_score(subscale) }</Score>
     </Subscale>
      "
     end

     xml += "
     <TotalScore>#{ self.get_avrg_total }</TotalScore>
     "

     Evaluation.where(:school_id => self.school_id).each do |e|
      xml += "
      <Room>
       <Name>#{ e.room }</Name>
       <Level> NN </Level>
       <Date>#{ e.evaluation_date }</Date>
       <Adults> NN </Adults>
       <Kids>#{ e.number_kids }</Kids>
       <MKids> NN </MKids>
       <Capacity>#{ e.max_number_kids }</Capacity>
       <Scale>#{ e.scale.name }</Scale>
         <Subscale name='Espacio y Muebles'>
           <Score>#{ e.get_subscale_score(Subscale.where('name LIKE ?', '%espacio y mueble%' ).first) }</Score>
         </Subscale>
         <Subscale name='Rutinas de cuidado personal'>
           <Score>#{ e.get_subscale_score(Subscale.where('name LIKE ?', '%rutinas de cuidado personal%' ).first) }</Score>
         </Subscale>
         <Subscale name='Escuchar y hablar  / Lenguaje y razonamiento'>
           <Score>#{ e.get_subscale_score(Subscale.where('name LIKE ?', '%escuchar y hablar%' ).first) }</Score>
         </Subscale>
         <Subscale name='Actividades'>
           <Score>#{ e.get_subscale_score(Subscale.where('name LIKE ?', '%actividades%' ).first) }</Score>
         </Subscale>
         <Subscale name='Interacción'>
           <Score>#{ e.get_subscale_score(Subscale.where('name LIKE ?', '%interac%' ).first) }</Score>
         </Subscale>
         <Subscale name='Estructura del programa'>
           <Score>#{ e.get_subscale_score(Subscale.where('name LIKE ?', '%estructura del programa%' ).first) }</Score>
         </Subscale>
         <Subscale name='Padres y personal'>
           <Score>#{ e.get_subscale_score(Subscale.where('name LIKE ?', '%padres%' ).first) }</Score>
         </Subscale>
       <TotalScore>#{ e.get_total_score }</TotalScore>
       </Room>"
     end

       
     xml += "</Center>"

    return xml
  end

end
