class TaxiMeter
  attr_accessor :miles_driven
  attr_accessor :start_time
  attr_accessor :stop_time

  def initialize(airport:false)
    @amount_due = 0
    @miles_driven = 0
    @start_time = nil
    @stop_time = nil
    @airport = airport
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
  end

  attr_reader :amount_due
  def amount_due
    if @miles_driven==0
      @miles_driven = 0
      @amount_due = 0
    elsif @miles_driven <= 1.0/6.0
      @miles_driven=miles_driven
      @amount_due=250
    else @miles_driven > 1.0/6.0
      @amount_due = ((2.10 + (miles_driven*6).ceil*0.40)*100).round(0)
    end
    @amount_due += (((29.00/60)*(Time.now-@start_time)/60)*100).round(0)
    if @start_time.hour >= 21 || @start_time.hour < 4
      @amount_due += 100
    end
    if @airport==true && @amount_due < 1310
      @amount_due=1310
    end

    return @amount_due
  end
end
