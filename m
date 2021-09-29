From: Zev Weiss <zweiss@equinix.com>
Date: Wed, 29 Sep 2021 22:00:39 +0000
Subject: [PATCH 0/6] Dynamic aspeed-smc flash chips via "reserved" DT
 status
In-Reply-To: <CAL_JsqJH+b5oFuSP+KBLBsN5QTA6xASuqXJWXUaDkHhugXPpnQ@mail.gmail.com>
References: <20210929115409.21254-1-zev@bewilderbeest.net>
 <CAL_JsqJH+b5oFuSP+KBLBsN5QTA6xASuqXJWXUaDkHhugXPpnQ@mail.gmail.com>
Message-ID: <20210929220038.GS17315@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 29, 2021 at 09:08:03AM PDT, Rob Herring wrote:
>On Wed, Sep 29, 2021 at 6:54 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> Hello,
>>
>> This patch series aims to improve a scenario that arises in OpenBMC
>> and which isn't handled very well at the moment.  Certain devices, the
>> example at hand being the flash chip used to store the host's firmware
>> (e.g. the BIOS), may be shared between the BMC and the host system but
>> only available to one or the other at any given time.  The device may
>> thus be effectively off-limits to the BMC when it boots, and only
>> usable after userspace performs the necessary steps to coordinate
>> appropriately with the host (tracking its power state, twiddling
>> GPIOs, sending IPMI commands, etc.).
>>
>> Neither the "okay" nor the "disabled" device-tree status values works
>> nicely for the flash device this case -- an "okay" device gets probed
>> automatically as soon as the device and a driver for it are available,
>> and a "disabled" one gets forgotten about entirely, whereas we want
>> the BMC's kernel to be aware of the existence of the device, but not
>> try to actually do anything with it (i.e. probe it) until explicitly
>> requested to do so by userspace.
>
>While Linux treats 'disabled' as gone forever, that's not exactly what
>the spec says. Either disabled or reserved could change in theory. But
>I do agree 'reserved' is the right choice for your use.

True -- the spec's description of "disabled" also sounds like it could
be an appropriate fit for this case, but the existing (somewhat
different) interpretation in the kernel is well-established enough that
I figured that ship had sailed.

>
>> However, while there's no support for it currently in the kernel tree,
>> the device-tree spec [0] also lists "reserved" as a possible status
>> value, and its description seems like a fairly reasonable fit for this
>> situation:
>>
>>   Indicates that the device is operational, but should not be used.
>>   Typically this is used for devices that are controlled by another
>>   software component, such as platform firmware.
>>
>> These patches start making use of this status value in the aspeed-smc
>> driver.  The first patch adds a companion routine to
>> of_device_is_available() that checks for a "reserved" status instead
>> of "okay".  The second patch is a small MTD adjustment to allow an
>> unregistered device to be cleanly re-registered.  Patches 3 through 5
>> modify the aspeed-smc driver to allow individual chips to be attached
>> and detached at runtime, and to avoid automatically attaching any
>> marked as reserved.  Finally, patch 6 employs the newly-supported
>> status in adding support for the BIOS flash device to the ASRock Rack
>> e3c246d4i BMC.
>
>I'm not sure this should be MTD specific. There's other cases where we
>may want devices to become available. So the question is whether there
>should be a more generic mechanism rather than each subsystem coming
>up with their own thing.
>

Agreed, and in fact in an earlier version of these patches I had
approached this via a more generic tweak to the driver-core code to
inhibit attaching drivers to devices marked as reserved.  The problem I
had with that is that it ended up being kind of limited in how far down
the device tree it would actually take effect.  For example in this
particular case, I could mark the entire aspeed-smc controller as
reserved and prevent the driver core from binding the driver to it, but
nothing more fine-grained than that.  If I marked an individual flash
chip behind that controller as reserved, the aspeed-smc driver would get
attached (as expected), but that driver (not the driver core) is
responsible for inspecting its child devices and attaching them, and its
existing probe routine only checks of_device_is_available() and hence
can't distinguish between reserved and disabled.

So while I should probably reincorporate the corresponding driver-core
change, I don't see it as a complete solution, and I don't see an
obvious way to achieve one centrally without requiring modifications in
individual drivers, unfortunately.

>There's out of tree support for applying overlays which could be used
>here. The issue with it is we don't want it to be unconstrained where
>an overlay can make any change anywhere in a DT.
>

Yeah, I'm vaguely aware of the dt-overlay patches, but had been under
the impression that their prospects for mainlining were fairly dim and
hence was looking at alternate approaches (of somewhat more limited scope).

>Another possibility is making 'status' writeable from userspace. It is
>just a sysfs file. That too may need to be opt-in.
>

The sysfs file you're referring to being those under
/sys/firmware/devicetree I assume?  That's an interesting idea...in
addition to making it opt-in, we'd presumably need to restrict what
state transitions are allowed (maybe only okay<->reserved?).  Keeping
/sys/firmware/fdt in sync with that seems like it might be a bit of a
headache though...perhaps that would just remain a static reflection of
whatever the state was at boot?


Thanks,
Zev
