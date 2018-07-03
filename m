From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Jul 2018 13:30:17 -0600
Subject: [PATCH 1/2] dt-bindings: fsi: Add optional chip-id to CFAMs
In-Reply-To: <20180622043756.21158-1-benh@kernel.crashing.org>
References: <20180622043756.21158-1-benh@kernel.crashing.org>
Message-ID: <20180703193017.GA23230@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 22, 2018 at 02:37:55PM +1000, Benjamin Herrenschmidt wrote:
> This represents a physical chip in the system and allows
> a stable numbering scheme to be passed to udev for userspace
> to recognize which chip is which.

I'm sure you're aware, stable numbers is generally not something the 
kernel guarantees...

In the cases where we do have them, we've used aliases.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  Documentation/devicetree/bindings/fsi/fsi.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi.txt b/Documentation/devicetree/bindings/fsi/fsi.txt
> index ab516c673a4b..afb4eccab131 100644
> --- a/Documentation/devicetree/bindings/fsi/fsi.txt
> +++ b/Documentation/devicetree/bindings/fsi/fsi.txt
> @@ -83,6 +83,10 @@ addresses and sizes in the slave address space:
>      #address-cells = <1>;
>      #size-cells = <1>;
>  
> +Optionally, a slave can provide a global unique chip ID which is used to
> +identify the physical location of the chip in a system specific way
> +
> +    chip-id = <0>;
>  
>  FSI engines (devices)
>  ---------------------
> @@ -125,6 +129,7 @@ device tree if no extra platform information is required.
>              reg = <0 0>;
>              #address-cells = <1>;
>              #size-cells = <1>;
> +	    chip-id = <0>;
>  
>              /* FSI engine at 0xc00, using a single page. In this example,
>               * it's an I2C master controller, so subnodes describe the
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
