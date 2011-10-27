class Batchr

  attr_reader :batch_size, :bucket
  attr_accessor :receiver, :message

  def self.batch receiver, message
    batchr = new
    batchr.receiver = receiver
    batchr.message = message
    yield batchr
    batchr.finish
  end

  def initialize opts = {}
    @batch_size = opts[:batch_size] ? opts[:batch_size] : 400
    @bucket = []
  end

  def batch_size= value
    @batch_size = value
    run_if_necessary
  end

  def << value
    @bucket << value
    run_if_necessary
  end

  def run_if_necessary
    run_batch if @bucket.size >= @batch_size
  end

  def empty_bucket
    @bucket = []
  end

  def run_batch
    unless bucket.empty?
      receiver.send(message, bucket)
      empty_bucket
    end
  end
  alias_method :finish, :run_batch

end
