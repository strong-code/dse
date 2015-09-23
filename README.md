# Dse

Dead. Simple. Encryption.

A simple and lightweight library composed of only Ruby's OpenSSL and Base64 modules that allows
for quick and easy encryption and decryption of data.

## Why?
Similar gems had the issue of ommitting  the [initialization vector](http://ruby-doc.org/stdlib-2.0.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html#class-OpenSSL::Cipher-label-Choosing+an+IV)
which leaves you with either an A) unsecure cipher or B) having to go through the trouble of remembering both
your password _and_ your (hopefully random) IV. DSE solves this problem by generating a secure, random IV every time
`Dse.encrypt` is called and appending it to the ciphertext iteself. When `Dse.decrypt` is called, the IV is stripped
from the cipher text and used in the decryption. Thus, the user only has to worry about choosing a secure password and
the gem takes care of IV generation and storage for you.

## A note on secure passwords
Simply using a string of (unprocessed) characters is not a very secure password. A simple way to turn a
human-readable string into a secure password is by leveraging Ruby's OpenSSL::SHA256 module. This provides
a secure hashing algorithm for a provided plaintext password. Dse will automatically hash a plaintext password
using this algorithm. For more information on secure hashing and digests, see [this page](http://ruby-doc.org/stdlib-2.0.0/libdoc/openssl/rdoc/OpenSSL/Digest.html).

**Note** Dse uses SHA256 by default for password hashing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dse'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dse

## Usage

You can easily encrypt and decrypt data like so

```ruby
require 'dse'

data = "a super secret string of data"
password = "p4assw0rD"

# Encrypt and return the resulting ciphertext
ciphertext = Dse.encrypt(data, password) #=> #\xD9eS\xAE\x8C\x8FU\x81\nl:\xB7\xAE\x00\xDB\xE6+\xBA)\xB0\x1F\xB8|o\xA4G%8\xF3k|"

decrypted_data = Dse.decrypt(ciphertext, password) #=> "a super secret string of data"

data == decrypted_data #=> true
```

The main encryption method exposed is `Dse.encrypt(data, password [, cipher_type])` where `cipher_type` is
a string in the format of `name-keylength-mode`. The available cipher types depend on which version of
OpenSSL is installed on your machine. If nothing is provided for the optional `cipher_type` argument,
it will defualt to `aes-256-cbc`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clindsay107/dse.
