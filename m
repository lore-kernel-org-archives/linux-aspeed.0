From: Zev Weiss <zweiss@equinix.com>
Date: Wed, 11 Oct 2023 18:19:09 +0000
Subject: [PATCH 2/2] watchdog: aspeed: Add support for aspeed,reset-mask
 DT property
In-Reply-To: <CACPK8Xe5UEDt+ko_FtF-fi1TZDNZeZMtzaU_ZBxt6CO+UHJEpg@mail.gmail.com>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
 <20230922104231.1434-6-zev@bewilderbeest.net>
 <CACPK8Xe5UEDt+ko_FtF-fi1TZDNZeZMtzaU_ZBxt6CO+UHJEpg@mail.gmail.com>
Message-ID: <20231011181909.GK19997@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 11, 2023 at 02:26:32AM PDT, Joel Stanley wrote:
>On Fri, 22 Sept 2023 at 20:12, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> This property allows the device-tree to specify how the Aspeed
>> watchdog timer's reset mask register(s) should be set, so that
>> peripherals can be individually exempted from (or opted in to) being
>> reset when the watchdog timer expires.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>Reviewed-by: Joel Stanley <joel@jms.id.au>
>
>A note below.
>
>> ---
>>  drivers/watchdog/aspeed_wdt.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>> index b72a858bbac7..b4773a6aaf8c 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -79,6 +79,8 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>  #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY    BIT(1)
>>  #define WDT_CLEAR_TIMEOUT_STATUS       0x14
>>  #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION    BIT(0)
>> +#define WDT_RESET_MASK1                0x1c
>> +#define WDT_RESET_MASK2                0x20
>>
>>  /*
>>   * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>> @@ -402,6 +404,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>
>>         if ((of_device_is_compatible(np, "aspeed,ast2500-wdt")) ||
>>                 (of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
>> +               u32 reset_mask[2];
>> +               size_t nrstmask = of_device_is_compatible(np, "aspeed,ast2600-wdt") ? 2 : 1;
>>                 u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>>
>>                 reg &= wdt->cfg->ext_pulse_width_mask;
>> @@ -419,6 +423,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>                         reg |= WDT_OPEN_DRAIN_MAGIC;
>>
>>                 writel(reg, wdt->base + WDT_RESET_WIDTH);
>> +
>> +               ret = of_property_read_u32_array(np, "aspeed,reset-mask", reset_mask, nrstmask);
>> +               if (!ret) {
>> +                       writel(reset_mask[0], wdt->base + WDT_RESET_MASK1);
>> +                       if (nrstmask > 1)
>> +                               writel(reset_mask[1], wdt->base + WDT_RESET_MASK2);
>> +               }
>
>This will do funky things if someone is careless enough to put the
>property in an ast2400 device tree.
>
>The ast2700 has four reset mask registers. Not really your problem at
>this point, but we might need to move to a per-soc callback in the
>platform data or similar.
>

This chunk is within an 'if' block that only runs on ast2500 & ast2600,
so it should be safely ignored on anything else.

>>         }
>>
>>         if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
>> --
>> 2.40.0.5.gf6e3b97ba6d2.dirty
>>
