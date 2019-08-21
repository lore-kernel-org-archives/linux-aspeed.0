From: Alexander Amelkin <a.amelkin@yadro.com>
Date: Wed, 21 Aug 2019 20:42:24 +0300
Subject: [PATCH 3/3] watchdog/aspeed: add support for dual boot
In-Reply-To: <20190821163220.GA11547@roeck-us.net>
References: <1f2cd155057e5ab0cdb20a9a11614bbb09bb49ad.camel@yadro.com>
 <20190821163220.GA11547@roeck-us.net>
Message-ID: <9e7fe5cc-ba1b-b8b6-69c5-c3c6cf508a36@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

21.08.2019 19:32, Guenter Roeck wrote:
> On Wed, Aug 21, 2019 at 06:57:43PM +0300, Ivan Mikhaylov wrote:
>> Set WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION into WDT_CLEAR_TIMEOUT_STATUS
>> to clear out boot code source and re-enable access to the primary SPI flash
>> chip while booted via wdt2 from the alternate chip.
>>
>> AST2400 datasheet says:
>> "In the 2nd flash booting mode, all the address mapping to CS0# would be
>> re-directed to CS1#. And CS0# is not accessable under this mode. To access
>> CS0#, firmware should clear the 2nd boot mode register in the WDT2 status
>> register WDT30.bit[1]."
> Is there reason to not do this automatically when loading the module
> in alt-boot mode ? What means does userspace have to determine if CS0
> or CS1 is active at any given time ? If there is reason to ever have CS1
> active instead of CS0, what means would userspace have to enable it ?

Yes, there is. The driver is loaded long before the filesystems are mounted. The filesystems, in the event of alternate/recovery boot, need to be mounted from the same chip that the kernel was booted. For one reason because the main chip at CS0 is most probably corrupt. If you clear that bit when driver is loaded, your software will not know that and will try to mount the wrong filesystems. The whole idea of ASPEED's switching chipselects is to have identical firmware in both chips, without the need to process the alternate boot state in any way except for indicating a successful boot and restoring access to CS0 when needed.

The userspace can read bootstatus sysfs node to determine if an alternate boot has occured.

With ASPEED, CS1 is activated automatically by wdt2 when system fails to boot from the primary flash chip (at CS0) and disable the watchdog to indicate a successful boot. When that happens, both CS0 and CS1 controls? get routed in hardware to CS1 line, making the primary flash chip inaccessible. Depending on the architecture of the user-space software, it may choose to re-enable access to the primary chip via CS0 at different times. There must be a way to do so.

> If userspace can not really determine if CS1 or CS0 is active, all it could
> ever do was to enable CS0 to be in a deterministic state. If so, it doesn't
> make sense to ever have CS1 active, and re-enabling CS0 could be automatic.
>
> Similar, if CS1 can ever be enabled, there is no means for userspace to ensure
> that some other application did not re-enable CS0 while it believes that CS1
> is enabled. If there is no means for userspace to enable CS1, it can never be
> sure what is enabled (because some other entity may have enabled CS0 while
> userspace just thought that CS1 is still enabled). Again, the only means
> to guarantee a well defined state would be to explicitly enable CS0 and provive
> no means to enable CS1. Again, this could be done during boot, not requiring
> an explicit request from userspace.

Please understand that activation of CS1 in place of CS0 is NOT a software choice!


>> +	if (unlikely(!wdt))
>> +		return -ENODEV;
>> +
> How would this ever happen, and how / where is drvdata set to NULL ?

This is purely for robustness. Seeing a pointer obtained via a function accessed without first checking it for validity makes me nervous.

This code most probably adds nothing at the assembly level.

>
>> +	writel(WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION,
>> +			wdt->base + WDT_CLEAR_TIMEOUT_STATUS);
>> +	wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> The variable reflects the _boot status_. It should not change after booting.
Is there any documentation that dictates that? All I could find is

"bootstatus: status of the device after booting". That doesn't look to me like it absolutely can not change to reflect the updated status (that is, to reflect that the originally set up alternate CS routing has been reset to normal).

If you absolutely disallow that, I think we could make 'access_cs0' readable instead, so it could report the current state of the boot code selection bit. Reverted, I suppose. That way 'access_cs0' would report 1 after 1 has been written to it (it wouldn't be possible to write a zero).

> @@ -223,6 +248,9 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  
>  	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
>  
> +	if (of_property_read_bool(np, "aspeed,alt-boot"))
> +		wdt->wdd.groups = bswitch_groups;
> +
> Why does this have to be separate to the existing evaluation of
> aspeed,alt-boot, and why does the existing code not work ?
>
> Also, is it guaranteed that this does not interfer with existing
> support for alt-boot ?

I think Ivan will comment on this.

With best regards,
Alexander Amelkin,
BIOS/BMC Team Lead, YADRO
https://yadro.com


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190821/a5922211/attachment-0001.sig>
