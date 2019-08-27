From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 27 Aug 2019 06:06:30 -0700
Subject: [PATCH v2 3/4] watchdog/aspeed: add support for dual boot
In-Reply-To: <818746d20661b51914a7802dcbe0081352900b05.camel@yadro.com>
References: <20190826104636.19324-1-i.mikhaylov@yadro.com>
 <20190826104636.19324-4-i.mikhaylov@yadro.com>
 <0df27d36-b45f-2059-6ead-a09ceb4b7605@roeck-us.net>
 <818746d20661b51914a7802dcbe0081352900b05.camel@yadro.com>
Message-ID: <d46685d9-c6d2-46af-67aa-844d2b0296a9@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 8/27/19 2:24 AM, Ivan Mikhaylov wrote:
> On Mon, 2019-08-26 at 17:14 -0700, Guenter Roeck wrote:
>>> +/*
>>> + * At alternate side the 'access_cs0' sysfs node provides:
>>> + *   ast2400: a way to get access to the primary SPI flash chip at CS0
>>> + *            after booting from the alternate chip at CS1.
>>> + *   ast2500: a way to restore the normal address mapping from
>>> + *            (CS0->CS1, CS1->CS0) to (CS0->CS0, CS1->CS1).
>>> + *
>>> + * Clearing the boot code selection and timeout counter also resets to the
>>> + * initial state the chip select line mapping. When the SoC is in normal
>>> + * mapping state (i.e. booted from CS0), clearing those bits does nothing
>>> for
>>> + * both versions of the SoC. For alternate boot mode (booted from CS1 due
>>> to
>>> + * wdt2 expiration) the behavior differs as described above.
>>> + *
>> The above needs to be in the sysfs attribute documentation as well.
> 
> My apologies but I didn't find any suitable, only watchdog parameters with
> dtbindings file, where should I put it? Documentation/watchdog/aspeed-wdt-
> sysfs.rst?
> 

Documentation/ABI/testing/sysfs-class-watchdog

Guenter

>>> + * This option can be used with wdt2 (watchdog1) only.
>>
>> This implies a specific watchdog numbering which is not guaranteed.
>> Someone might implement a system with some external watchdog.
>>
>>> + */
>>> +static DEVICE_ATTR_RW(access_cs0);
>>> +
>>> +static struct attribute *bswitch_attrs[] = {
>>> +	&dev_attr_access_cs0.attr,
>>> +	NULL
>>> +};
>>> +ATTRIBUTE_GROUPS(bswitch);
>>> +
>>>    static const struct watchdog_ops aspeed_wdt_ops = {
>>>    	.start		= aspeed_wdt_start,
>>>    	.stop		= aspeed_wdt_stop,
>>> @@ -306,9 +359,16 @@ static int aspeed_wdt_probe(struct platform_device
>>> *pdev)
>>>    	}
>>>    
>>>    	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>>> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
>>> +	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
>>>    		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>>>    
>>> +		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
>>> +			of_device_is_compatible(np, "aspeed,ast2500-wdt"))
>>> +			wdt->wdd.groups = bswitch_groups;
> 
>> Kind of odd that the attribute only exists if the system booted from the
>> second flash, but if that is what you want I won't object. Just make sure
>> that this is explained properly.
> Perhaps dts configuration option would be better solution for it then? "force-
> cs0-switch" as example? Also, if it would be an option, dtbindings/wdt file for

You said earlier that this can not be done automatically but _must_ be done
from user space after the system has booted. Otherwise you could just
automatically switch to cs0 when the driver probes.

As I said, all I am asking for is proper documentation.

Guenter

> documentation will be the right place for it. Usage of this at side 0 will not
> get any good/bad results, it just makes user confused, so I decided to put it
> only at side 1. It works only for ast2400/2500 board unfortunately, for 2600
> there is big difference in switching mechanism. Any other thoughts how to make
> it better?
> 
> Thanks.
> 
> 

