#include "PacketEncryption.h"
#include "Packet.h"

namespace dbc
{

void WritePacketSequenceEncrypted(WPacket& wpk, const AES_KEY& aes_key, uint8_t seq[], size_t seq_len)
{
  std::unique_ptr<Botan::Cipher_Mode> aes_encryptor = Botan::Cipher_Mode::create(
	  "AES-128/CBC/PKCS7", Botan::ENCRYPTION);
  Botan::AutoSeeded_RNG		  rng;
  Botan::InitializationVector iv(rng, AES_IV_LENGTH);

  aes_encryptor->set_key(aes_key, AES_KEY_LENGTH);
  aes_encryptor->start(iv.bits_of());
  Botan::secure_vector<uint8_t> cipher(seq, seq + seq_len);
  aes_encryptor->finish(cipher);

  // Send AES-encrypted password.
  wpk.WriteSequence((cChar*)cipher.data(), cipher.size());
  // Send IV.
  wpk.WriteSequence((cChar*)iv.bits_of().data(), iv.bits_of().size());
}

Botan::secure_vector<uint8_t> ReadPacketSequenceEncrypted(RPacket& rpk, const AES_KEY& aes_key)
{
  std::unique_ptr<Botan::Cipher_Mode> aes_decryptor = Botan::Cipher_Mode::create(
	  "AES-128/CBC/PKCS7", Botan::DECRYPTION);
  Botan::AutoSeeded_RNG rng;

  AES_IV						iv;
  uShort						ivLen;
  uShort						cipherLen;
  cChar*						cipherptr = rpk.ReadSequence(cipherLen);
  Botan::secure_vector<uint8_t> plaintext(cipherptr, cipherptr + cipherLen);
  memcpy(iv, rpk.ReadSequence(ivLen), AES_IV_LENGTH);

  aes_decryptor->set_key(aes_key, AES_KEY_LENGTH);
  aes_decryptor->start(iv, AES_IV_LENGTH);
  aes_decryptor->finish(plaintext);
  return plaintext;
}

} // namespace dbc