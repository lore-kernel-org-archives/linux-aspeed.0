From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 05 Oct 2023 11:47:50 +1030
Subject: [PATCH] pinctrl: aspeed: Allow changing hardware strap defaults
In-Reply-To: <20231004071605.21323-2-zev@bewilderbeest.net>
References: <20231004071605.21323-2-zev@bewilderbeest.net>
Message-ID: <e5f0a67e05cf477bdb4ec6efd9c554f4aaa2cf8b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2023-10-04 at 00:16 -0700, Zev Weiss wrote:
> Previously we've generally assumed that the defaults in the hardware
> strapping register are in fact appropriate for the system and thus
> have avoided making any changes to its contents (with the exception of
> the bits controlling the GPIO passthrough feature).
> 
> Unfortunately, on some platforms corrections from software are
> required as the hardware strapping is simply incorrect for the system
> (such as the SPI1 interface being configured for passthrough mode when
> master mode is in fact the only useful configuration for it).  We thus
> remove the checks preventing changes to the strap register so that the
> pinctrl subsystem can be used for such corrections.

So the strapping for the SPI1 configuration seems to be prone to
(copy/paste?) mistakes. Is there evidence that motivates dropping all
the protection instead of poking a hole for SPI1 like we did for the
passthrough GPIOs?

I'm still a little attached to the policy that software should be
beholden to the strapping, and to try to mitigate software mistakes
given the smattering of bits required to drive the Aspeed pinmux.

Andrew

