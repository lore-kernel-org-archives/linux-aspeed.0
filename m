From: Olof Johansson <olof@lixom.net>
Date: Sat, 2 Jun 2018 01:19:07 -0700
Subject: [PATCH] ARM: dts: aspeed: Fix hwrng register address
In-Reply-To: <20180530061740.31547-1-joel@jms.id.au>
References: <20180530061740.31547-1-joel@jms.id.au>
Message-ID: <20180602081907.htjqm26yio2adm74@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 30, 2018 at 03:47:40PM +0930, Joel Stanley wrote:
> The register address should be the full address of the rng, not the
> offset from the start of the SCU.
> 
> Fixes: 5daa8212c08e ("ARM: dts: aspeed: Describe random number device")
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Hi ARM maintainers, this was found when testing next-20180529 after the
> merge of the aspeed 4.18 pull request.  Can you please apply this one to
> your -next tree?

Certainly, applied to our next/dt branch now.



Thanks,


-Olof
