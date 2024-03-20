From: PeterYin <peteryin.openbmc@gmail.com>
Date: Wed, 20 Mar 2024 17:05:28 +0800
Subject: [PATCH v2] drivers: watchdog: ast2600 support bootstatus
In-Reply-To: <13640a07-7395-4521-9c5d-748599202361@roeck-us.net>
References: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
 <13640a07-7395-4521-9c5d-748599202361@roeck-us.net>
Message-ID: <924c4402-af14-4b7a-9a4e-4317c50482cd@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Guenter Roeck ? 3/19/24 08:46 ??:
> On 3/17/24 22:52, Peter Yin wrote:
>> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
>>
>> Regarding the AST2600 specification, the WDTn Timeout Status Register
>> (WDT10) has bit 1 reserved. To verify the second boot source,
>> we need to check SEC14 bit 12 and bit 13.
>> The bits 8-23 in the WDTn Timeout Status Register are the Watchdog
>> Event Count, which we can use to verify WDIOF_EXTERN1.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> 
> You'll have to separate dts and yaml file changes from driver changes.
> 
>> ---
>> Change log:
>>
>> v1 -> v2
>> ?? - Add comment and support WDIOF_CARDRESET in ast2600
>>
>> v1
>> ?? - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
>> ---
>> ? arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |? 8 ++---
>> ? drivers/watchdog/aspeed_wdt.c?????????? | 45 ++++++++++++++++++++++---
>> ? 2 files changed, 44 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi 
>> b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>> index e0b44498269f..23ae7f0430e9 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>> @@ -556,24 +556,24 @@ uart5: serial at 1e784000 {
>> ????????????? wdt1: watchdog at 1e785000 {
>> ????????????????? compatible = "aspeed,ast2600-wdt";
>> -??????????????? reg = <0x1e785000 0x40>;
>> +??????????????? reg = <0x1e785000 0x40>, <0x1e6f2000 0x20>;
>> ????????????? };
>> ????????????? wdt2: watchdog at 1e785040 {
>> ????????????????? compatible = "aspeed,ast2600-wdt";
>> -??????????????? reg = <0x1e785040 0x40>;
>> +??????????????? reg = <0x1e785040 0x40>, <0x1e6f2000 0x020>;
>> ????????????????? status = "disabled";
>> ????????????? };
>> ????????????? wdt3: watchdog at 1e785080 {
>> ????????????????? compatible = "aspeed,ast2600-wdt";
>> -??????????????? reg = <0x1e785080 0x40>;
>> +??????????????? reg = <0x1e785080 0x40>, <0x1e6f2000 0x020>;
>> ????????????????? status = "disabled";
>> ????????????? };
>> ????????????? wdt4: watchdog at 1e7850c0 {
>> ????????????????? compatible = "aspeed,ast2600-wdt";
>> -??????????????? reg = <0x1e7850C0 0x40>;
>> +??????????????? reg = <0x1e7850C0 0x40>, <0x1e6f2000 0x020>;
>> ????????????????? status = "disabled";
>> ????????????? };
>> diff --git a/drivers/watchdog/aspeed_wdt.c 
>> b/drivers/watchdog/aspeed_wdt.c
>> index b4773a6aaf8c..65118e461130 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -33,6 +33,7 @@ struct aspeed_wdt {
>> ????? void __iomem??????? *base;
>> ????? u32??????????? ctrl;
>> ????? const struct aspeed_wdt_config *cfg;
>> +??? void __iomem??????? *sec_base;
>> ? };
>> ? static const struct aspeed_wdt_config ast2400_config = {
>> @@ -82,6 +83,15 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>> ? #define WDT_RESET_MASK1??????? 0x1c
>> ? #define WDT_RESET_MASK2??????? 0x20
>> +/*
>> + * Only Ast2600 support
>> + */
>> +#define?? WDT_EVENT_COUNTER_MASK??? (0xFFF << 8)
>> +#define?? WDT_SECURE_ENGINE_STATUS??? (0x14)
>> +#define?? ABR_IMAGE_SOURCE??????? BIT(12)
>> +#define?? ABR_IMAGE_SOURCE_SPI??????? BIT(13)
>> +#define?? SECOND_BOOT_ENABLE??????? BIT(14)
>> +
>> ? /*
>> ?? * WDT_RESET_WIDTH controls the characteristics of the external 
>> pulse (if
>> ?? * enabled), specifically:
>> @@ -313,6 +323,7 @@ static int aspeed_wdt_probe(struct platform_device 
>> *pdev)
>> ????? const char *reset_type;
>> ????? u32 duration;
>> ????? u32 status;
>> +??? u32 sec_st;
>> ????? int ret;
>> ????? wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> @@ -330,6 +341,12 @@ static int aspeed_wdt_probe(struct 
>> platform_device *pdev)
>> ????? if (IS_ERR(wdt->base))
>> ????????? return PTR_ERR(wdt->base);
>> +??? if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
>> +??????? wdt->sec_base = devm_platform_ioremap_resource(pdev, 1);
>> +??????? if (IS_ERR(wdt->sec_base))
>> +??????????? return PTR_ERR(wdt->sec_base);
>> +??? }
>> +
>> ????? wdt->wdd.info = &aspeed_wdt_info;
>> ????? if (wdt->cfg->irq_mask) {
>> @@ -459,12 +476,30 @@ static int aspeed_wdt_probe(struct 
>> platform_device *pdev)
>> ????? }
>> ????? status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>> -??? if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
>> -??????? wdt->wdd.bootstatus = WDIOF_CARDRESET;
>> -??????? if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
>> -??????????? of_device_is_compatible(np, "aspeed,ast2500-wdt"))
>> -??????????? wdt->wdd.groups = bswitch_groups;
>> +??? if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
>> +??????? /*
>> +???????? * The WDTn Timeout Status Register bit 1 is reserved.
>> +???????? * To verify the second boot source,
>> +???????? * we need to check SEC14 bit 12 and bit 13.
>> +???????? */
>> +??????? sec_st = readl(wdt->sec_base + WDT_SECURE_ENGINE_STATUS);
>> +??????? if( sec_st & SECOND_BOOT_ENABLE)
>> +??????????? if (sec_st & ABR_IMAGE_SOURCE ||
>> +??????????????? sec_st & ABR_IMAGE_SOURCE_SPI)
> 
> I am sure that checkpatch as something to say here. Either case, I would 
> very
> much prefer a single if() statement such as
> 
>  ??????? if (sec_st & SECOND_BOOT_ENABLE &&
>  ??????????? sec_st & (ABR_IMAGE_SOURCE | ABR_IMAGE_SOURCE_SPI))
> 
>> +??????????????? wdt->wdd.bootstatus |= WDIOF_CARDRESET;
>> +
>> +??????? /*
>> +???????? * To check Watchdog Event Count for WDIOF_EXTERN1
>> +???????? */
>> +??????? if (status & WDT_EVENT_COUNTER_MASK) {
>> +??????????? wdt->wdd.bootstatus |= WDIOF_EXTERN1;
>> +??????? }
> 
> Unnecessary { }
> 
> ... but does this really indicate that there was a reset due to some 
> event ?
> This reads three 8-bit counters. Wouldn't it make more sense to check bit 0
> instead ?
> 
> I am also not sure if reading the watchdog status from 
> WDT_SECURE_ENGINE_STATUS
> adds any value over the status reported in the watchdog status register.
> You'll have to explain why the added complexity is necessary or even adds
> value.
> 
> Never mind, though ...
> 
> Looking into the datasheets, the current code is quite completely wrong 
> anyway.
> Bit 1 of the status register indicates on ast2500 if the boot was from 
> the second
> boot source. It does not indicate that the most recent reset was 
> triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET if 
> bit 0
> of the status register is set. The boot source is out of scope for the 
> watchdog
> status bits.
> 
> Thanks,
> Guenter
> 
Ast2600 has external reset flag on scu74 bit 1
Can I modify the code like this?

To set WDIOF_EXTERN1 if EXTERN_RESET_FLAG is set,
To set WDIOF_CARDRESET if WDT_TIMEOUT_STATUS_EVENT(bit0) is set


#define   WDT_TIMEOUT_STATUS_EVENT	BIT(0)
#define   EXTERN_RESET_FLAG		BIT(1)
#define   ASPEED_SYSTEM_RESET_EVENT	(0x74)

	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
	if (status & WDT_TIMEOUT_STATUS_EVENT)
		wdt->wdd.bootstatus = WDIOF_CARDRESET;

	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
		status = readl(wdt->scu_base + ASPEED_SYSTEM_RESET_EVENT);
		if (status & EXTERN_RESET_FLAG)
			/*
			 * Reset cause by Extern Reset
			 */
			wdt->wdd.bootstatus |= WDIOF_EXTERN1;
	} else {
			wdt->wdd.groups = bswitch_groups;
	}
Thanks,
Peter.
