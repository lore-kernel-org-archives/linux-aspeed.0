From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Mar 2019 17:20:07 -0500
Subject: [PATCH v6 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
In-Reply-To: <20190304185536.211084-1-venture@google.com>
References: <20190304185536.211084-1-venture@google.com>
Message-ID: <20190311222007.GA16254@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 04, 2019 at 10:55:36AM -0800, Patrick Venture wrote:
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
> Changes for v6:
> - None
> Changes for v5:
> - None
> Changes for v4:
> - None
> Changes for v3:
> - None
> Changes for v2:
> - Added comment about syscon required parameter.
> ---
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> new file mode 100644
> index 000000000000..1092d62d1c92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> @@ -0,0 +1,32 @@
> +======================================================================
> +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
> +======================================================================
> +
> +The bridge is available on platforms with the VGA enabled on the Aspeed device.
> +In this case, the host has access to a 64KiB window into all of the BMC's
> +memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
> +has read access to all the regions of memory, however the host only has read
> +and write access depending on a register controlled by the BMC.
> +
> +Required properties:
> +===================
> +
> + - compatible: must be one of:
> +	- "aspeed,ast2400-p2a-ctrl"
> +	- "aspeed,ast2500-p2a-ctrl"
> +
> + - syscon: handle to syscon device node controlling PCI.
> +
> +Optional properties:
> +===================
> +
> +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> +		to AHB mapping
> +
> +Example:
> +
> +p2a: p2a-control at 1e6e2000 {
> +	compatible = "aspeed,ast2400-p2a-ctrl";
> +	memory-region = <&reserved_memory>;
> +	syscon = <&syscon>;

Make this node a child of what you are pointing to instead if this the 
only control interface.

Rob



