From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 26 Apr 2024 10:30:27 +0930
Subject: [PATCH] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat
 strings
In-Reply-To: <171394189432.44668.6061047707500811188.b4-ty@linaro.org>
References: <20240224103712.20864-2-zev@bewilderbeest.net>
	 <171394189432.44668.6061047707500811188.b4-ty@linaro.org>
Message-ID: <eb02333de3bfcfef586f393141d5aaf039889e7f.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-04-24 at 08:58 +0200, Krzysztof Kozlowski wrote:
> On Sat, 24 Feb 2024 02:37:07 -0800, Zev Weiss wrote:
> > Due to the way i2c driver matching works (falling back to the driver's
> > id_table if of_match_table fails) this didn't actually cause any
> > misbehavior, but let's add the vendor prefixes so things actually work
> > the way they were intended to.
> > 
> > 
> 
> Two months passed, no replies from maintainers about picking it up. Dunno,
> looks abandoned, so let me grab this. If anyone else wants to pick it up, let
> me know.

Sorry, another one that fell in the hole mentioned previously.

I'm okay with it going via your tree if there are no conflicts.

Andrew

