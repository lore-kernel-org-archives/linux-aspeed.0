From: Rashmica Gupta <rashmica.g@gmail.com>
Date: Thu, 05 Sep 2019 09:22:14 +1000
Subject: [PATCH 4/4] gpio: Update documentation with ast2600 controllers
In-Reply-To: <CAMpxmJUGm3Zs8VHwHnXTQ2cKnpF0caR=7V4bBi1_sy1U2mWc0g@mail.gmail.com>
References: <20190904061245.30770-1-rashmica.g@gmail.com>
 <20190904061245.30770-4-rashmica.g@gmail.com>
 <CAMpxmJUGm3Zs8VHwHnXTQ2cKnpF0caR=7V4bBi1_sy1U2mWc0g@mail.gmail.com>
Message-ID: <8fdf5eb4fda343d0c4919436490df9935fbfc34d.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2019-09-04 at 09:02 +0200, Bartosz Golaszewski wrote:
> ?r., 4 wrz 2019 o 08:13 Rashmica Gupta <rashmica.g@gmail.com>
> napisa?(a):
> 
> Again, this needs a proper commit description 

I figured as similar patches have gone through with just the one line
and there isn't anything more to say that the one line message that
this would be ok.

>and the subject should
> start with "dt-bindings: ...".
> 
True.


> You also need to Cc the device-tree maintainers. Use
> scripts/get_maintainer.pl to list all people that should get this
> patch.

Must have missed that one somehow.

> 
> Bart
> 
> > Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/gpio-aspeed.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-
aspeed.txt 
> > b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> > index 7e9b586770b0..cd388797e07c 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> > @@ -2,7 +2,8 @@ Aspeed GPIO controller Device Tree Bindings
> >  -------------------------------------------
> > 
> >  Required properties:
> > -- compatible           : Either "aspeed,ast2400-gpio" or
> > "aspeed,ast2500-gpio"
> > +- compatible           : Either "aspeed,ast2400-gpio",
> > "aspeed,ast2500-gpio",
> > +                                         "aspeed,ast2600-gpio", or
> > "aspeed,ast2600-1-8v-gpio"
> > 
> >  - #gpio-cells          : Should be two
> >                           - First cell is the GPIO line number
> > --
> > 2.20.1
> > 

