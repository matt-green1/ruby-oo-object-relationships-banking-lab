require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  @@all_transfers = []  


  def initialize(sender, receiver, status = 'pending', amount)
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount #transation amount
    @@all_transfers << self
  end

  def valid?
    # sender and receiver are instances of bank account here
    if self.sender.valid? && self.receiver.valid? 
      return true
     else
      return false
    end

  end

  
  def execute_transaction
    
    if @amount <= self.sender.balance && self.status == "pending" && self.valid?
      self.receiver.deposit(@amount)
      self.sender.balance -= @amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
    
    
  end

   def reverse_transfer
    last_transfer = @@all_transfers[-1]
    if last_transfer.status == "complete"
      last_transfer.receiver.balance -= @amount
      last_transfer.sender.deposit(@amount)
      last_transfer.status = "reversed"
      @@all_transfers.pop()
    end
   end

end

