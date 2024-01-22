#pragma once

// Continue once C++17 or higher
// #include <optional>
// #include <string_view>
//namespace login
//{

//std::optional<std::string_view> is_valid_name(std::string_view name)
//{
// if length != ok
//	return {"Invalid length"};

//if name !conform
//	return {"Invalid character name"};

//return true;
//}
//}
#include <algorithm>
#include <cctype> // might be removable once string_view included

namespace common
{
namespace conformity
{
namespace login
{
struct name
{
  static bool is_valid(const char* name, size_t len)
  {
	return len >= min_length &&
		   len <= max_length &&
		   std::all_of(name, name + len, [](char c)
					   { return std::isalnum(static_cast<unsigned char>(c)); });
  }

  static constexpr auto max_length{14};
  static constexpr auto min_length{4};
};

struct password
{
  static bool is_valid(const char* name, size_t len)
  {
	//NOTE(Ogge): As of now its not even used...
	//BUT passwords should be able to contain more characters than just those allowed by std::isalnum
	return len >= min_length &&
		   len <= max_length &&
		   std::all_of(name, name + len, [](char c)
					   { return std::isalnum(static_cast<unsigned char>(c)); });
  }

  static constexpr auto max_length{24};
  static constexpr auto min_length{4};
};

} // namespace login
namespace character
{
struct name
{
  static bool is_valid(const char* name, size_t len)
  {
	return len >= min_length &&
		   len <= max_length &&
		   std::all_of(name, name + len, [](char c)
					   { return std::isalnum(static_cast<unsigned char>(c)); });
  }

  static constexpr auto max_length{16};
  static constexpr auto min_length{4};
};

} // namespace character
namespace guild
{
struct name
{
  static bool is_valid(const char* name, size_t len)
  {
	return len >= min_length &&
		   len <= max_length &&
		   std::all_of(name, name + len, [](char c)
					   { return std::isalnum(static_cast<unsigned char>(c)); });
  }

  static constexpr auto max_length{24};
  static constexpr auto min_length{4};
};

struct password
{
  static bool is_valid(const char* name, size_t len)
  {
	//NOTE(Ogge): As of now its not even used...
	//BUT passwords should be able to contain more characters than just those allowed by std::isalnum
	return len >= min_length &&
		   len <= max_length &&
		   std::all_of(name, name + len, [](char c)
					   { return std::isalnum(static_cast<unsigned char>(c)); });
  }

  static constexpr auto max_length{24};
  static constexpr auto min_length{4};
};

struct motto
{
  static bool is_valid(const char* name, size_t len)
  {
	return len >= min_length &&
		   len <= max_length &&
		   std::all_of(name, name + len, [](char c)
					   { return std::isalnum(static_cast<unsigned char>(c)); });
  }

  static constexpr auto max_length{24};
  static constexpr auto min_length{4};
};

} // namespace guild
namespace friends_group
{
struct name
{
  static bool is_valid(const char* name, size_t len)
  {
	return len >= min_length &&
		   len <= max_length &&
		   std::all_of(name, name + len, [](char c)
					   { return std::isalnum(static_cast<unsigned char>(c)); });
  }

  static constexpr auto max_length{16};
  static constexpr auto min_length{4};
};
}
} // namespace conformity
} // namespace common


