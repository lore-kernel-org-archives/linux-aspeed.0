From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 20:34:14 +0800
Subject: [PATCH v2 2/3] clk: aspeed: Add full configs for i3c clocks
In-Reply-To: <45ce9e62-2620-b959-985d-ae00b071e350@linaro.org>
References: <cover.1676267865.git.jk@codeconstruct.com.au>
	 <5ee4ade6820a9db8dc9c20bb39fd8a4c4cd7c2a6.1676267865.git.jk@codeconstruct.com.au>
	 <45ce9e62-2620-b959-985d-ae00b071e350@linaro.org>
Message-ID: <d58b6170427c9d1414118a0376e98d40f2579b20.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> Bindings are always separate patches.

OK, I'll split these up into the dt-bindings and the clk changes.

> > diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> > index d8b0db2f7a7d..600549d7bee8 100644
> > --- a/include/dt-bindings/clock/ast2600-clock.h
> > +++ b/include/dt-bindings/clock/ast2600-clock.h
> > @@ -57,8 +57,6 @@
> > ?#define ASPEED_CLK_GATE_I3C3CLK????????????????40
> > ?#define ASPEED_CLK_GATE_I3C4CLK????????????????41
> > ?#define ASPEED_CLK_GATE_I3C5CLK????????????????42
> > -#define ASPEED_CLK_GATE_I3C6CLK????????????????43
> > -#define ASPEED_CLK_GATE_I3C7CLK????????????????44
> 
> This is an ABI break and commit msg does not really justify it.

I'll add more rationale there.

Cheers,


Jeremy

