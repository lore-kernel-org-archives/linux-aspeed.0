From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 24 Sep 2021 08:41:21 +0200
Subject: [PATCH 0/2] leds: pca955x: Expose GPIOs for all pins
In-Reply-To: <20210921043936.468001-1-andrew@aj.id.au>
References: <20210921043936.468001-1-andrew@aj.id.au>
Message-ID: <d2b85ad7-aef7-6088-03f5-cbd6e0bcab5d@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/21/21 06:39, Andrew Jeffery wrote:
> Hello,
> 
> This is a rework of a Rube Goldberg-inspired RFC I posted previously:
> 
> https://lore.kernel.org/lkml/20210723075858.376378-1-andrew at aj.id.au/
> 
> This time around there's a lot less Rube - the series:
> 
> 1. Contains no (ab)use of pinctrl
> 2. Always exposes all pins as GPIOs
> 3. Internally tracks the active pins
> 
> Without these patches the driver limits the number of pins exposed on
> the gpiochip to the number of pins specified as GPIO in the devicetree,
> but doesn't map between the GPIO and pin number spaces. The result is
> that specifying offset or interleaved GPIOs in the devicetree gives
> unexpected behaviour in userspace.
> 
> By always exposing all pins as GPIOs the patches resolve the lack of
> mapping between GPIO offsets and pins on the package in the driver by
> ensuring we always have a 1-to-1 mapping.
> 
> The issue is primarily addressed by patch 1/2. Patch 2/2 makes it
> possible to not expose any pins as LEDs (and therefore make them all
> accessible as GPIOs). This has a follow-on effect of allowing the driver
> to bind to a device instantiated at runtime without requiring a
> description in the devicetree.
> 
> I've tested the series under qemu to inspect the various interactions
> between LEDs vs GPIOs as well as conflicting GPIO requests.

I was wondering what kind of tests you did.

Did you cold plug 'pca995x' devices in a QEMU Aspeed EVB* machine running
with a custom DTB adding different layouts of the pca955x ?

> Please review!

This is simpler than the 'ngpio' business we had before.

Reviewed-by: C?dric Le Goater <clg@kaod.org>

Thanks,

C.


> Andrew
> 
> Andrew Jeffery (2):
>    leds: pca955x: Make the gpiochip always expose all pins
>    leds: pca955x: Allow zero LEDs to be specified
> 
>   drivers/leds/leds-pca955x.c | 65 +++++++++++++++++++------------------
>   1 file changed, 34 insertions(+), 31 deletions(-)
> 
> 
> base-commit: 239f32b4f161c1584cd4b386d6ab8766432a6ede
> 

