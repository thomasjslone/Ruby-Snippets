class Simpleton_Cipher
  def initialize ; @chset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,./;'[]-=<>?:\"{}_+)(|\\*&^%$#@!~` 	\n" ; end
  def generate_key ;  key = @chset ; key = key.split('').shuffle.join('').to_s ; key ; end
  def encode(str,key) ; str.tr(@chset, key) ; end
  def decode(str,key) ; str.tr(key, @chset) ; end
end