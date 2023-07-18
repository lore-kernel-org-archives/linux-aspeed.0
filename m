From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 18 Jul 2023 08:39:05 +0200
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
References: <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
 <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
 <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
 <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
 <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
Message-ID: <ZLYziWcIWcNnzMXR@orome>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 18, 2023 at 08:04:24AM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2023 06:01, ??? wrote:
> >>
> >> On 17/07/2023 11:01, ??? wrote:
> >>> Guenter Roeck <linux@roeck-us.net> ? 2023?7?17? ?? ??1:00???
> >>>>
> >>>> On 7/16/23 09:08, Krzysztof Kozlowski wrote:
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>>>
> >>>>>> This patch serial doesn't use to binding the fan control h/w. It is
> >>>>>> used to binding the two independent h/w blocks.
> >>>>>> One is used to provide pwm output and another is used to monitor the
> >>>>>> speed of the input.
> >>>>>> My patch is used to point out that the pwm and the tach is the
> >>>>>> different function and don't need to
> >>>>>> bind together. You can not only combine them as the fan usage but also
> >>>>>> treat them as the individual module for
> >>>>>> use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
> >>>>>> tach can be used to monitor the heart beat signal.
> >>>>>
> >>>>> Isn't this exactly the same as in every other SoC? PWMs can be used in
> >>>>> different ways?
> >>>>>
> >>>>
> >>>> ... and in every fan controller. Not that it really makes sense because
> >>>> normally the pwm controller part of such chips is tied to the fan input,
> >>>> to enable automatic fan control, but it is technically possible.
> >>>> In many cases this is also the case in SoCs, for example, in ast2500.
> >>>> Apparently this was redesigned in ast2600 where they two blocks are
> >>>> only lightly coupled (there are two pwm status bits in the fan status
> >>>> register, but I have no idea what those mean). If the blocks are tightly
> >>>> coupled, separate drivers don't really make sense.
> >>>>
> >>>> There are multiple ways to separate the pwm controller part from the
> >>>> fan inputs if that is really necessary. One would be to provide a
> >>>> sequence of address mappings, the other would be to pass the memory
> >>>> region from an mfd driver. It is not necessary to have N instances
> >>>> of the fan controller, even if the address space is not continuous.
> >>>>
> >>>
> >>> Hi Guenter,
> >>>
> >>> May I ask about the meaning of the sequence of address mappings? It appears
> >>> to consist of multiple tuples within the 'reg' property, indicating
> >>> the usage of PWM/Tach
> >>> registers within a single instance. After that I can use the dts like following:
> >>>
> >>> pwm: pwm at 1e610000 {
> >>> ...
> >>> reg = <0x1e610000 0x8
> >>> 0x1e610010 0x8
> >>> 0x1e610020 0x8
> >>> 0x1e610030 0x8
> >>> 0x1e610040 0x8
> >>> 0x1e610050 0x8
> >>> 0x1e610060 0x8
> >>> 0x1e610070 0x8
> >>> 0x1e610080 0x8
> >>> 0x1e610090 0x8
> >>> 0x1e6100A0 0x8
> >>> 0x1e6100B0 0x8
> >>> 0x1e6100C0 0x8
> >>> 0x1e6100D0 0x8
> >>> 0x1e6100E0 0x8
> >>> 0x1e6100F0 0x8>;
> >>
> >>
> >> Uh, no... I mean, why? We keep pointing out that this should not be done
> >> differently than any other SoC. Open any other SoC PWM controller and
> >> tell me why this is different? Why this cannot be one address space?
> > 
> > Hi Krzysztof,
> > 
> > This is because the register layout for PWM and Tach is not continuous.
> > Each PWM/Tach instance has its own set of controller registers, and they
> > are independent of each other.
> 
> Register layout is not continuous in many other devices, so again - why
> this must be different?
> 
> > 
> > For example:
> > PWM0 uses registers 0x0 and 0x4, while Tach0 uses registers 0x8 and 0xc.
> > PWM1 uses registers 0x10 and 0x14, while Tach1 uses registers 0x18 and 0x1c.
> > ...
> > 
> > To separate the PWM controller part from the fan inputs, Guenter has
> > provided two methods.
> > The first method involves passing the memory region from an MFD
> > driver, which was the
> 
> I have no clue how can you pass memory region
> (Documentation/devicetree/bindings/reserved-memory/) from MFD and why
> does it make sense here.
> 
> > initial method I intended to use. However, it seems that this method
> > does not make sense to you.
> > 
> > Therefore, I would like to explore the second method suggested by
> > Guenter, which involves providing
> > a sequence of address mappings.

At the risk of saying what others have said: given that there's a single
reset line and a single clock line controlling all of these channels and
given what I recall of how address demuxers work in chips, everything
indicates that this is a single hardware block/device.

So the way that this should be described in DT is:

	pwm at 1e610000 {
		reg = <0x1e610000 0x100>;
		clocks = ...;
		resets = ...
	};

That'd be the most accurate representation of this hardware in DT. It is
then up to the driver to expose this in any way you see fit. For Linux
it may make sense to expose this as 16 PWM channels and 16 hardware
monitoring devices. Other operating systems using the same DT may choose
to expose this differently, depending on their frameworks, etc. A simple
operating system may not expose this as separate resources at all but
instead directly program individual registers from this block.

I'd also like to add that I think trying to split this up into multiple
drivers in Linux is a bit overkill. In my opinion, though I know not
everyone shares this view, it's perfectly fine for one driver to expose
multiple types of resources. There's plenty of use-cases across the
kernel where tightly coupled devices like this have a single driver that
registers with multiple subsystems. Going through MFD only because this
particular hardware doesn't split registers nicely along Linux subsystem
boundaries.

So FWIW, I'm fine carrying hwmon code in a PWM driver and I'm equally
fine if PWM code ends up in a hwmon driver (or any other subsystem
really) if that makes sense for a given hardware.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230718/1249c306/attachment.sig>
