From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 01 May 2024 10:10:18 +0930
Subject: [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
In-Reply-To: <20240430172520.535179-1-robh@kernel.org>
References: <20240430172520.535179-1-robh@kernel.org>
Message-ID: <4f3ce3439e3d996471085e906902e508528308d3.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-04-30 at 12:25 -0500, Rob Herring (Arm) wrote:
> The use of 'oneOf' to include 1 of 3 possible child node schemas results
> in error messages containing the actual error message(s) for the correct
> SoC buried in the tons of error messages from the 2 schemas that don't
> apply. It also causes the pinctrl schema to be applied twice as it will
> be applied when the compatible matches.
> 
> All that's really needed in the parent schema is to ensure one of the
> possible compatible strings is present in the pinctrl node so that its
> schema will be applied separately.

Thanks, I think it improves the readability of intent in the binding as
well.

To understand the impact better I grabbed the patch and diffed the
output of `make CHECK_DTBS=y aspeed/aspeed-ast2600-evb.dtb` before and
after applying it, but there was no significant difference in output.
Should that not demonstrate the errors being cleaned up? If not, what
should?

Andrew
