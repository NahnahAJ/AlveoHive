every 1.day, at: '4:30 am' do
    runner "SubscriptionWorker.perform_async"
  end
  