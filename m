From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 1 Nov 2022 15:54:50 -0500
Subject: [PATCH 1/2] watchdog: aspeed: Add pre-timeout interrupt support
In-Reply-To: <00d859b0-f766-4322-fe58-095d4f84e954@roeck-us.net>
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-2-eajames@linux.ibm.com>
 <20221021165650.GA1888515@roeck-us.net>
 <56929483-56d1-f2b8-9b7e-3fd6388e5f87@linux.ibm.com>
 <00d859b0-f766-4322-fe58-095d4f84e954@roeck-us.net>
Message-ID: <8b74ecdd-40aa-90c8-0180-eccf65f3440f@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 10/21/22 23:00, Guenter Roeck wrote:
> On 10/21/22 12:39, Eddie James wrote:
>>
>> On 10/21/22 11:56, Guenter Roeck wrote:
>>> On Fri, Oct 21, 2022 at 10:15:58AM -0500, Eddie James wrote:
>>>> Enable the pre-timeout interrupt if requested by device property.
>>>>
>>> I am not inclined to accept this patch without detailed explanation.
>>> Why would it make sense and/or be desirable to completely bypass the
>>> watchdog core with this pretimeout support ?
>>
>>
>> Sorry, I should add more detail.
>>
>> It doesn't necessarily bypass the watchdog core. It can, if you 
>> specify reset-type="none". But if not, the watchdog will still fire 
>> at the appropriate time.
>>
>> The purpose is to get a stack dump from a kernel panic rather than a 
>> hard reset from the watchdog. The interrupt will fire a certain 
>> number of microseconds (configurable by dts property) before the 
>> watchdog does. The interrupt handler then panics, and all the CPU 
>> stacks are dumped, so hopefully you can catch where another processor 
>> was stuck.
>>
>>
>> I can submit v2 with this information in the commit message and/or 
>> comments.
>>
>
> You did not answer the question why you do not use the pretimeout 
> functionality
> supported by the watchdog core.


I misunderstood your question and I wasn't actually aware of the 
pretimeout support in the core. I have sent v2 using the core pretimeout.


Thanks,

Eddie


