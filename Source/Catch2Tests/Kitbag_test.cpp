#include "catch.hpp"
#include "Kitbag.h"
#include <limits>

constexpr auto defKITBAG_DATA_STRING_LEN{8192}; // from GameServer/GameDB.cpp

TEST_CASE("Kitbag", "[inventory]")
{
  CKitbag bag{};

  static auto constexpr ItemInfoSize{100}; // Load only N items
  auto pItemSet = make_unique<CItemRecordSet>(0, ItemInfoSize);
  pItemSet->LoadRawDataInfo("iteminfo", false);
  REQUIRE(pItemSet);

  static auto constexpr  chunk_size{4}; // N Items to append to bag
  auto const item_ids = GENERATE(take(1, chunk(chunk_size, random(1, ItemInfoSize ))));
  REQUIRE(item_ids.size() == chunk_size);

  for(auto id : item_ids)
  {
	auto itemRecord = GetItemRecordInfo(id);
	INFO("ID: " << id)
	REQUIRE(itemRecord);

	//NOTE(Ogge): nPileMax can be negative, wouldn't it be >= 1? and (if there is any) <= global max limit 
	auto const item_stack_size = itemRecord->GetIsPile() ? GENERATE_COPY(take(1, random(1, itemRecord->nPileMax))) : 1;
	SItemGrid itemGrid(itemRecord->nID, item_stack_size);


	//FIXME: Populate itemGrid with some data
	itemGrid.sEndure[0] = GENERATE(take(1, random(0, 100)));
	itemGrid.sEndure[1] = GENERATE(take(1, random(0, 100)));

	itemGrid.sEnergy[0] = GENERATE(take(1, random(0, 100)));
	itemGrid.sEnergy[1] = GENERATE(take(1, random(0, 100)));

	short item_position{-1}; // -1 :  Push item to next available slot
	bag.Push(&itemGrid, item_position, true, true);
  }

  auto initial_string = std::make_unique<char[]>(defKITBAG_DATA_STRING_LEN);
  KitbagData2String(&bag, initial_string.get(), defKITBAG_DATA_STRING_LEN);

  CKitbag generated_bag{};
  std::string initial_string_(initial_string.get());
  String2KitbagData(&generated_bag, initial_string_);

  auto generated_string = std::make_unique<char[]>(defKITBAG_DATA_STRING_LEN);
  KitbagData2String(&generated_bag, generated_string.get(), defKITBAG_DATA_STRING_LEN);

  REQUIRE(std::string(initial_string.get()) == generated_string.get());



 // static constexpr auto sample_size{100};
 // CKitbag		 bag{};

 // SECTION("A new bag is a empty bag")
 // {
	//REQUIRE(bag.IsFull() == false);
	//REQUIRE(bag.GetUseGridNum() == 0);
 // }

 // SECTION("A new bag is not locked")
 // {
	//REQUIRE(bag.IsLock() == false);
	//REQUIRE(bag.IsPwdAutoLocked() == false);
	//REQUIRE(bag.IsPwdLocked() == false);
 // }

 // SECTION("Resize with negative value")
 // {
	//const auto negative = GENERATE(take(sample_size, random((int)(std::numeric_limits<short>::min)(), 0)));
	//bag.SetCapacity(negative);
	//REQUIRE(bag.GetCapacity() == 0);
 // }

 // SECTION("Resize with positive value")
 // {
	//const auto positive = GENERATE(take(sample_size, random(0, (int)(std::numeric_limits<short>::max)())),
	//							   value(0));
	//bag.SetCapacity(positive);
	//REQUIRE(bag.GetCapacity() >= 0);
	//REQUIRE(bag.GetCapacity() <= defMAX_KBITEM_NUM_PER_TYPE);
 // }

 // SECTION("Add capacity")
 // {
	//const auto initial = bag.GetCapacity();
	//SECTION("Add negative capacity")
	//{
	//  const auto negative = GENERATE(take(sample_size, random((int)(std::numeric_limits<short>::min)(), 0)));
	//  REQUIRE(bag.AddCapacity(negative) == false);
	//  REQUIRE(bag.GetCapacity() == initial);
	//}

	//SECTION("Add positive capacity")
	//{
	//  const auto positive = GENERATE(take(sample_size, random(0, (int)(std::numeric_limits<short>::max)())),
	//								 take(sample_size, random(0, defMAX_KBITEM_NUM_PER_TYPE)),
	//								 value(0));

	//  const auto initial = bag.GetCapacity();
	//  REQUIRE(bag.AddCapacity(positive) == true);
	//  REQUIRE(bag.GetCapacity() <= defMAX_KBITEM_NUM_PER_TYPE);
	//  REQUIRE(bag.GetCapacity() >= 0);
	//  const auto final = bag.GetCapacity();

	//  REQUIRE([&]() -> bool
	//		  {
	//			for (auto i = initial; i < final; ++i) {
	//				if (bag.IsSingleChange(i))
	//					return false;
	//			}
	//			return true; }());
	//}
 // }

 // SECTION("Add items to bag")
 // {
	//SItemGrid item1(1, 1);
	//short	  posID1{1};
	//bag.Push(&item1, posID1, true, true);
	//REQUIRE(bag.HasItem(1));

	//SItemGrid item2(2, 1);
	//short	  posID2{2};
	//bag.Push(&item2, posID2, true, true);
	//REQUIRE(bag.HasItem(2));

	//REQUIRE(bag.IsChange());
	//REQUIRE(bag.GetChangeNum() == 2);

	//SECTION("Switch items")
	//{
	//  REQUIRE(bag.GetID(posID1) == item1.sID);
	//  REQUIRE(bag.GetID(posID2) == item2.sID);

	//  bag.Switch(posID1, posID2);

	//  REQUIRE(bag.GetID(posID1) == item2.sID);
	//  REQUIRE(bag.GetID(posID2) == item1.sID);
	//}
 // }

 // SECTION("string -> kitbag -> string")
 // {
	//// String copied from gamedb.resource table

	//std::string initial_string = R"(24@114#jtk\fbdbbek``b]gaih`\cafaei``b]f]ida`bafaih``^abbel`\ffbdodb`^abaeh\`^abatl\akibbei``babbih``^abaeh\`^abaehke^efaida\b]f]id`\b]f]id`\bll]lqeh^bbaeh\`^abaeh\`^abato\ckin]jd`\b]f]id`\b]f]id`kj]hjqp\a^abaeh\`^abaeh\`^aqbodd\c]iaih\abafaej`cb]halh\`^abaeh\a^dj]rh\cg]gbjdbi^cbaeh\`^aqbqdd`e]g]lh``^bfaih\eb]kaeh\`^abaei\ch]hhelg\cibdidb\b]f]id`kdabbei\cbaf]jh``b]f]id`\b]f]ida\eebdkdce^eg]id`\b]f]id`kcafaiqe`gg)";

	//String2KitbagData(&bag, initial_string);

	//auto generated_string = std::make_unique<char[]>(defKITBAG_DATA_STRING_LEN);
	//KitbagData2String(&bag, generated_string.get(), defKITBAG_DATA_STRING_LEN);

	//REQUIRE(initial_string == std::string(generated_string.get()));
 // }
}
