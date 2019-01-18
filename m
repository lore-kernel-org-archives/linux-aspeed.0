From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 18 Jan 2019 14:51:12 +1030
Subject: [PATCH] dt-bindings: aspeed-lpc: Make parameter optional
In-Reply-To: <20190117190830.824013-1-vijaykhemka@fb.com>
References: <20190117190830.824013-1-vijaykhemka@fb.com>
Message-ID: <1547785272.2051152.1637704704.1926B2B5@webmail.messagingengine.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

On Fri, 18 Jan 2019, at 05:38, Vijay Khemka wrote:
> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/
> Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 34dd89087cff..ff0cb28903dd 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -135,6 +135,10 @@ Required properties:
>  - clocks:	contains a phandle to the syscon node describing the clocks.
>  		There should then be one cell representing the clock to use
>  
> +Optional properties:
> +These below properties are optional and required only if one need to use it
> +through ioctl.

I'd just say "Optional properties". Leave the description off, as we probably
shouldn't be talking about ioctls and such in the bindings.

Andrew

> +
>  - memory-region: A phandle to a reserved_memory region to be used for the LPC
>  		to AHB mapping
>  
> -- 
> 2.17.1
> 
