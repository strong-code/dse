require 'test_helper'

class DSETest < Minitest::Test

  def test_can_read_default_cipher_constant
    assert_equal(Keyshare::DSE::DEFAULT_CIPHER, "aes-256-cbc")
  end

  def test_fails_on_invalid_cipher
    assert_raises(RuntimeError) { Keyshare::DSE.encrypt("This should fail", "123", "non existant cipher type") }
  end

  def test_can_encypt_and_decrypt
    encrypted_data = Keyshare::DSE.encrypt("A test message", "password123")
    decrypted_data = Keyshare::DSE.decrypt(encrypted_data, "password123")
    assert_equal("A test message", decrypted_data)
  end

end
