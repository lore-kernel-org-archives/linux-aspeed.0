From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 29 Jul 2019 09:11:28 +0930
Subject: [PATCH 0/6] pinctrl: aspeed: Add AST2600 pinmux support
In-Reply-To: <CACRpkdb4pEdPHbo=3+fJXe9WG8K7A2_xVMtKWCJCfEawDO5wBw@mail.gmail.com>
References: <20190711041942.23202-1-andrew@aj.id.au>
 <CACRpkdb4pEdPHbo=3+fJXe9WG8K7A2_xVMtKWCJCfEawDO5wBw@mail.gmail.com>
Message-ID: <950b8374-2a06-44fe-a1fc-87be17e7d608@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 29 Jul 2019, at 08:44, Linus Walleij wrote:
> On Thu, Jul 11, 2019 at 6:19 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > This series adds pinmux support for the AST2600. Some more rework was required
> > on top of the previous cleanup series, but this rework was focussed on
> > supporting features of the AST2600 pinmux rather than fixing issues with the
> > existing infrastructure for the ASPEED drivers. Due to the dependences it's
> > based on top of pinctrl/devel, so should avoid any more SPDX issues.
> >
> > ASPEED have been testing the patches on hardware, so even for an initial pass
> > there's some confidence in the implementation.
> 
> I'm unsure if I need to wait for the DT bindings to be fixed on this
> series?

Yeah, I need to, sorry for the delay. Been distracted by other stuff.

Will send a v2 shortly.

Andrew
