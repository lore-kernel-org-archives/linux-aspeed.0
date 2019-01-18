From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 18 Jan 2019 15:43:54 +1030
Subject: [PATCH v2 2/2] dt-bindings: edac: Aspeed AST2500
In-Reply-To: <1547743097-5236-3-git-send-email-schaecsn@gmx.net>
References: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
 <1547743097-5236-3-git-send-email-schaecsn@gmx.net>
Message-ID: <1547788434.2065387.1637728584.1098F843@webmail.messagingengine.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 18 Jan 2019, at 03:08, Stefan Schaeckeler wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for EDAC on the Aspeed AST2500 SoC.
> 
> Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  .../bindings/edac/aspeed-sdram-edac.txt       | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-
> edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> new file mode 100644
> index 000000000000..6a0f3d90d682
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> @@ -0,0 +1,25 @@
> +Aspeed AST2500 SoC EDAC node
> +
> +The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without 
> ECC (error
> +correction check).
> +
> +The memory controller supports SECDED (single bit error correction, 
> double bit
> +error detection) and single bit error auto scrubbing by reserving 8 
> bits for
> +every 64 bit word (effectively reducing available memory to 8/9).
> +
> +Note, the bootloader must configure ECC mode in the memory controller.
> +
> +
> +Required properties:
> +- compatible: should be "aspeed,ast2500-sdram-edac"
> +- reg:        sdram controller register set should be <0x1e6e0000 
> 0x174>
> +- interrupts: should be AVIC interrupt #0
> +
> +
> +Example:
> +
> +	edac: sdram at 1e6e0000 {
> +		compatible = "aspeed,ast2500-sdram-edac";
> +		reg = <0x1e6e0000 0x174>;
> +		interrupts = <0>;
> +	};
> -- 
> 2.19.1
> 
