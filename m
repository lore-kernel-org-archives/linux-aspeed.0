From: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
Date: Fri, 29 May 2020 11:08:38 +0000
Subject: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent
 assignment
In-Reply-To: <20200529101608.GC19480@localhost>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
 <20200522082208.383631-4-alexandru.ardelean@analog.com>
 <20200529101608.GC19480@localhost>
Message-ID: <05500c815f4881a6aa86c809c5ac53e8af3f3e91.camel@analog.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-05-29 at 12:16 +0200, Johan Hovold wrote:
> [External]
> 
> On Fri, May 22, 2020 at 11:22:07AM +0300, Alexandru Ardelean wrote:
> > This assignment is the more peculiar of the bunch as it assigns the parent
> > of the platform-device's device (i.e. pdev->dev.parent) as the IIO device's
> > parent.
> > 
> > It's unclear whether this is intentional or not.
> > Hence it is in it's own patch.
> 
> Yeah, we have a few mfd drivers whose child drivers registers their
> class devices directly under the parent mfd device rather than the
> corresponding child platform device.
> 
> Since it's done consistently I think you need to update them all if you
> really want to change this. 
> 
> And it may not be worth it since at least in theory someone could now be
> relying on this topology.

Thanks for the feedback.
I guess, it could make sense to do here:
      devm_iio_device_alloc(pdev->dev.parent, ...)

Currently it's:
      devm_iio_device_alloc(&pdev->dev, ...)

That would make it slightly more consistent.
i.e. the life-time of the object would be attached to the parent of the platform
device, versus the platform-device.

Currently, as it is, the allocation [of the IIO device] is tied the platform-
device, and the IIO registration to the parent (of the platform-device).
I'm not super-familiar with the internals here, but does this sound a bit wrong?
Is there a chance where the IIO device could be de-allocated, while registered?


> 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/light/lm3533-als.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> > index bc196c212881..0f380ec8d30c 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
> > @@ -852,7 +852,6 @@ static int lm3533_als_probe(struct platform_device
> > *pdev)
> >  	indio_dev->channels = lm3533_als_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
> >  	indio_dev->name = dev_name(&pdev->dev);
> > -	indio_dev->dev.parent = pdev->dev.parent;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> >  	als = iio_priv(indio_dev);
> 
> Johan
