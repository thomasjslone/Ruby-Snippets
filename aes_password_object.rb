require 'openssl'
class Password
  def initialize(string, seed)
    @seed = seed
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key = Digest::SHA256.digest(@seed)
    @password = cipher.update(string) + cipher.final
  end
  
  def verify(pass)
    cipher = OpenSSL::Cipher.new('AES-256-CBC')
    cipher.encrypt
    cipher.key = Digest::SHA256.digest(@seed)
    encrypted = cipher.update(pass) + cipher.final
    @password == encrypted
  end
end
