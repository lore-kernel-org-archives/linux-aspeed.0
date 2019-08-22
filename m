From: Alexander Amelkin <a.amelkin@yadro.com>
Date: Thu, 22 Aug 2019 17:36:21 +0300
Subject: [PATCH 3/3] watchdog/aspeed: add support for dual boot
In-Reply-To: <20190821181008.GB15127@roeck-us.net>
References: <1f2cd155057e5ab0cdb20a9a11614bbb09bb49ad.camel@yadro.com>
 <20190821163220.GA11547@roeck-us.net>
 <9e7fe5cc-ba1b-b8b6-69c5-c3c6cf508a36@yadro.com>
 <20190821181008.GB15127@roeck-us.net>
Message-ID: <5cb20f52-884a-b921-c904-ebf244092318@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

21.08.2019 21:10, Guenter Roeck wrote:
> On Wed, Aug 21, 2019 at 08:42:24PM +0300, Alexander Amelkin wrote:
>> 21.08.2019 19:32, Guenter Roeck wrote:
>>> On Wed, Aug 21, 2019 at 06:57:43PM +0300, Ivan Mikhaylov wrote:
>>>> Set WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION into WDT_CLEAR_TIMEOUT_STATUS
>>>> to clear out boot code source and re-enable access to the primary SPI flash
>>>> chip while booted via wdt2 from the alternate chip.
>>>>
>>>> AST2400 datasheet says:
>>>> "In the 2nd flash booting mode, all the address mapping to CS0# would be
>>>> re-directed to CS1#. And CS0# is not accessable under this mode. To access
>>>> CS0#, firmware should clear the 2nd boot mode register in the WDT2 status
>>>> register WDT30.bit[1]."
>>> Is there reason to not do this automatically when loading the module
>>> in alt-boot mode ? What means does userspace have to determine if CS0
>>> or CS1 is active at any given time ? If there is reason to ever have CS1
>>> active instead of CS0, what means would userspace have to enable it ?
>> Yes, there is. The driver is loaded long before the filesystems are mounted.
>> The filesystems, in the event of alternate/recovery boot, need to be mounted
>> from the same chip that the kernel was booted. For one reason because the main
>> chip at CS0 is most probably corrupt. If you clear that bit when driver is
>> loaded, your software will not know that and will try to mount the wrong
>> filesystems. The whole idea of ASPEED's switching chipselects is to have
>> identical firmware in both chips, without the need to process the alternate
>> boot state in any way except for indicating a successful boot and restoring
>> access to CS0 when needed.
>>
>> The userspace can read bootstatus sysfs node to determine if an alternate
>> boot has occured.
>>
>> With ASPEED, CS1 is activated automatically by wdt2 when system fails to boot
>> from the primary flash chip (at CS0) and disable the watchdog to indicate a
>> successful boot. When that happens, both CS0 and CS1 controls? get routed in
>> hardware to CS1 line, making the primary flash chip inaccessible. Depending
>> on the architecture of the user-space software, it may choose to re-enable
>> access to the primary chip via CS0 at different times. There must be a way to do so.
>>
> So by activating cs0, userspace would essentially pull its own root file system
> from underneath itself ?

Exactly. That's why for alternate boot the firmware would usually copy
all filesystems to memory and mount from there. Some embedded systems
do that always, regardless of which chip they boot from.

However, to be able to recover the main flash chip, the system needs CS0
to function as such (not as CS1). That's why this control is needed.

As Ivan mentioned, for AST2500 and the upcoming AST2600 the behavior
is slightly different. They don't just connect both CS controls to CS1 but instead
swap them so the primary chip becomes secondary from the software point
of view. The means to restore the normal wiring may still be needed.

>
>> This code most probably adds nothing at the assembly level.
>>
> That seems quite unlikely. Please demonstrate.

Yes, you were right. It adds 7 instructions. We'll drop the check.
It's just my DO-178 background, I add 'robustness' checks everywhere.

>>>> +	writel(WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION,
>>>> +			wdt->base + WDT_CLEAR_TIMEOUT_STATUS);
>>>> +	wdt->wdd.bootstatus |= WDIOF_EXTERN1;
>>> The variable reflects the _boot status_. It should not change after booting.
>> Is there any documentation that dictates that? All I could find is
>>
>> "bootstatus: status of the device after booting". That doesn't look to me like it absolutely can not change to reflect the updated status (that is, to reflect that the originally set up alternate CS routing has been reset to normal).
>>
> You choose to interpret "after booting" in a kind of novel way,
> which I find a bit disturbing. I am not really sure how else to
> describe "boot status" in a way that does not permit such
> reinterpratation of the term.

How about "Reflects reasons that caused a reboot, remains constant until the next boot" ?

> On top of that, how specifically would "WDIOF_EXTERN1" reflect
> what you claim it does ? Not only you are hijacking bootstatus9
> (which is supposed to describe the reason for a reboot), you
> are also hijacking WDIOF_EXTERN1. That seems highly arbitrary
> to me, and is not really how an API/ABI should be used.

We used WDIOF_EXTERN1 because:

1. We thought that bootstatus _can_ change

2. We thought that adding extra bits wouldn't be appreciated

Now as you clarified that assumption 1 was wrong we are going to implement status as I proposed earlier:

>
>> I think we could make 'access_cs0' readable instead, so it could report the
>> current state of the boot code selection bit. Reverted, I suppose. That
>> way 'access_cs0' would report 1 after 1 has been written to it (it wouldn't
>> be possible to write a zero).

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190822/af7bb64c/attachment-0001.sig>
