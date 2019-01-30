From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 30 Jan 2019 11:28:19 -0800
Subject: [PATCH 2/2] clk: aspeed: Setup video engine clocking
In-Reply-To: <81b100b7-252e-3145-fb34-17a9c0cdd91e@linux.ibm.com>
References: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com>
 <1544559161-21468-3-git-send-email-eajames@linux.ibm.com>
 <CACPK8XcY_c9NzNv-WyZcz+mZ5c2jixyCzEQAK-+t0QvQ_uJXwg@mail.gmail.com>
 <81b100b7-252e-3145-fb34-17a9c0cdd91e@linux.ibm.com>
Message-ID: <154887649939.169292.7755423118611897741@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Eddie James (2018-12-14 07:47:53)
> 
> 
> On 12/13/2018 07:02 PM, Joel Stanley wrote:
> 
> >
> >> +       { 0x0, 2 },
> >> +       { 0x1, 2 },
> >> +       { 0x2, 3 },
> >> +       { 0x3, 4 },
> >> +       { 0x4, 5 },
> >> +       { 0x5, 6 },
> >> +       { 0x6, 7 },
> >> +       { 0x7, 8 },
> >> +       { 0 }
> >> +};
> >> @@ -317,6 +338,7 @@ struct aspeed_reset {
> >>          [ASPEED_RESET_PECI]     = 10,
> >>          [ASPEED_RESET_I2C]      =  2,
> >>          [ASPEED_RESET_AHB]      =  1,
> >> +       [ASPEED_RESET_VIDEO]    =  6,
> > You've added the reset line to the ASPEED_CLK_GATE_ECLK clock so you
> > do not need to separately expose the reset controller. Instead
> > enabling the clock will deassert the rest line for you.
> >
> > This means you should drop the change from the header too, and it
> > affects the bindings document for the video engine.
> 
> I want that reset available separately for use in the video engine 
> actually. I could do without it, but it's somewhat useful.
> 

Joel, are you happy with these patches? I'm tempted to drop these
changes from my queue because there hasn't been any news in over a
month.

