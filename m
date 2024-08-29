From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 29 Aug 2024 09:55:30 +0200
Subject: [PATCH v6 1/2] dt-bindings: media: convert aspeed-video.txt to
 dt-schema
In-Reply-To: <20240829064508.3706672-2-jammy_huang@aspeedtech.com>
References: <20240829064508.3706672-1-jammy_huang@aspeedtech.com>
 <20240829064508.3706672-2-jammy_huang@aspeedtech.com>
Message-ID: <8ce757a9-ea4c-4dd2-8aaa-e04f21eb3f63@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/08/2024 08:45, Jammy Huang wrote:
> Convert the ASPEED SoCs video txt bindings to dt-schema.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  .../bindings/media/aspeed,video-engine.yaml   | 78 +++++++++++++++++++
>  .../bindings/media/aspeed-video.txt           | 33 --------
>  2 files changed, 78 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt

Fix the paths in kernel (git grep).

...

> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  memory-region:
> +    description: |
> +      Phandle to a memory region to allocate from, as defined in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

Useless description, completely redundant. Please say something useful
about this particular memory region and its usage.

Missing maxItems.

> +
> +  aspeed,scu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Specifies the scu node that is needed if video wants to capture
> +      from sources other than Host VGA.
> +
> +  aspeed,gfx:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Specifies the Soc Display(gfx) node that needs to be queried to get
> +      related information if video wants to use gfx as capture source.

These two were not in the binding. Mention in the commit msg any changes
from pure conversion with rationale WHY you are changing the binding.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
Best regards,
Krzysztof

