From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 29 Jan 2019 12:30:08 +0000
Subject: [PATCH v2] dt-bindings: aspeed-lpc: Make parameter optional
In-Reply-To: <20190118201547.640173-1-vijaykhemka@fb.com>
References: <20190118201547.640173-1-vijaykhemka@fb.com>
Message-ID: <20190129123008.GC24070@dell>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 18 Jan 2019, Vijay Khemka wrote:

> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 34dd89087cff..d28c4e117611 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -135,6 +135,9 @@ Required properties:
>  - clocks:	contains a phandle to the syscon node describing the clocks.
>  		There should then be one cell representing the clock to use
>  
> +Optional properties:
> +These below properties are optional to define.

This line is superfluous.  Please remove it.

> +
>  - memory-region: A phandle to a reserved_memory region to be used for the LPC
>  		to AHB mapping
>  

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
