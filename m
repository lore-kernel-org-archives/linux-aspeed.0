From: Patrick Williams <patrick@stwcx.xyz>
Date: Thu, 4 Jan 2024 08:28:51 -0600
Subject: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
In-Reply-To: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
References: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
Message-ID: <ZZbAoxDm39qeBtCy@heinlein.vulture-banana.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 04, 2024 at 09:45:26PM +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
> 
> Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw at mail.gmail.com/
> 
> Change log:
> 
> v1 -> v2
>   - Add infineon,slb9670 information for tpm.
>   - Patch 0006 - Add PDB temperature.
> 
> v1
>   - Patch 0001 - Revise SGPIO line name.
>   - Patch 0002 - Mapping ttyS2 to UART4.
>   - Patch 0003 - Remove Vuart.
>   - Patch 0004 - Add cpu power good line name.
>   - Patch 0005 - Add spi-gpio.
> 
> Peter Yin (6):
>   ARM: dts: aspeed: Harma: Revise SGPIO line name.
>   ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
>   ARM: dts: aspeed: Harma: Remove Vuart
>   ARM: dts: aspeed: Harma: Add cpu power good line name
>   ARM: dts: aspeed: Harma: Add spi-gpio
>   ARM: dts: aspeed: Harma: Add PDB temperature
> 
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> -- 
> 2.25.1
> 

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240104/b2a931a4/attachment.sig>
