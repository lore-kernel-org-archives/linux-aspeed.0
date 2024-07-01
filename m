From: Conor Dooley <conor@kernel.org>
Date: Mon, 1 Jul 2024 16:03:03 +0100
Subject: [PATCH v1 2/3] dt-bindings: arm: aspeed: add IEIT x86 platform
 BMC boards
In-Reply-To: <20240701105259.972135-2-liuxiwei@ieisystem.com>
References: <20240701105259.972135-1-liuxiwei@ieisystem.com>
 <20240701105259.972135-2-liuxiwei@ieisystem.com>
Message-ID: <20240701-penniless-purplish-99aa73b47a42@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 01, 2024 at 06:52:58PM +0800, George Liu wrote:
> Document the new compatibles used on the ieisystems
> 
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index e386d0ebfb14..818fbe9c45fc 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -92,6 +92,7 @@ properties:
>                - ibm,rainier-bmc
>                - ibm,system1-bmc
>                - ibm,tacoma-bmc
> +              - ieit,nf5280m7-bmc

This is a singular item, but your commit message's $body and $subject
both sound plural. Is that intentional?

>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> -- 
> 2.34.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240701/5cc643ec/attachment.sig>