>
> Guenter
>
>> Thanks,
>>
>> Eddie
>>
>>
>>>
>>> Thanks,
>>> Guenter
>>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> ---
>>>> ? drivers/watchdog/aspeed_wdt.c | 53 
>>>> +++++++++++++++++++++++++++++++++--
>>>> ? 1 file changed, 51 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/aspeed_wdt.c 
>>>> b/drivers/watchdog/aspeed_wdt.c
>>>> index 0cff2adfbfc9..8e12181a827e 100644
>>>> --- a/drivers/watchdog/aspeed_wdt.c
>>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>>> @@ -5,11 +5,14 @@
>>>> ?? * Joel Stanley <joel@jms.id.au>
>>>> ?? */
>>>> +#include <linux/bits.h>
>>>> ? #include <linux/delay.h>
>>>> +#include <linux/interrupt.h>
>>>> ? #include <linux/io.h>
>>>> ? #include <linux/kernel.h>
>>>> ? #include <linux/module.h>
>>>> ? #include <linux/of.h>
>>>> +#include <linux/of_irq.h>
>>>> ? #include <linux/platform_device.h>
>>>> ? #include <linux/watchdog.h>
>>>> @@ -26,20 +29,32 @@ struct aspeed_wdt {
>>>> ? struct aspeed_wdt_config {
>>>> ????? u32 ext_pulse_width_mask;
>>>> +??? u32 irq_shift;
>>>> +??? u32 irq_mask;
>>>> ? };
>>>> ? static const struct aspeed_wdt_config ast2400_config = {
>>>> ????? .ext_pulse_width_mask = 0xff,
>>>> +??? .irq_shift = 0,
>>>> +??? .irq_mask = 0,
>>>> ? };
>>>> ? static const struct aspeed_wdt_config ast2500_config = {
>>>> ????? .ext_pulse_width_mask = 0xfffff,
>>>> +??? .irq_shift = 12,
>>>> +??? .irq_mask = GENMASK(31, 12),
>>>> +};
>>>> +
>>>> +static const struct aspeed_wdt_config ast2600_config = {
>>>> +??? .ext_pulse_width_mask = 0xfffff,
>>>> +??? .irq_shift = 0,
>>>> +??? .irq_mask = GENMASK(31, 10),
>>>> ? };
>>>> ? static const struct of_device_id aspeed_wdt_of_table[] = {
>>>> ????? { .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>>>> ????? { .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
>>>> -??? { .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
>>>> +??? { .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>>>> ????? { },
>>>> ? };
>>>> ? MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>>> @@ -58,6 +73,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>>> ? #define?? WDT_CTRL_RESET_SYSTEM??????? BIT(1)
>>>> ? #define?? WDT_CTRL_ENABLE??????? BIT(0)
>>>> ? #define WDT_TIMEOUT_STATUS??? 0x10
>>>> +#define?? WDT_TIMEOUT_STATUS_IRQ??????? BIT(2)
>>>> ? #define?? WDT_TIMEOUT_STATUS_BOOT_SECONDARY??? BIT(1)
>>>> ? #define WDT_CLEAR_TIMEOUT_STATUS??? 0x14
>>>> ? #define?? WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION BIT(0)
>>>> @@ -243,6 +259,17 @@ static const struct watchdog_info 
>>>> aspeed_wdt_info = {
>>>> ????? .identity??? = KBUILD_MODNAME,
>>>> ? };
>>>> +static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
>>>> +{
>>>> +??? struct aspeed_wdt *wdt = arg;
>>>> +??? u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>>>> +
>>>> +??? if (status & WDT_TIMEOUT_STATUS_IRQ)
>>>> +??????? panic("Watchdog pre-timeout IRQ");
>>>> +
>>>> +??? return IRQ_NONE;
>>>> +}
>>>> +
>>>> ? static int aspeed_wdt_probe(struct platform_device *pdev)
>>>> ? {
>>>> ????? struct device *dev = &pdev->dev;
>>>> @@ -253,6 +280,7 @@ static int aspeed_wdt_probe(struct 
>>>> platform_device *pdev)
>>>> ????? const char *reset_type;
>>>> ????? u32 duration;
>>>> ????? u32 status;
>>>> +??? u32 timeout = 0;
>>>> ????? int ret;
>>>> ????? wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>>> @@ -291,6 +319,27 @@ static int aspeed_wdt_probe(struct 
>>>> platform_device *pdev)
>>>> ????? if (of_device_is_compatible(np, "aspeed,ast2400-wdt"))
>>>> ????????? wdt->ctrl = WDT_CTRL_1MHZ_CLK;
>>>> +??? if (config->irq_mask) {
>>>> +??????? if (!of_property_read_u32(np, "aspeed,pre-timeout-irq-us", 
>>>> &timeout) && timeout) {
>>>> +??????????? int irq =? platform_get_irq(pdev, 0);
>>>> +
>>>> +??????????? if (irq < 0) {
>>>> +??????????????? dev_warn(dev, "Couldn't find IRQ: %d\n", irq);
>>>> +??????????????? timeout = 0;
>>>> +??????????? } else {
>>>> +??????????????? ret = devm_request_irq(dev, irq, aspeed_wdt_irq, 
>>>> IRQF_SHARED,
>>>> +?????????????????????????????? dev_name(dev), wdt);
>>>> +??????????????? if (ret) {
>>>> +??????????????????? dev_warn(dev, "Couldn't request IRQ:%d\n", ret);
>>>> +??????????????????? timeout = 0;
>>>> +??????????????? } else {
>>>> +??????????????????? wdt->ctrl |= ((timeout << config->irq_shift) &
>>>> +????????????????????????????? config->irq_mask) | WDT_CTRL_WDT_INTR;
>>>> +??????????????? }
>>>> +??????????? }
>>>> +??????? }
>>>> +??? }
>>>> +
>>>> ????? /*
>>>> ?????? * Control reset on a per-device basis to ensure the
>>>> ?????? * host is not affected by a BMC reboot
>>>> @@ -308,7 +357,7 @@ static int aspeed_wdt_probe(struct 
>>>> platform_device *pdev)
>>>> ????????? else if (!strcmp(reset_type, "system"))
>>>> ????????????? wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
>>>> ?????????????????????? WDT_CTRL_RESET_SYSTEM;
>>>> -??????? else if (strcmp(reset_type, "none"))
>>>> +??????? else if (strcmp(reset_type, "none") && !timeout)
>>>> ????????????? return -EINVAL;
>>>> ????? }
>>>> ????? if (of_property_read_bool(np, "aspeed,external-signal"))
>>>> -- 
>>>> 2.31.1
>>>>
>
