From: Joel Stanley <joel@jms.id.au>
Date: Fri, 2 Aug 2019 06:15:01 +0000
Subject: [PATCH 0/3] ARM: dts: aspeed: Deprecate g[45]-style compatibles
In-Reply-To: <3691f6cb-2451-43f7-9f00-d5693071ba59@www.fastmail.com>
References: <20190724081313.12934-1-andrew@aj.id.au>
 <CACRpkdapypySGPrLgSMSNy1fzkca2BfMUGzf3koFWQZ-M5VOvg@mail.gmail.com>
 <9d0f2b20-e6f6-419c-a866-c4a0dd92aa63@www.fastmail.com>
 <3691f6cb-2451-43f7-9f00-d5693071ba59@www.fastmail.com>
Message-ID: <CACPK8XcWK9Gf=pW5ds=3muoXHAWnyYfHcVSVh+anaTigtMO8yA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2019 at 05:45, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Tue, 30 Jul 2019, at 10:27, Andrew Jeffery wrote:
> >
> >
> > On Tue, 30 Jul 2019, at 07:23, Linus Walleij wrote:
> > > On Wed, Jul 24, 2019 at 10:13 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > > It's probably best if we push the three patches all through one tree rather
> > > > than fragmenting. Is everyone happy if Joel applies them to the aspeed tree?
> > >
> > > If you are sure it will not collide with parallell work in the
> > > pinctrl tree, yes.
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > (If it does collide I'd prefer to take the pinctrl patches and fix the
> > > conflicts in my tree.)
> >
> > Fair enough, I don't know the answer so I'll poke around. I don't
> > really mind
> > where the series goes in, I just want to avoid landing only part of it
> > if I split it up.
>
> Okay, it currently conflicts with my cleanup-devicetree-warnings series.
>
> Joel, do you mind if Linus takes this series through the pinctrl tree, given
> the fix to the devicetrees is patch 1/3?

It depends if you plan more changes to that part of the device tree
this merge window :)

Linus, perhaps the safer option is for me to take 1/3 through my tree
and you can take the rest through yours?

Cheers,

Joel
