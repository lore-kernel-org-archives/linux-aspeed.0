From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Oct 2019 11:22:17 +1030
Subject: [PATCH 1/2] dt-bindings: clock: Add AST2500 RMII RCLK definitions
In-Reply-To: <CACPK8Xf-f-r4S02GoxYdBYOJi5NGYMCOr6XGVza4vEGAsqzR9w@mail.gmail.com>
References: <20191008113523.13601-1-andrew@aj.id.au>
 <20191008113523.13601-2-andrew@aj.id.au>
 <CACPK8Xf-f-r4S02GoxYdBYOJi5NGYMCOr6XGVza4vEGAsqzR9w@mail.gmail.com>
Message-ID: <18ac98e1-82b6-4782-bdfb-56765653e6df@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 8 Oct 2019, at 23:07, Joel Stanley wrote:
> On Tue, 8 Oct 2019 at 11:34, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The AST2500 has an explicit gate for the RMII RCLK for each of the two
> > MACs.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  include/dt-bindings/clock/aspeed-clock.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> > index f43738607d77..64e245fb113f 100644
> > --- a/include/dt-bindings/clock/aspeed-clock.h
> > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > @@ -39,6 +39,8 @@
> >  #define ASPEED_CLK_BCLK                        33
> >  #define ASPEED_CLK_MPLL                        34
> >  #define ASPEED_CLK_24M                 35
> > +#define ASPEED_CLK_GATE_MAC1RCLK       36
> > +#define ASPEED_CLK_GATE_MAC2RCLK       37
> 
> Calling these ASPEED_CLK_GATE breaks the pattern the rest of the
> driver has in using that name for the clocks that are registered as
> struct aspeed_clk_gate clocks.
> 
> Do you think we should drop the GATE_ to match the existing clocks?

I named them that way because the bits in question do just gate the
clocks, but I've renamed them to keep the pattern. Will send a v2.

Andrew
