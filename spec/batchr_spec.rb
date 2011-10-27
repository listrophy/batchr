require 'rspec'
require_relative '../lib/batchr'

class Receiver
  def self.message batch
  end
end

describe Batchr do
  describe '.batch' do

    it 'yields an instance of Batchr' do
      Batchr.batch(Receiver, :message) do |b|
        b.stub(:finish)
        b.should be_a(Batchr)
      end
    end

    it 'calls finish at the end of the block' do
      Batchr.batch(Receiver, :message) do |b|
        b.should_receive(:finish)
      end
    end

  end

  describe '#initialize' do
    context 'with batch_size opt' do
      it 'sets the batch_size' do
        Batchr.new(batch_size: 3).batch_size.should == 3
      end
    end
  end

  describe '#batch_size=' do
    let(:batchr) { Batchr.new }
    it 'sets the batch size' do
      batchr.stub(:run_if_necessary)
      batchr.batch_size = 2
      batchr.batch_size.should == 2
    end
    it 'calls run_if_necessary' do
      batchr.should_receive(:run_if_necessary).once
      batchr.batch_size = 2
    end
  end

  describe '#<<' do
    let(:batchr) { Batchr.new }
    it 'adds the element to the bucket' do
      batchr << :a
      batchr.bucket.should == [:a]
    end
    it 'calls run_if_necessary' do
      batchr.should_receive(:run_if_necessary)
      batchr << :foo
    end
  end

  describe '#run_if_necessary' do
    let(:batchr) { Batchr.new(batch_size: 1) }
    after { batchr.run_if_necessary }

    context 'buffered size is greater than batch_size' do
      it 'calls run_batch' do
        batchr.should_receive(:run_batch)
        batchr.instance_variable_set("@bucket", [:foo, :bar])
      end
    end

    context 'buffered size is equal to batch_size' do
      it 'calls run_batch' do
        batchr.should_receive(:run_batch)
        batchr.instance_variable_set("@bucket", [:foo])
      end
    end

    context 'buffered size is less than batch_size' do
      it 'does not call run_batch' do
        batchr.should_not_receive(:run_batch)
      end
    end

  end

  describe '#run_batch' do
    let(:batchr) { Batchr.new }
    before do
      batchr.receiver, batchr.message = Receiver, :message
      batchr.bucket.stub(empty?: empty_bucket)
    end
    context 'when bucket has something' do
      let(:empty_bucket) { false }
      it 'calls message on reciever with the bucket as an arg' do
        Receiver.should_receive(:message).with(batchr.bucket)
        batchr.run_batch
      end
      it 'empties the bucket' do
        batchr.run_batch
        batchr.bucket.should == []
      end
    end
    context 'when bucket is empty' do
      let(:empty_bucket) { true }
      it 'does not call message on receiver' do
        Receiver.should_not_receive(:message)
        batchr.run_batch
      end
    end
  end

  example 'batch_size = 2, elements = 2' do
    Receiver.should_receive(:message).with([:a, :b]).once
    Batchr.batch(Receiver, :message) do |batchr|
      batchr.batch_size = 2
      batchr << :a
      batchr << :b
      batchr.bucket.should == []
    end
  end

  example 'batch_size = 3, elements = 2' do
    Receiver.should_receive(:message).with([:a, :b]).once
    Batchr.batch(Receiver, :message) do |batchr|
      batchr.batch_size = 3
      batchr << :a
      batchr << :b
      batchr.bucket.should == [:a, :b]
    end
  end

end
