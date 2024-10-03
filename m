From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 3 Oct 2024 10:17:02 +0200
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
In-Reply-To: <20241002084023.467383-1-naresh.solanki@9elements.com>
References: <20241002084023.467383-1-naresh.solanki@9elements.com>
Message-ID: <xuczpa6nrxjwo7hjn62ehblnzc5twupghbg4uuwp5vfczw3gmg@x23yhbxjccpy>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 02, 2024 at 02:10:17PM +0530, Naresh Solanki wrote:
> Document the new compatibles used on IBM SBP1.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 95113df178cc..8c04d6eaec08 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -89,6 +89,7 @@ properties:
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
>                - ibm,system1-bmc
> +              - ibm,sbp1-bmc

Keep alphabetical order.

Best regards,
Krzysztof

