From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 12:58:06 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_1/2]_gpio/aspeed-sgpio:_enable_access_to_all_80_?=
 =?UTF-8?Q?input_&_output_sgpios?=
In-Reply-To: <20200911015105.48581-1-jk@codeconstruct.com.au>
References: <20200911015105.48581-1-jk@codeconstruct.com.au>
Message-ID: <5beba404-14f0-4bb1-9110-c110797d5a04@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 11 Sep 2020, at 11:21, Jeremy Kerr wrote:
> Currently, the aspeed-sgpio driver exposes up to 80 GPIO lines,
> corresponding to the 80 status bits available in hardware. Each of these
> lines can be configured as either an input or an output.
> 
> However, each of these GPIOs is actually an input *and* an output; we
> actually have 80 inputs plus 80 outputs.
> 
> This change expands the maximum number of GPIOs to 160; the lower half
> of this range are the input-only GPIOs, the upper half are the outputs.
> We fix the GPIO directions to correspond to this mapping.
> 
> This also fixes a bug when setting GPIOs - we were reading from the
> input register, making it impossible to set more than one output GPIO.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Fixes: 7db47faae79b ("gpio: aspeed: Add SGPIO driver")

This was something I was leaning on the implementer to sort out when I
reviewed the driver way back. Oh well.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
