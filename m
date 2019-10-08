From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 8 Oct 2019 11:12:13 -0700
Subject: [PATCH 1/5] dt-bindings: i2c: aspeed: add buffer and DMA mode
 transfer support
In-Reply-To: <20191007231313.4700-2-jae.hyun.yoo@linux.intel.com>
References: <20191007231313.4700-1-jae.hyun.yoo@linux.intel.com>
 <20191007231313.4700-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <20191008181213.GB155928@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 07, 2019 at 04:13:09PM -0700, Jae Hyun Yoo wrote:
> Append bindings to support buffer mode and DMA mode transfer.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt    | 67 +++++++++++++++++--
>  1 file changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> index 8fbd8633a387..e40dcc108307 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -3,7 +3,10 @@ Device tree configuration for the I2C busses on the AST24XX and AST25XX SoCs.
>  Required Properties:
>  - #address-cells	: should be 1
>  - #size-cells		: should be 0
> -- reg			: address offset and range of bus
> +- reg			: Address offset and range of bus registers.
> +			  An additional SRAM buffer address offset and range is
> +			  optional in case of enabling I2C dedicated SRAM for
> +			  buffer mode transfer support.

Sorry, I am having trouble parsing this. This seems like the SRAM buffer
is global to all busses. Can you clarify? I expect I will probably have
some more questions elsewhere.

>  - compatible		: should be "aspeed,ast2400-i2c-bus"
>  			  or "aspeed,ast2500-i2c-bus"
>  - clocks		: root clock of bus, should reference the APB
> @@ -16,6 +19,18 @@ Optional Properties:
>  - bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
>  		  specified
>  - multi-master	: states that there is another master active on this bus.
> +- aspeed,dma-buf-size	: size of DMA buffer (from 2 to 4095 in case of AST2500
> +			  or later versions).
> +			  Only AST2500 and later versions support DMA mode
> +			  under some limitations:
> +			  I2C is sharing the DMA H/W with UHCI host controller
> +			  and MCTP controller. Since those controllers operate
> +			  with DMA mode only, I2C has to use buffer mode or byte
> +			  mode instead if one of those controllers is enabled.
> +			  Also make sure that if SD/eMMC or Port80 snoop uses
> +			  DMA mode instead of PIO or FIFO respectively, I2C
> +			  can't use DMA mode. If both DMA and buffer modes are
> +			  enabled, DMA mode will be selected.

nit: I think it makes sense to break down the exceptions into a
bulleted list.

Cheers
