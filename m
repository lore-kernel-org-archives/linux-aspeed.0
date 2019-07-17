From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 17 Jul 2019 13:21:54 +0930
Subject: =?UTF-8?Q?Re:_[PATCH]_dt-bindings:_pinctrl:_aspeed:_Fix_'compatible'_sch?=
 =?UTF-8?Q?ema_errors?=
In-Reply-To: <CAL_Jsq+AJDNZ-676iP=vv6G-pjWqBJyZ3bJ26o7i=c=KWbozSw@mail.gmail.com>
References: <20190715223725.12924-1-robh@kernel.org>
 <CACPK8Xdz98CQzgE2KCjz8eOhPtx=H8jTe1hVT7LvP77U_gGASQ@mail.gmail.com>
 <CAL_Jsq+AJDNZ-676iP=vv6G-pjWqBJyZ3bJ26o7i=c=KWbozSw@mail.gmail.com>
Message-ID: <7b027585-27ab-4070-bf2e-5d08800e1a90@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 17 Jul 2019, at 00:35, Rob Herring wrote:
> On Mon, Jul 15, 2019 at 5:17 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Mon, 15 Jul 2019 at 22:37, Rob Herring <robh@kernel.org> wrote:
> > >
> > > The Aspeed pinctl schema have errors in the 'compatible' schema:
> > >
> > > Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml: \
> > > properties:compatible:enum: ['aspeed', 'ast2400-pinctrl', 'aspeed', 'g4-pinctrl'] has non-unique elements
> > > Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml: \
> > > properties:compatible:enum: ['aspeed', 'ast2500-pinctrl', 'aspeed', 'g5-pinctrl'] has non-unique elements
> > >
> > > Flow style sequences have to be quoted if the vales contain ','. Fix
> > > this by using the more common one line per entry formatting.
> >
> > >
> > >  properties:
> > >    compatible:
> > > -    enum: [ aspeed,ast2400-pinctrl, aspeed,g4-pinctrl ]
> > > +    enum:
> > > +      - aspeed,ast2400-pinctrl
> > > +      - aspeed,g4-pinctrl
> >
> > Thanks for the fix. However, we've standardised on the first form for
> > all of our device trees, so we can drop the second compatible string
> > from the bindings.
> 
> Doing that would introduce validation warnings until the dts file is
> updated. So we still need this change until that happens.

My series takes care of that.

Andrew
