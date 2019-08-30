From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 30 Aug 2019 10:36:03 -0700
Subject: [PATCH 3/3] pmbus: ibm-cffps: Add support for version 2 of the PSU
In-Reply-To: <1567181385-22129-4-git-send-email-eajames@linux.ibm.com>
References: <1567181385-22129-1-git-send-email-eajames@linux.ibm.com>
 <1567181385-22129-4-git-send-email-eajames@linux.ibm.com>
Message-ID: <20190830173603.GA10472@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 30, 2019 at 11:09:45AM -0500, Eddie James wrote:
> Version 2 of the PSU supports a second page of data and changes the
> format of the FW version. Use the devicetree binding to differentiate
> between the version the driver should use.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 109 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 87 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index ee2ee9e..ca26fbd 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -12,16 +12,20 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/pmbus.h>
>  
>  #include "pmbus.h"
>  
> +#define CFFPS_VERSIONS				2
> +

Any chance you can use an enum for the versions ? Using version
numbers 1/2 combined with array indices 0/1 is confusing, error
prone, and seems unnecessary.

Thanks,
Guenter

>  #define CFFPS_FRU_CMD				0x9A
>  #define CFFPS_PN_CMD				0x9B
>  #define CFFPS_SN_CMD				0x9E
>  #define CFFPS_CCIN_CMD				0xBD
> -#define CFFPS_FW_CMD_START			0xFA
> -#define CFFPS_FW_NUM_BYTES			4
> +#define CFFPS_FW_CMD				0xFA
> +#define CFFPS1_FW_NUM_BYTES			4
> +#define CFFPS2_FW_NUM_WORDS			3
>  #define CFFPS_SYS_CONFIG_CMD			0xDA
>  
>  #define CFFPS_INPUT_HISTORY_CMD			0xD6
> @@ -61,6 +65,7 @@ struct ibm_cffps_input_history {
>  };
>  
>  struct ibm_cffps {
> +	int version;
>  	struct i2c_client *client;
>  
>  	struct ibm_cffps_input_history input_history;
> @@ -132,6 +137,8 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>  	struct ibm_cffps *psu = to_psu(idxp, idx);
>  	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
>  
> +	pmbus_set_page(psu->client, 0);
> +
>  	switch (idx) {
>  	case CFFPS_DEBUGFS_INPUT_HISTORY:
>  		return ibm_cffps_read_input_history(psu, buf, count, ppos);
> @@ -152,16 +159,36 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>  		rc = snprintf(data, 5, "%04X", rc);
>  		goto done;
>  	case CFFPS_DEBUGFS_FW:
> -		for (i = 0; i < CFFPS_FW_NUM_BYTES; ++i) {
> -			rc = i2c_smbus_read_byte_data(psu->client,
> -						      CFFPS_FW_CMD_START + i);
> -			if (rc < 0)
> -				return rc;
> +		switch (psu->version) {
> +		case 1:
> +			for (i = 0; i < CFFPS1_FW_NUM_BYTES; ++i) {
> +				rc = i2c_smbus_read_byte_data(psu->client,
> +							      CFFPS_FW_CMD +
> +								i);
> +				if (rc < 0)
> +					return rc;
> +
> +				snprintf(&data[i * 2], 3, "%02X", rc);
> +			}
>  
> -			snprintf(&data[i * 2], 3, "%02X", rc);
> -		}
> +			rc = i * 2;
> +			break;
> +		case 2:
> +			for (i = 0; i < CFFPS2_FW_NUM_WORDS; ++i) {
> +				rc = i2c_smbus_read_word_data(psu->client,
> +							      CFFPS_FW_CMD +
> +								i);
> +				if (rc < 0)
> +					return rc;
> +
> +				snprintf(&data[i * 4], 5, "%04X", rc);
> +			}
>  
> -		rc = i * 2;
> +			rc = i * 4;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
>  		goto done;
>  	default:
>  		return -EINVAL;
> @@ -279,6 +306,8 @@ static void ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
>  			psu->led_state = CFFPS_LED_ON;
>  	}
>  
> +	pmbus_set_page(psu->client, 0);
> +
>  	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
>  				       psu->led_state);
>  	if (rc < 0)
> @@ -299,6 +328,8 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
>  	if (led_cdev->brightness == LED_OFF)
>  		return 0;
>  
> +	pmbus_set_page(psu->client, 0);
> +
>  	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
>  				       CFFPS_LED_BLINK);
>  	if (rc < 0)
> @@ -328,15 +359,32 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
>  		dev_warn(dev, "failed to register led class: %d\n", rc);
>  }
>  
> -static struct pmbus_driver_info ibm_cffps_info = {
> -	.pages = 1,
> -	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> -		PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
> -		PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_VOUT |
> -		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
> -		PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_FAN12,
> -	.read_byte_data = ibm_cffps_read_byte_data,
> -	.read_word_data = ibm_cffps_read_word_data,
> +static struct pmbus_driver_info ibm_cffps_info[CFFPS_VERSIONS] = {
> +	[0] = {
> +		.pages = 1,
> +		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
> +			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_FAN12,
> +		.read_byte_data = ibm_cffps_read_byte_data,
> +		.read_word_data = ibm_cffps_read_word_data,
> +	},
> +	[1] = {
> +		.pages = 2,
> +		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
> +			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_FAN12,
> +		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT,
> +		.read_byte_data = ibm_cffps_read_byte_data,
> +		.read_word_data = ibm_cffps_read_word_data,
> +	},
>  };
>  
>  static struct pmbus_platform_data ibm_cffps_pdata = {
> @@ -346,13 +394,21 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
>  static int ibm_cffps_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> -	int i, rc;
> +	int i, rc, vs;
>  	struct dentry *debugfs;
>  	struct dentry *ibm_cffps_dir;
>  	struct ibm_cffps *psu;
> +	const void *md = of_device_get_match_data(&client->dev);
> +
> +	if (md)
> +		vs = (int)md;
> +	else if (id)
> +		vs = (int)id->driver_data;
> +	else
> +		vs = 1;
>  
>  	client->dev.platform_data = &ibm_cffps_pdata;
> -	rc = pmbus_do_probe(client, id, &ibm_cffps_info);
> +	rc = pmbus_do_probe(client, id, &ibm_cffps_info[vs - 1]);
>  	if (rc)
>  		return rc;
>  
> @@ -364,6 +420,7 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  	if (!psu)
>  		return 0;
>  
> +	psu->version = vs;
>  	psu->client = client;
>  	mutex_init(&psu->input_history.update_lock);
>  	psu->input_history.last_update = jiffies - HZ;
> @@ -406,12 +463,20 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  
>  static const struct i2c_device_id ibm_cffps_id[] = {
>  	{ "ibm_cffps1", 1 },
> +	{ "ibm_cffps2", 2 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ibm_cffps_id);
>  
>  static const struct of_device_id ibm_cffps_of_match[] = {
> -	{ .compatible = "ibm,cffps1" },
> +	{
> +		.compatible = "ibm,cffps1",
> +		.data = (void *)1
> +	},
> +	{
> +		.compatible = "ibm,cffps2",
> +		.data = (void *)2
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ibm_cffps_of_match);
> -- 
> 1.8.3.1
> 
