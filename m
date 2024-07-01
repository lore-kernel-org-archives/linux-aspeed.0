From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 1 Jul 2024 10:00:29 -0500
Subject: [PATCH] fsi: add missing MODULE_DESCRIPTION() macros
In-Reply-To: <4d1276a3-ef4a-4c84-8d09-d1613f311a28@quicinc.com>
References: <20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com>
 <4d1276a3-ef4a-4c84-8d09-d1613f311a28@quicinc.com>
Message-ID: <3edca7a4-361b-4381-8b13-70584a30e2b1@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 6/26/24 00:15, Jeff Johnson wrote:
> On 6/5/2024 3:39 PM, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro, and fix the
>> copy/paste of the module description comment in fsi-master-ast-cf.c.


Thanks!

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/fsi/fsi-core.c          | 1 +
>>   drivers/fsi/fsi-master-aspeed.c | 1 +
>>   drivers/fsi/fsi-master-ast-cf.c | 3 ++-
>>   drivers/fsi/fsi-master-gpio.c   | 1 +
>>   drivers/fsi/fsi-master-hub.c    | 1 +
>>   drivers/fsi/fsi-scom.c          | 1 +
>>   6 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>> index 097d5a780264..716a924269ee 100644
>> --- a/drivers/fsi/fsi-core.c
>> +++ b/drivers/fsi/fsi-core.c
>> @@ -1444,5 +1444,6 @@ static void fsi_exit(void)
>>   }
>>   module_exit(fsi_exit);
>>   module_param(discard_errors, int, 0664);
>> +MODULE_DESCRIPTION("FSI core driver");
>>   MODULE_LICENSE("GPL");
>>   MODULE_PARM_DESC(discard_errors, "Don't invoke error handling on bus accesses");
>> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
>> index f0a19cd451a0..b454587790a2 100644
>> --- a/drivers/fsi/fsi-master-aspeed.c
>> +++ b/drivers/fsi/fsi-master-aspeed.c
>> @@ -672,4 +672,5 @@ static struct platform_driver fsi_master_aspeed_driver = {
>>   };
>>   
>>   module_platform_driver(fsi_master_aspeed_driver);
>> +MODULE_DESCRIPTION("FSI master driver for AST2600");
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
>> index 812dfa9a9140..85096559dda3 100644
>> --- a/drivers/fsi/fsi-master-ast-cf.c
>> +++ b/drivers/fsi/fsi-master-ast-cf.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   // Copyright 2018 IBM Corp
>>   /*
>> - * A FSI master controller, using a simple GPIO bit-banging interface
>> + * A FSI master based on Aspeed ColdFire coprocessor
>>    */
>>   
>>   #include <linux/crc4.h>
>> @@ -1440,5 +1440,6 @@ static struct platform_driver fsi_master_acf = {
>>   };
>>   
>>   module_platform_driver(fsi_master_acf);
>> +MODULE_DESCRIPTION("A FSI master based on Aspeed ColdFire coprocessor");
>>   MODULE_LICENSE("GPL");
>>   MODULE_FIRMWARE(FW_FILE_NAME);
>> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
>> index ed03da4f2447..d32dcc98e85b 100644
>> --- a/drivers/fsi/fsi-master-gpio.c
>> +++ b/drivers/fsi/fsi-master-gpio.c
>> @@ -894,4 +894,5 @@ static struct platform_driver fsi_master_gpio_driver = {
>>   };
>>   
>>   module_platform_driver(fsi_master_gpio_driver);
>> +MODULE_DESCRIPTION("A FSI master controller, using a simple GPIO bit-banging interface");
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
>> index 6d8b6e8854e5..6568fed7db3c 100644
>> --- a/drivers/fsi/fsi-master-hub.c
>> +++ b/drivers/fsi/fsi-master-hub.c
>> @@ -295,4 +295,5 @@ static struct fsi_driver hub_master_driver = {
>>   };
>>   
>>   module_fsi_driver(hub_master_driver);
>> +MODULE_DESCRIPTION("FSI hub master driver");
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
>> index 61dbda9dbe2b..411ddc018cd8 100644
>> --- a/drivers/fsi/fsi-scom.c
>> +++ b/drivers/fsi/fsi-scom.c
>> @@ -625,4 +625,5 @@ static void scom_exit(void)
>>   
>>   module_init(scom_init);
>>   module_exit(scom_exit);
>> +MODULE_DESCRIPTION("SCOM FSI Client device driver");
>>   MODULE_LICENSE("GPL");
>>
>> ---
>> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
>> change-id: 20240605-md-drivers-fsi-0a34d82a85da
>>
> Following up to see if anything else is needed from me.
> Hoping to see this in linux-next :)
>
> /jeff
