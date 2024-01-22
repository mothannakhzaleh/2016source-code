#include "LicenseManager.h"
#ifdef _DEBUG
#define OBF_DEBUG
#endif

#include "instr.h"
#include <iostream>

int LicenseManager::verifyLicense() {
  OBF_BEGIN

  std::map<int, std::string> stringByEventType;
  stringByEventType[LICENSE_OK]					      = "OK ";
  stringByEventType[LICENSE_FILE_NOT_FOUND]			  = "license file was not found.";
  stringByEventType[LICENSE_SERVER_NOT_FOUND]		  = "license server can't be contacted.";
  stringByEventType[ENVIRONMENT_VARIABLE_NOT_DEFINED] = "environment variable not defined.";
  stringByEventType[FILE_FORMAT_NOT_RECOGNIZED]		  = "license file has invalid format (not .ini file).";
  stringByEventType[LICENSE_MALFORMED]				  = "some mandatory field are missing, or data can't be fully read. ";
  stringByEventType[PRODUCT_NOT_LICENSED]			  = "this product was not licensed.";
  stringByEventType[PRODUCT_EXPIRED]				  = "license expired!";
  stringByEventType[LICENSE_CORRUPTED]				  = "license signature didn't match with current license.";
  stringByEventType[IDENTIFIERS_MISMATCH]			  = "Calculated identifier and the one provided in license didn't match.";

  size_t pc_id_sz = LCC_API_PC_IDENTIFIER_SIZE + 1;
  char	 pc_identifier[LCC_API_PC_IDENTIFIER_SIZE + 1];

  LicenseInfo licenseInfo{};
  int		  result = N(6);
  std::cout.setstate(std::ios_base::failbit);
  V(result) = (int)(acquire_license(nullptr, nullptr, &licenseInfo));
  std::cout.clear();
  int isLinked			= N(0);
  int  daysLeft			= N(0);

  V(isLinked)			= V(licenseInfo.linked_to_pc);
  V(daysLeft)			= V(licenseInfo.days_left);

  IF(( V(result) == N(0)) )
	printf("Yatops License found!\n");
	IF( V(isLinked) == N(0))
	  printf("This license is not linked to your hardware ID. Days remaining:  %d\n", (int)V(daysLeft));
	ELSE
	  printf("This license is linked to your hardware ID. Days remaining:  %d\n", (int)V(daysLeft));
	ENDIF
  ENDIF

  IF( (V(result) != N(0)))
	printf("License ERROR: ");
	printf("%s\n", stringByEventType[V(result)].c_str());
	int canIdentify = N(false);
	V(canIdentify)	 = identify_pc(STRATEGY_DEFAULT, pc_identifier, &pc_id_sz, nullptr);
	IF(( V(canIdentify) ==N(1)))
	  printf("The current hardware ID is %s\n", pc_identifier);
	ELSE
	  printf("Contact the developer: identify_pc returned false!\n");
	  ENDIF
	  std::getchar();
	  exit(N(0));
  ENDIF


  OBF_END
}