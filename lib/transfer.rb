require 'pry'
class Transfer
  # your code here
  attr_accessor :sender, :receiver, :status, :amount 

  def initialize(sender, receiver, status = "pending", amount)
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end

  def valid? 
    if sender.valid? && receiver.valid? && @status != "complete" && sender.balance > @amount
      true 
    else
      false
    end
  end

  def execute_transaction
    
    if self.valid? 
      @sender.deposit(@amount * -1) 
      @receiver.deposit(@amount)
      @status = "complete" 
      
  
    elsif @status == "complete"
      return "Transaction was already excuted"
      
    elsif @sender.balance < @amount
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    
    elsif @sender.status != "open" || @receiver.status != "open"
      @status = "rejected"
      #binding.pry
      return "Transaction rejected. Please check your account balance."
      

    end

    
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit( @amount ) 
      @receiver.deposit( @amount * -1)
      @status = "reversed"
    end
  end
end
