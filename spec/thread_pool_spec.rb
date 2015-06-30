require 'spec_helper'

describe ThreadPool do
  let(:mock_thread) do
    Struct.new(:name) do
      def new
        yield
        self
      end

      def join
      end
    end.new("MockThread")
  end

  it 'runs a thread' do
    call_count = 0
    tasks = [lambda {call_count += 1}]
    expect(mock_thread).to receive(:new).and_call_original
    thread_pool = described_class.new(tasks, 1, mock_thread)

    thread_pool.execute

    expect(call_count).to eq(1)
  end

  it 'runs only up to the thread limit at one time, reusing the threads' do
    call_count = 0
    tasks = [
      lambda {call_count += 1},
      lambda {call_count += 1}
    ]

    expect(mock_thread).to receive(:new).twice.and_call_original
    thread_pool = described_class.new(tasks, 2, mock_thread)

    thread_pool.execute

    expect(call_count).to eq(2)
  end

  def assert_threadsafe(queue)
    expect(queue).to be_a(Queue)
  end

  it 'executes the next task when threads free up in a threadsafe manner' do
    call_count = 0
    tasks = [
      lambda {call_count += 1},
      lambda {call_count += 1},
      lambda {call_count += 1},
      lambda {call_count += 1},
      lambda {call_count += 1},
      lambda {call_count += 1}
    ]

    expect(mock_thread).to receive(:new).twice.and_call_original

    thread_pool = described_class.new(tasks, 2, mock_thread)
    thread_pool.execute

    expect(call_count).to eq(6)
    assert_threadsafe(thread_pool.queue)
  end
end

