From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 27 Feb 2024 08:58:52 +1030
Subject: [PATCH] ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
In-Reply-To: <170896502304.859066.13236138723073669130.robh@kernel.org>
References: <20240226091754.16027-2-zev@bewilderbeest.net>
	 <170896502304.859066.13236138723073669130.robh@kernel.org>
Message-ID: <afee602b57f95a2d3162a601832d3a087ea5f0d6.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-02-26 at 10:54 -0600, Rob Herring wrote:
> On Mon, 26 Feb 2024 01:17:53 -0800, Zev Weiss wrote:
> > A recent change to the lm25066 driver changed the name of its
> > regulator from vout0 to vout; device-tree users of lm25066's regulator
> > functionality (of which ahe50dc is the only one) thus require a
> > corresponding update.
> > 
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> 
> My bot found new DT warnings on the .dts files added or changed in this
> series.
> 

For what it's worth I've put together a set of patches that resolve
almost all the warnings in the Aspeed DTSIs. My current approach is to
progressively send them out - I'm starting slow so where possible I can
avoid making the same mistake multiple times.

Andrew
