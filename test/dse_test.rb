require 'test_helper'

class DseTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil Dse::VERSION
  end

  def test_can_read_default_cipher_constant
    assert_equal(Dse::DEFAULT_CIPHER, "aes-256-cbc")
  end

  def test_fails_on_invalid_cipher
    assert_raises(RuntimeError) { Dse.encrypt("This should fail", "123", "non existant cipher type") }
  end

  def test_can_encypt_and_decrypt
    encrypted_data = Dse.encrypt("A test message", "password123")
    decrypted_data = Dse.decrypt(encrypted_data, "password123")
    assert_equal("A test message", decrypted_data)
  end

end
