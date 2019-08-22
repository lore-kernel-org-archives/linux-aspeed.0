From: Alexander Amelkin <a.amelkin@yadro.com>
Date: Thu, 22 Aug 2019 19:45:48 +0300
Subject: [PATCH 3/3] watchdog/aspeed: add support for dual boot
In-Reply-To: <20190822160127.GA6992@roeck-us.net>
References: <1f2cd155057e5ab0cdb20a9a11614bbb09bb49ad.camel@yadro.com>
 <20190821163220.GA11547@roeck-us.net>
 <9e7fe5cc-ba1b-b8b6-69c5-c3c6cf508a36@yadro.com>
 <20190821181008.GB15127@roeck-us.net>
 <5cb20f52-884a-b921-c904-ebf244092318@yadro.com>
 <20190822160127.GA6992@roeck-us.net>
Message-ID: <0bce44fc-0d03-511d-245a-8f867a6e067b@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

22.08.2019 19:01, Guenter Roeck wrote:
> On Thu, Aug 22, 2019 at 05:36:21PM +0300, Alexander Amelkin wrote:
>> 21.08.2019 21:10, Guenter Roeck wrote:
>>> On Wed, Aug 21, 2019 at 08:42:24PM +0300, Alexander Amelkin wrote:
>>>> 21.08.2019 19:32, Guenter Roeck wrote:
>>>>> On Wed, Aug 21, 2019 at 06:57:43PM +0300, Ivan Mikhaylov wrote:
>>>>>> Set WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION into WDT_CLEAR_TIMEOUT_STATUS
>>>>>> to clear out boot code source and re-enable access to the primary SPI flash
>>>>>> chip while booted via wdt2 from the alternate chip.
>>>>>>
>>>>>> AST2400 datasheet says:
>>>>>> "In the 2nd flash booting mode, all the address mapping to CS0# would be
>>>>>> re-directed to CS1#. And CS0# is not accessable under this mode. To access
>>>>>> CS0#, firmware should clear the 2nd boot mode register in the WDT2 status
>>>>>> register WDT30.bit[1]."
>>>>> Is there reason to not do this automatically when loading the module
>>>>> in alt-boot mode ? What means does userspace have to determine if CS0
>>>>> or CS1 is active at any given time ? If there is reason to ever have CS1
>>>>> active instead of CS0, what means would userspace have to enable it ?
>>>> Yes, there is. The driver is loaded long before the filesystems are mounted.
>>>> The filesystems, in the event of alternate/recovery boot, need to be mounted
>>>> from the same chip that the kernel was booted. For one reason because the main
>>>> chip at CS0 is most probably corrupt. If you clear that bit when driver is
>>>> loaded, your software will not know that and will try to mount the wrong
>>>> filesystems. The whole idea of ASPEED's switching chipselects is to have
>>>> identical firmware in both chips, without the need to process the alternate
>>>> boot state in any way except for indicating a successful boot and restoring
>>>> access to CS0 when needed.
>>>>
>>>> The userspace can read bootstatus sysfs node to determine if an alternate
>>>> boot has occured.
>>>>
>>>> With ASPEED, CS1 is activated automatically by wdt2 when system fails to boot
>>>> from the primary flash chip (at CS0) and disable the watchdog to indicate a
>>>> successful boot. When that happens, both CS0 and CS1 controls? get routed in
>>>> hardware to CS1 line, making the primary flash chip inaccessible. Depending
>>>> on the architecture of the user-space software, it may choose to re-enable
>>>> access to the primary chip via CS0 at different times. There must be a way to do so.
>>>>
>>> So by activating cs0, userspace would essentially pull its own root file system
>>> from underneath itself ?
>> Exactly. That's why for alternate boot the firmware would usually copy
>> all filesystems to memory and mount from there. Some embedded systems
>> do that always, regardless of which chip they boot from.
>>
> That is different, though, to what you said earlier. Linux would then start
> with a clean file system, and not need access to the file system in cs1 at all.
> Clearing the flag when starting the driver would then be ok.

I don't see how that is different. Copying to memory may be done by startup
scripts that run after the driver is loaded, so they need to read the data from
the chip they are booted from. That is how it is done in OpenBMC, for instance.
Other flavors of firmware may choose a different approach.
Having the control available via sysfs gives more flexibility.

>> However, to be able to recover the main flash chip, the system needs CS0
>> to function as such (not as CS1). That's why this control is needed.
>>
> If what you said is correct, not really. It should be fine and create more
> predictive behavior if the probe function selects cs0 automatically.

Well, this is not a function for home users. This is for servers. You won't
even find an ASPEED BMC chip in a home PC. Aspeed's dual-boot is quite
an advanced feature and people willing to use it are expected to be able
to predict the behavior. To me, as an embedded systems developer,
automatic selection of cs0 by probe is a limitation. I prefer flexibility.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190822/d6249274/attachment-0001.sig>
