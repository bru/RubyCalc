#
#  RubyCalcDelegate.rb
#  RubyCalc
#
#  Created by Riccardo Cambiassi on 03/07/2010.
#  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
#

class RubyCalcDelegate
  attr_accessor :display, :plus, :minus, :multiply, :divide
  
  def applicationDidFinishLaunching(notification)
    NSLog("launching finished!")
    @display.stringValue = 0
    @buffer = 0;
    @rightOp = 0;
    @operator = nil
  end
  
  def addDigit(sender)
    NSLog("add Digit #{sender.title}")
    digit = sender.title
    current = display.stringValue
    if (current == "0" && digit != "0")
      current = digit
    else
      current += digit
    end
    
    @rightOp = current.floatValue
    display.stringValue = current
  end
  
  def setOperator(sender)
    NSLog("set operator #{sender.title}")
    @buffer = display.floatValue
    display.stringValue = "0"
    @operator = sender.title
    
    clearButtons
    sender.setState NSOnState
  end
  
  def clear(sender)
    NSLog("clear display")
    @buffer = @rightOp = 0
    @operator = nil
    
    clearButtons
    display.stringValue = "0"
  end
  
  def unaryOperator(sender)
    NSLog("unary operator #{sender.title}")
    setOperator sender
    result sender
  end
  
  def result(sender)
    NSLog("calculate results")
    case @operator
    when "+"
      value = @buffer + @rightOp
    when "-"
      value = @buffer - @rightOp
    when "*"
      value = @buffer * @rightOp
    when "/"
      value = @buffer / @rightOp
    else
      value = -1 * @buffer
    end
    
    @buffer = value
    display.stringValue = value.to_s
  end
  
  private
  
  def clearButtons
    [plus, minus, multiply, divide].each do |button|
      button.setState NSOffState
    end
  end
  
end
