From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 28 May 2024 09:24:38 -0500
Subject: [PATCH v6 12/20] dt-bindings: arm: aspeed: add IBM P11 BMC boards
In-Reply-To: <20240522192524.3286237-13-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-13-eajames@linux.ibm.com>
Message-ID: <e7ea186a-bf46-4cce-9d95-a4a242334ab6@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie

On 5/22/24 14:25, Eddie James wrote:
> Document two new AST2600 BMC boards for IBM P11 systems.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 95113df178cc5..e386d0ebfb14a 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -86,7 +86,9 @@ properties:
>                 - facebook,harma-bmc
>                 - facebook,minerva-cmc
>                 - facebook,yosemite4-bmc
> +              - ibm,blueridge-bmc
>                 - ibm,everest-bmc
> +              - ibm,fuji-bmc
>                 - ibm,rainier-bmc
>                 - ibm,system1-bmc
>                 - ibm,tacoma-bmc

Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

