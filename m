From: Conor Dooley <conor@kernel.org>
Date: Thu, 30 May 2024 17:32:19 +0100
Subject: [PATCH v2 2/2] dt-bindings: gpio: aspeed,sgpio: Specify
 #interrupt-cells
In-Reply-To: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-2-912cd16e641f@codeconstruct.com.au>
References: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
 <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-2-912cd16e641f@codeconstruct.com.au>
Message-ID: <20240530-italics-ultra-6322f9475567@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 30, 2024 at 11:09:49AM +0930, Andrew Jeffery wrote:
> Squash warnings such as:
> 
>     arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: sgpio at 1e780200: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Also, mark #interrupt-cells as required. The kernel devicetrees already
> specified it where compatible nodes were defined, and u-boot pulls in
> the kernel devicetrees, so this should have minimal practical impact.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240530/ff450dd4/attachment.sig>
