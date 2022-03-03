From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 03 Mar 2022 11:00:11 +1030
Subject: [PATCH 0/2] leds: pca955x: Expose GPIOs for all pins
In-Reply-To: <20220302085432.GA11054@duo.ucw.cz>
References: <20210921043936.468001-1-andrew@aj.id.au>
 <d2b85ad7-aef7-6088-03f5-cbd6e0bcab5d@kaod.org>
 <CACPK8Xdvns7PK9t1ZutAbkJqhb5eRcoWCDySQGsfbtLv+XMvqQ@mail.gmail.com>
 <20220302085432.GA11054@duo.ucw.cz>
Message-ID: <a42db25f-33af-4232-9acd-815f7b116c71@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 2 Mar 2022, at 19:24, Pavel Machek wrote:
> Hi!
>
>> > > Without these patches the driver limits the number of pins exposed on
>> > > the gpiochip to the number of pins specified as GPIO in the devicetree,
>> > > but doesn't map between the GPIO and pin number spaces. The result is
>> > > that specifying offset or interleaved GPIOs in the devicetree gives
>> > > unexpected behaviour in userspace.
>> > >
>> > > By always exposing all pins as GPIOs the patches resolve the lack of
>> > > mapping between GPIO offsets and pins on the package in the driver by
>> > > ensuring we always have a 1-to-1 mapping.
>> > >
>> > > The issue is primarily addressed by patch 1/2. Patch 2/2 makes it
>> > > possible to not expose any pins as LEDs (and therefore make them all
>> > > accessible as GPIOs). This has a follow-on effect of allowing the driver
>> > > to bind to a device instantiated at runtime without requiring a
>> > > description in the devicetree.
>> > >
>> > > I've tested the series under qemu to inspect the various interactions
>> > > between LEDs vs GPIOs as well as conflicting GPIO requests.
>> 
>> > > Please review!
>> >
>> > This is simpler than the 'ngpio' business we had before.
>> >
>> > Reviewed-by: C?dric Le Goater <clg@kaod.org>
>> 
>> I saw that you recently merged some LED patches. I was wondering if
>> you could consider this series for v5.18. It still applies cleanly,
>> and we've been running it for a while now, so it's very well tested.
>
> Thanks, applied. I must say this is really ninja-mutant driver, but I
> see no better way.
>
> +++ b/drivers/leds/leds-pca955x.c
> @@ -429,7 +429,7 @@ pca955x_get_pdata(struct i2c_client *client, struct 
> pca955x_chipdef *chip)
>         int count;
>
> This really should be unsigned. Care to fix/submit a patch?

I'll send a fix.

Andrew
