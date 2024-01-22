#pragma once
#include <botan/auto_rng.h>
#include <botan/pkcs8.h>
#include <botan/x509_key.h>
#include <botan/rsa.h>
#include <botan/pubkey.h>
#include <botan/botan.h>
#include <botan/aes.h>
#include <botan/cipher_mode.h>
#include <botan/data_src.h>

namespace dbc
{
class WPacket;
class RPacket;

constexpr auto AES_KEY_LENGTH{128 / 8};
constexpr auto AES_IV_LENGTH{128 / 8};
using AES_KEY = uint8_t[AES_KEY_LENGTH];
using AES_IV = uint8_t[AES_IV_LENGTH];


void WritePacketSequenceEncrypted(WPacket& wpk, const AES_KEY& aes_key, uint8_t seq[], size_t seq_len);

Botan::secure_vector<uint8_t> ReadPacketSequenceEncrypted(RPacket& rpk, const AES_KEY& aes_key);

} // namespace dbc