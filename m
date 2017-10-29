From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 30 Oct 2017 10:26:26 +1030
Subject: [PATCH 1/2] gpio: gpiolib: Expand sleep tolerance to include
 controller reset
In-Reply-To: <20171026090318.uv6lvmkt4injiihc@localhost.localdomain>
References: <20171025050417.27992-1-andrew@aj.id.au>
 <20171025050417.27992-2-andrew@aj.id.au>
 <20171025083201.wdudlzgphypyhmwc@localhost.localdomain>
 <1508978453.13477.7.camel@aj.id.au>
 <20171026090318.uv6lvmkt4injiihc@localhost.localdomain>
Message-ID: <1509321386.13477.13.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-10-26 at 10:03 +0100, Charles Keepax wrote:
> On Thu, Oct 26, 2017 at 11:10:53AM +1030, Andrew Jeffery wrote:
> > On Wed, 2017-10-25 at 09:32 +0100, Charles Keepax wrote:
> > > On Wed, Oct 25, 2017 at 03:34:16PM +1030, Andrew Jeffery wrote:
> > > This means that if we have a set_config we are directly
> > > equating PERSISTENT to RESET_TOLERANT, which seems wrong to
> > > me. I might have a GPIO on a controller with pinconf that
> > > doesn't have anything to do with RESET_TOLERANT. Should the
> > > PIN_CONFIG_RESET_TOLERANT, really just be PIN_CONFIG_PERSISTENT?
> > > And then its upto the driver what persistence means for that
> > > chip?
> > 
> > Right, maybe I'm tying the design in a bit too closely with the Aspeed hardware
> > again. I'm coming out in favour of changing it based on my thoughts below.
> > 
> > However, I want to understand whether there are alternatives to reset tolerance
> > as a property. The obvious one is sleep persistence as implemented in the
> > Arizona driver, but it didn't take the set_config() route with its initial
> > implementation.
> > 
> > The set_config() approach was largely driven by the sysfs patch in
> > the RFC series, because I wanted a way to propagate the desired property
> > to hardware without affecting (or again calling through the handlers for) the
> > export state or direction. It seemed to come out neat enough in general so I
> > kept it.
> > 
> > Were you thinking of using set_config() to control the Arizona's behaviour and
> > do something other than the calls to gpiochip_line_is_persistent() in
> > arizona_gpio_direction_{in,out}() (as in, keep the state inside the device
> > driver rather than querying gpiolib where the state is currently stored)? That
> > would seem neat in that it gives us one method of setting both persistence
> > types (and in this case I should rename the pinconf parameter). With that we
> > could probably get rid of gpiochip_line_is_persistent(). A small downside is
> > some duplicated state (we probably still want to keep FLAG_TRANSITORY in
> > gpiolib).
> > 
> > Would it be reasonable for other drivers to implement sleep persistence in the
> > same manner as the Arizona driver currently does? If that's the case, I don't
> > think there is a third tolerance option in addition to sleep and reset, and so
> > we might not need to rename the pinconf parameter.
> > 
> > Finally, we could implement reset persistence in the same manner as the
> > Arizona's sleep persistence (with gpiochip_line_is_persistent()) given the
> > sysfs patch has been thrown away.
> > 
> > So to summarise, having rambled a bit, I see the situation as:
> > 
> > 1. Rename the pinconf parameter, and patch the Arizona driver to use
> >    set_config() and hold sleep persistence state internally.
> > 2. Drop the pinconf parameter and do something similar to the Arizona's sleep
> >    persistence for reset persistence in the Aspeed driver.
> > 3. Keep things as proposed are and live with two approaches to persistence
> > 
> > Point 3 seems like the least desirable. I'm leaning towards 1. I could probably
> > live with 2. after experimenting with it and confirming it's workable for me.
> > 
> > If you think 1. is the way to go are you happy for me to send a patch to the
> > Arizona driver implementing the change?
> > 
> 
> I guess the design was more playing to the fact that in the
> Arizona case we arn't really setting any register bit for the
> persisence, we are just not letting the CODEC power down whilst
> the GPIO is in use. The config approach does make more sense in
> the case where you are actually setting register bits.
> 
> I don't have any great objection to keeping the persistence state
> in the Arizona GPIO driver, but it does seem to be duplicating
> the state a little. Also an early version of the patch chain did
> that and we decided it would better in the core.
> 
> I am not opposed to option 3 either. For example open-drain has
> a similar setup where there is a pin config option for it and
> also a GPIO function call to check for its presence on a specific
> GPIO. Certainly my objection was just that we were equating the
> very generic property to a very specific pinconf.
> 
> I think I would probably be keen to see what Linus's thoughts
> are, but my feelings are really your patch is probably good if we
> just rename the RESET_TOLERANT pinconf to something a little more
> generic.

Okay, well in that case I'll do the rename and send out the patches, it
is simple enough. Thanks again for your feedback.

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20171030/ed6e8bba/attachment.sig>
