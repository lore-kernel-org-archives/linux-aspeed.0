From: Frank Rowand <frowand.list@gmail.com>
Date: Fri, 8 Oct 2021 14:43:37 -0500
Subject: [PATCH 0/9] Dynamic DT device nodes
In-Reply-To: <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
 <YV64ZbcsHvBObH2j@hatter.bewilderbeest.net> <YV7Miz9RMMx/17A0@kroah.com>
 <YV8VGeMreR6NJad4@hatter.bewilderbeest.net>
 <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
Message-ID: <662f6ff3-61b9-e1e6-5059-699edbb2ab1c@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/7/21 3:03 PM, Rob Herring wrote:
> On Thu, Oct 7, 2021 at 10:41 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> On Thu, Oct 07, 2021 at 03:31:39AM PDT, Greg Kroah-Hartman wrote:
>>> On Thu, Oct 07, 2021 at 02:05:41AM -0700, Zev Weiss wrote:
>>>> On Thu, Oct 07, 2021 at 12:04:41AM PDT, Andy Shevchenko wrote:
>>>>> On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>>>>>> This patch series is in some ways kind of a v2 for the "Dynamic
>>>>>> aspeed-smc flash chips via 'reserved' DT status" series I posted
>>>>>> previously [0], but takes a fairly different approach suggested by Rob
>>>>>> Herring [1] and doesn't actually touch the aspeed-smc driver or
>>>>>> anything in the MTD subsystem, so I haven't marked it as such.
>>>>>>
>>>>>> To recap a bit of the context from that series, in OpenBMC there's a
>>>>>> need for certain devices (described by device-tree nodes) to be able
>>>>>> to be attached and detached at runtime (for example the SPI flash for
>>>>>> the host's firmware, which is shared between the BMC and the host but
>>>>>> can only be accessed by one or the other at a time).
>>>>>
>>>>> This seems quite dangerous. Why do you need that?
>>>>
>>>> Sometimes the host needs access to the flash (it's the host's firmware,
>>>> after all), sometimes the BMC needs access to it (e.g. to perform an
>>>> out-of-band update to the host's firmware).  To achieve the latter, the
>>>> flash needs to be attached to the BMC, but that requires some careful
>>>> coordination with the host to arbitrate which one actually has access to it
>>>> (that coordination is handled by userspace, which then tells the kernel
>>>> explicitly when the flash should be attached and detached).
>>>>
>>>> What seems dangerous?
>>>>
>>>>> Why can't device tree overlays be used?
>>>>
>>>> I'm hoping to stay closer to mainline.  The OpenBMC kernel has a documented
>>>> policy strongly encouraging upstream-first development:
>>>> https://github.com/openbmc/docs/blob/master/kernel-development.md
>>>>
>>>> I doubt Joel (the OpenBMC kernel maintainer) would be eager to start
>>>> carrying the DT overlay patches; I'd likewise strongly prefer to avoid
>>>> carrying them myself as additional downstream patches.  Hence the attempt at
>>>> getting a solution to the problem upstream.
>>>
>>> Then why not work to get device tree overlays to be merged properly?
> 
> TBC, it's 'just' the general purpose userspace interface to apply
> overlays that's missing.

A fuller view of what is missing is at:

https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts#issues_and_what_needs_to_be_completed_--_Not_an_exhaustive_list


> 
> I did suggest what's done here as overlays are kind of an overkill for
> this usecase. Much easier to write to a sysfs file than write an
> overlay, compile it with dtc, and provide it to the kernel all just to
> enable a device.
> 
> Perhaps this could also be supported in the driver model directly.
> Given the "what about ACPI question", that is probably what should be
> done unless the answer is we don't care. I think we'd just need a flag
> to create devices, but not bind automatically. Or maybe abusing
> driver_override can accomplish that.
> 
>>> Don't work on a half-of-a-solution when the real solution is already
>>> here.
>>>
>>
>> I had been under the impression that the overlay patches had very dim
>> prospects of ever being accepted and that this might be a more tractable
>> alternative, but apparently was mistaken -- I'll look into what the
>> outstanding issues were with that and perhaps take a stab at addressing
>> them.
> 

> What's dim is the patches allowing any modification to any part of the
> DT. Any changes to a DT need to work (i.e. have some effect). For
> example, randomly changing/adding/removing properties wouldn't have
> any effect because they've probably already be read and used.

Yes, that is a good description.

> 
> What I've suggested before is some sort of registration of nodes
> allowed to apply child nodes and properties to. That would serve the
> add-on board usecases which have been the main driver of this to date.
> That also got hung up on defining interface nodes to add-on boards.
> Your scope is more limited and can be limited to that scope while
> using the same configfs interface.
> 
> Rob
> 

