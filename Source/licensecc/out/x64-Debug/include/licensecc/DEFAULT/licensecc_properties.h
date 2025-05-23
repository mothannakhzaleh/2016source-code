/** 
 * \file
 * This file contains all the properties that are customizable on on a per-project basis eg:
 * 1) api parameter sizes
 * 2)
 *
 * It is safe to place the values that your project need to customize here, since each project get its own copy of this
 * file.
 */

/** 
 * \addtogroup api
 * @{
 */
 
#ifndef BUILD_PROPERTIES_H_
#define BUILD_PROPERTIES_H_

 
/**
 * This file contains all the properties that are customizable on on a per-project basis eg:
 * 1) api parameter sizes
 * 2) 
 *
 * It is safe to place the values that your project need to customize here, since each project get its own copy of this
 * file.
 */

#define LCC_PROJECT_NAME "DEFAULT"

//License retrieval configuration
#define FIND_LICENSE_NEAR_MODULE true
#define FIND_LICENSE_WITH_ENV_VAR false

/**
 * License file name extension
 */
#define LCC_LICENSE_FILE_EXTENSION ".lic"
#define LCC_LICENSE_LOCATION_ENV_VAR "LICENSE_LOCATION"
#define LCC_LICENSE_DATA_ENV_VAR "LICENSE_DATA"

// Api structure limits
/**
 * Maximum size of a license file or base64 data
 */
#define LCC_API_MAX_LICENSE_DATA_LENGTH 1024 * 4

// define api structure sizes
#define LCC_API_PC_IDENTIFIER_SIZE 19
#define LCC_API_PROPRIETARY_DATA_SIZE 16
#define LCC_API_AUDIT_EVENT_NUM 5
#define LCC_API_AUDIT_EVENT_PARAM2 255
#define LCC_API_VERSION_LENGTH 15
#define LCC_API_FEATURE_NAME_SIZE 15
#define LCC_API_EXPIRY_DATE_SIZE 10
#define LCC_API_ERROR_BUFFER_SIZE 256

/**
This definition allows to specify a custom expression to verify the magic number passed in by the api.
*/
#define LCC_VERIFY_MAGIC (lic_info.m_magic == 0)

/**
 *
 * Environment variable name that if defined will change the identification strategy used to generate the hardware
 * identifier. If a client has an unstable pc-identifier use this variable to generate one. Valid values are integers
 * defined in `LCC_IDENTIFICATION_STRATEGY` enum.
 */
#define LCC_IDENTIFICATION_STRATEGY_ENV_VAR "IDENTIFICATION_STRATEGY"

/**
 * \enum LCC_API_HW_IDENTIFICATION_STRATEGY
 *
 * This enum list all the possible pc identification strategy. It is to be used as a parameter of ::identify_pc
 *
 * ::STRATEGY_DEFAULT Should be used in most cases.
 */
enum LCC_API_HW_IDENTIFICATION_STRATEGY {
	/**
	 * \brief Default strategy.
	 * 
	 * This strategy first checks the content of the environment variable `IDENTIFICATION_STRATEGY`. If the variable is defined it will use the 
	 * strategy specified in there, if not defined it will try to detect which virtual environment the software is running in.
	 *  - If no virtual environment is detected it will try the strategies defined in ::LCC_BARE_TO_METAL_STRATEGIES
	 *  - If it detects the software is running in a virtual machine it will use ::LCC_VM_STRATEGIES
	 *  - If it detects the software is running in a docker or in an LXC it will use ::LCC_DOCKER_STRATEGIES or
	 * ::LCC_DOCKER_STRATEGIES
	 *  - If it detects the software is running in a virtual machine in the cloud it will use ::LCC_CLOUD_STRATEGIES
	 */
	STRATEGY_DEFAULT = -1,
	/**
	 * \brief Uses mac address to generate hardware id.
	 * 
	 * This strategy use the mac address of one of the network adapters to generate the hardware identifier.
	 * Network adapters are scored using their names, trying to avoid vpn adapters and virtual devices.
	 * Mac address should be unique in the subnetwork, so this strategy poses some limitation on the number of licenses
	 * that can be in use in the same subnet.
	 */	
	STRATEGY_ETHERNET = 0,
	STRATEGY_IP_ADDRESS = 1,
	STRATEGY_DISK = 2,
	/**
	* Not yet implemented
	*/
	STRATEGY_CPU_SIZE = 3,
	/**
	* Not yet implemented
	*/
	STRATEGY_HOST_NAME = 4,
	STRATEGY_NONE = -2
};

/**
 * @addtogroup strategies
 * @{
 */
/**
 * List the strategies used when no virtual envrionment is detected
 */
#define LCC_BARE_TO_METAL_STRATEGIES { STRATEGY_DISK, STRATEGY_HOST_NAME, STRATEGY_NONE }
/**
 * List the strategies used when the software is executing in a virtual machine
 */
#define LCC_VM_STRATEGIES { STRATEGY_ETHERNET, STRATEGY_NONE }
#define LCC_LXC_STRATEGIES { STRATEGY_ETHERNET, STRATEGY_NONE }
#define LCC_DOCKER_STRATEGIES { STRATEGY_NONE }
/**
 * List the strategies used when it's detected an execution in the cloud
 */
#define LCC_CLOUD_STRATEGIES { STRATEGY_NONE }

/**
 * @}
 */


#endif
/**
 * @}
 */
