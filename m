From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 01 Apr 2019 23:42:53 -0400
Subject: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
In-Reply-To: <20190329151025.204094-1-venture@google.com>
References: <20190329151025.204094-1-venture@google.com>
Message-ID: <e33bc539-2350-4b7d-9833-df270383b062@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Patrick,

I held off on reviewing this until we'd hashed out what we needed in the driver.

I have some comments below.

On Sat, 30 Mar 2019, at 01:40, Patrick Venture wrote:
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v8:
> - None
> Changes for v7:
> - Moved node under the syscon node it requires
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
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt 
> b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> new file mode 100644
> index 0000000000000..088cc4e3dc54b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> @@ -0,0 +1,48 @@
> +======================================================================
> +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge 
> Control Driver
> +======================================================================
> +
> +The bridge is available on platforms with the VGA enabled on the 
> Aspeed device.
> +In this case, the host has access to a 64KiB window into all of the 
> BMC's
> +memory.  The BMC can disable this bridge.  If the bridge is enabled, 
> the host
> +has read access to all the regions of memory, however the host only 
> has read
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

The p2a-ctrl node is meant to be a child of the syscon. I noted this in my review
of the associated driver - you need to remove the description of the syscon
property.

> +
> +Optional properties:
> +===================
> +
> +- memory-region: A phandle to a reserved_memory region to be used for 
> the PCI
> +		to AHB mapping
> +
> +The p2a-control node should be the child of a syscon node with the 
> required
> +property:
> +
> +- compatible : Should be one of the following:
> +		"aspeed,ast2400-scu", "syscon", "simple-mfd"
> +		"aspeed,g4-scu", "syscon", "simple-mfd"
> +		"aspeed,ast2500-scu", "syscon", "simple-mfd"
> +		"aspeed,g5-scu", "syscon", "simple-mfd"

The note above should go where you've described the syscon property above.

Cheers,

Andrew

> +
> +Example:
> +
> +g4 Example
> +----------
> +
> +syscon: scu at 1e6e2000 {
> +	compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
> +	reg = <0x1e6e2000 0x1a8>;
> +
> +	p2a: p2a-control {
> +		compatible = "aspeed,ast2400-p2a-ctrl";
> +		memory-region = <&reserved_memory>;
> +	};
> +};
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
>
