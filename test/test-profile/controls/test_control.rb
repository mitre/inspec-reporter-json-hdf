# copyright: 2018, The Authors

control 'test-control-1' do
  title 'Test with a single PASS. Non Expired Attestation'
  describe true do
    it { should be true }
  end
end

control 'test-control-2' do
  title 'Test with a multiple PASS. Non Expired Attestation'
  describe true do
    it { should be true }
  end
  describe false do
    it { should be false }
  end
end

control 'test-control-3' do
  title 'Test with a single FAIL. Non Expired Attestation'
  describe true do
    it { should be false }
  end
end

control 'test-control-4' do
  title 'Test with a multiple FAIL. Non Expired Attestation'
  describe true do
    it { should be false }
  end
  describe false do
    it { should be true }
  end
end

control 'test-control-5' do
  title 'Test with a single SKIP. Non Expired Attestation'
  describe 'Manual Test' do
    skip 'Manual Test'
  end
end

control 'test-control-6' do
  title 'Test with a multiple SKIP. Non Expired Attestation'
  describe 'Manual Test1' do
    skip 'Manual Test2'
  end
  describe 'Manual Test2' do
    skip 'Manual Test2'
  end
end

control 'test-control-7' do
  title 'Test with a mixed statuses. Non Expired Attestation'
  describe 'Manual Test' do
    skip 'Manual Test'
  end
  describe true do
    it { should be true }
  end
  describe true do
    it { should be false }
  end
end

control 'test-control-8' do
  title 'Test with a no statuses. Non Expired Attestation'
end

control 'test-control-9' do
  title 'Test with a single PASS. Expired Attestation'
  describe true do
    it { should be true }
  end
end

control 'test-control-10' do
  title 'Test with a multiple PASS. Expired Attestation'
  describe true do
    it { should be true }
  end
  describe false do
    it { should be false }
  end
end

control 'test-control-11' do
  title 'Test with a single FAIL. Expired Attestation'
  describe true do
    it { should be false }
  end
end

control 'test-control-12' do
  title 'Test with a multiple FAIL. Expired Attestation'
  describe true do
    it { should be false }
  end
  describe false do
    it { should be true }
  end
end

control 'test-control-13' do
  title 'Test with a single SKIP. Expired Attestation'
  describe 'Manual Test' do
    skip 'Manual Test'
  end
end

control 'test-control-14' do
  title 'Test with a multiple SKIP. Expired Attestation'
  describe 'Manual Test1' do
    skip 'Manual Test2'
  end
  describe 'Manual Test2' do
    skip 'Manual Test2'
  end
end

control 'test-control-15' do
  title 'Test with a mixed statuses. Expired Attestation'
  describe 'Manual Test' do
    skip 'Manual Test'
  end
  describe true do
    it { should be true }
  end
  describe true do
    it { should be false }
  end
end

control 'test-control-16' do
  title 'Test with a no statuses. Expired Attestation'
end


