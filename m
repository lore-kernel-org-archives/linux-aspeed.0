From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 26 Apr 2024 09:23:30 -0700
Subject: [PATCH v7 1/1] drivers: watchdog: revise watchdog bootstatus
In-Reply-To: <CAPSyxFTa6k3FzUmDoZ6HMpAfwZGK_yPrQKGSvSdtj_JqsnMVrA@mail.gmail.com>
References: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
 <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
 <5ed8bfd6ce559a7d00ec89f1bd7ae1aea90e3ae7.camel@codeconstruct.com.au>
 <CAPSyxFTa6k3FzUmDoZ6HMpAfwZGK_yPrQKGSvSdtj_JqsnMVrA@mail.gmail.com>
Message-ID: <cb473967-5cd7-44fd-99ea-fd5572e5963d@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/26/24 07:45, Chia Hsing Yin wrote:
> I can include reset condition in struct maybe like this
> 
> static const struct aspeed_wdt_config ast2600_config = {
> .ext_pulse_width_mask = 0xfffff,
> .irq_shift = 0,
> .irq_mask = GENMASK(31, 10),
> .compatible = "aspeed,ast2600-scu",
> .reset_event = AST2600_SYSTEM_RESET_EVENT,
> .watchdog_reset_flag = AST2600_WATCHDOG_RESET_FLAG,
> .extern_reset_flag = EXTERN_RESET_FLAG,
> .reset_flag_clear = AST2600_RESET_FLAG_CLEAR,
> };
> 
> in probe( ) we  just call
> 
> scu_base = syscon_regmap_lookup_by_compatible(wdt->cfg->compatible);
> if (IS_ERR(scu_base))
>      return PTR_ERR(scu_base);
> 
> ret = regmap_read(scu_base, wdt->cfg->reset_event, &status);
> if (ret)
>      return ret;
> 
> if ((status & POWERON_RESET_FLAG) == 0 &&

If you do that, please use
	if (!(status & POWERON_RESET_FLAG) && ...

>       status & wdt->cfg->watchdog_reset_flag)
>      wdt->wdd.bootstatus = (status & wdt->cfg->extern_reset_flag) ?
>      WDIOF_EXTERN1 : WDIOF_CARDRESET;
> 
> status = wdt->cfg->watchdog_reset_flag | POWERON_RESET_FLAG |
> wdt->cfg->extern_reset_flag;
> 
> ret = regmap_write(scu_base, wdt->cfg->reset_event, status);
> 
> Does this meet your expectations?
> 
> On Fri, Apr 26, 2024 at 8:42?AM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
>>
>> On Thu, 2024-04-25 at 17:07 +0800, Peter Yin wrote:
>>> Regarding the AST2600 specification, the WDTn Timeout Status Register
>>> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
>>> on ast2500 if the boot was from the second boot source.
>>> It does not indicate that the most recent reset was triggered by
>>> the watchdog. The code should just be changed to set WDIOF_CARDRESET
>>> if bit 0 of the status register is set. However, this bit can be clear when
>>> watchdog register 0x0c bit1(Reset System after timeout) is enabled.
>>> Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
>>> in ast2600 SCU74 or ast2400/ast2500 SCU3C.
>>>
>>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>>> ---
>>>   drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
>>>   1 file changed, 103 insertions(+), 6 deletions(-)
>>
>> After this patch the probe() implementation is ~250loc with a whole
>> bunch of conditional behaviours based on the SoC version. Maybe it's
>> time to break it up into version-specific functions that are called
>> from the probe() implementation?
>>
>> Andrew

