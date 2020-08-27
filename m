From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 27 Aug 2020 14:27:02 +0800
Subject: [PATCH] ARM: aspeed: g5: Do not set sirq polarity
In-Reply-To: <20200812112400.2406734-1-joel@jms.id.au>
References: <20200812112400.2406734-1-joel@jms.id.au>
Message-ID: <1e56af7945b93a22e31ba6d81da82cbdb1b237b6.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> A feature was added to the aspeed vuart driver to configure the vuart
> interrupt (sirq) polarity according to the LPC/eSPI strapping register.
> 
> Systems that depend on a active low behaviour (sirq_polarity set to 0)
> such as OpenPower boxes also use LPC, so this relationship does not
> hold.
> 
> The property was added for a Tyan S7106 system which is not supported
> in the kernel tree. Should this or other systems wish to use this
> feature of the driver they should add it to the machine specific device
> tree.
> 
> Fixes: c791fc76bc72 ("arm: dts: aspeed: Add vuart aspeed,sirq-polarity-sense...")
> Cc: stable at vger.kernel.org
> Signed-off-by: Joel Stanley <joel@jms.id.au>

LGTM. I've tested this on the s2600st, which is strapped for eSPI. All
good there too, as expected.

Tested-by: Jeremy Kerr <jk@ozlabs.org>

and/or:

Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

