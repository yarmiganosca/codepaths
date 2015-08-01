require_relative 'consumed'

class Consumer
  def a
    consumed.a
    consumed.b
  end

  def c
    consumed.c
    consumed.d
  end

  private

  def consumed
    Consumed.new
  end
end
