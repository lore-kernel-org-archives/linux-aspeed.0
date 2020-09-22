From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Sep 2020 16:39:40 -0600
Subject: [PATCH v2 1/2] gpio/aspeed-sgpio: enable access to all 80 input
 & output sgpios
In-Reply-To: <20200911015105.48581-1-jk@codeconstruct.com.au>
References: <20200911015105.48581-1-jk@codeconstruct.com.au>
Message-ID: <20200922223940.GA3391274@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2020 09:51:04 +0800, Jeremy Kerr wrote:
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
> 
> ---
> v2:
>  - Fix warnings from kbuild test robot
>  - Add comment for input/output GPIO numbering
> ---
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt |   5 +-
>  drivers/gpio/gpio-aspeed-sgpio.c              | 126 ++++++++++++------
>  2 files changed, 87 insertions(+), 44 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
