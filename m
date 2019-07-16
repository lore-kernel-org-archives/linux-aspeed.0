From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 16 Jul 2019 10:09:55 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_dt-bindings:_pinctrl:_aspeed:_Fix_'compatible'_sch?=
 =?UTF-8?Q?ema_errors?=
In-Reply-To: <CACPK8Xdz98CQzgE2KCjz8eOhPtx=H8jTe1hVT7LvP77U_gGASQ@mail.gmail.com>
References: <20190715223725.12924-1-robh@kernel.org>
 <CACPK8Xdz98CQzgE2KCjz8eOhPtx=H8jTe1hVT7LvP77U_gGASQ@mail.gmail.com>
Message-ID: <ec16c833-371d-4dce-828d-dd99dccc43ee@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 16 Jul 2019, at 08:47, Joel Stanley wrote:
> On Mon, 15 Jul 2019 at 22:37, Rob Herring <robh@kernel.org> wrote:
> >
> > The Aspeed pinctl schema have errors in the 'compatible' schema:
> >
> > Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml: \
> > properties:compatible:enum: ['aspeed', 'ast2400-pinctrl', 'aspeed', 'g4-pinctrl'] has non-unique elements
> > Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml: \
> > properties:compatible:enum: ['aspeed', 'ast2500-pinctrl', 'aspeed', 'g5-pinctrl'] has non-unique elements
> >
> > Flow style sequences have to be quoted if the vales contain ','. Fix
> > this by using the more common one line per entry formatting.
> 
> >
> >  properties:
> >    compatible:
> > -    enum: [ aspeed,ast2400-pinctrl, aspeed,g4-pinctrl ]
> > +    enum:
> > +      - aspeed,ast2400-pinctrl
> > +      - aspeed,g4-pinctrl
> 
> Thanks for the fix. However, we've standardised on the first form for
> all of our device trees, so we can drop the second compatible string
> from the bindings.
> 
> I think Andrew already has a patch cooking to do this.

Yes, I have a series in the works. Will send patches soon.

Andrew
