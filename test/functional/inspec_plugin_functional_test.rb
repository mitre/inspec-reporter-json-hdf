require_relative 'test_helper'

class InspecPluginFunctionalTest < Minitest::Test
  def test_with_a_single_pass_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][0]['results'][0]['status'])
    assert_match(%r(Automated test returned as passed.\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][0]['results'][0]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][0]['attestation'])
  end


  def test_with_a_multiple_pass_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][1]['results'][0]['status'])
    assert_equal('passed', hdf_json['profiles'][0]['controls'][1]['results'][1]['status'])
    assert_match(%r(Automated test returned as passed.\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][1]['results'][0]['message'])
    assert_match(%r(Automated test returned as passed.\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][1]['results'][1]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][1]['attestation'])
  end

  def test_with_a_single_fail_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][2]['results'][0]['status'])
    assert_match(%r(\nexpected false\n     got true\n\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][2]['results'][0]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][2]['attestation'])
  end

  def test_with_a_multiple_fail_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][3]['results'][0]['status'])
    assert_equal('passed', hdf_json['profiles'][0]['controls'][3]['results'][1]['status'])
    assert_match(%r(\nexpected false\n     got true\n\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][3]['results'][0]['message'])
    assert_match(%r(\nexpected true\n     got false\n\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][3]['results'][1]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][3]['attestation'])
  end

  def test_with_a_single_skip_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][4]['results'][0]['status'])
    assert_match(%r(Manual Test\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][4]['results'][0]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][4]['attestation'])
  end
  def test_with_a_multiple_skip_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][5]['results'][0]['status'])
    assert_equal('passed', hdf_json['profiles'][0]['controls'][5]['results'][1]['status'])
    assert_match(%r(Manual Test2\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][5]['results'][0]['message'])
    assert_match(%r(Manual Test2\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][5]['results'][1]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][5]['attestation'])
  end
  def test_with_a_mixed_statuses_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][6]['results'][0]['status'])
    assert_equal('passed', hdf_json['profiles'][0]['controls'][6]['results'][1]['status'])
    assert_equal('passed', hdf_json['profiles'][0]['controls'][6]['results'][2]['status'])
    assert_match(%r(Manual Test\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][6]['results'][0]['message'])
    assert_match(%r(Automated test returned as passed.\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][6]['results'][1]['message'])
    assert_match(%r(\nexpected false\n     got true\n\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][6]['results'][2]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][6]['attestation'])
  end
  def test_with_a_no_statuses_non_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][7]['results'][0]['status'])
    assert_match(%r(\n       Attestation:\n       Status: passed\n       Explanation: Non-expired Status passed\n), hdf_json['profiles'][0]['controls'][7]['results'][0]['message'])
    refute_nil(hdf_json['profiles'][0]['controls'][7]['attestation'])
  end
  def test_with_a_single_pass_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][8]['results'][0]['status'])
    refute_nil(hdf_json['profiles'][0]['controls'][8]['attestation'])
  end
  def test_with_a_multiple_pass_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('passed', hdf_json['profiles'][0]['controls'][9]['results'][0]['status'])
    assert_equal('passed', hdf_json['profiles'][0]['controls'][9]['results'][1]['status'])
    refute_nil(hdf_json['profiles'][0]['controls'][9]['attestation'])
  end
  def test_with_a_single_fail_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('failed', hdf_json['profiles'][0]['controls'][10]['results'][0]['status'])
    refute_nil(hdf_json['profiles'][0]['controls'][10]['attestation'])
  end
  def test_with_a_multiple_fail_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('failed', hdf_json['profiles'][0]['controls'][11]['results'][0]['status'])
    assert_equal('failed', hdf_json['profiles'][0]['controls'][11]['results'][1]['status'])
    refute_nil(hdf_json['profiles'][0]['controls'][11]['attestation'])
  end
  def test_with_a_single_skip_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('skipped', hdf_json['profiles'][0]['controls'][12]['results'][0]['status'])
    refute_nil(hdf_json['profiles'][0]['controls'][12]['attestation'])
  end
  def test_with_a_multiple_skip_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('skipped', hdf_json['profiles'][0]['controls'][13]['results'][0]['status'])
    assert_equal('skipped', hdf_json['profiles'][0]['controls'][13]['results'][1]['status'])
    refute_nil(hdf_json['profiles'][0]['controls'][12]['attestation'])
  end
  def test_with_a_mixed_statuses_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_equal('skipped', hdf_json['profiles'][0]['controls'][14]['results'][0]['status'])
    assert_equal('passed', hdf_json['profiles'][0]['controls'][14]['results'][1]['status'])
    assert_equal('failed', hdf_json['profiles'][0]['controls'][14]['results'][2]['status'])
    refute_nil(hdf_json['profiles'][0]['controls'][14]['attestation'])
  end
  def test_with_a_no_statuses_expired_attestation
    hdf_json = JSON.parse(File.read('test_hdf.json'))
    assert_empty(hdf_json['profiles'][0]['controls'][15]['results'])
    refute_nil(hdf_json['profiles'][0]['controls'][15]['attestation'])
  end
end
