From: Rob Herring <robh@kernel.org>
Date: Mon, 1 Jul 2024 12:31:05 -0600
Subject: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add prefix for
 ieisystems
In-Reply-To: <20240701105259.972135-1-liuxiwei@ieisystem.com>
References: <20240701105259.972135-1-liuxiwei@ieisystem.com>
Message-ID: <20240701183105.GA345878-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 01, 2024 at 06:52:57PM +0800, George Liu wrote:
> Add a vendor prefix entry for ieisystems
> 
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>

Also note that checkpatch.pl reports an author/Sob email mismatch.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 573578db9509..0ffa8d06aea9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -609,6 +609,8 @@ patternProperties:
>      description: IC Plus Corp.
>    "^idt,.*":
>      description: Integrated Device Technologies, Inc.
> +  "^ieit,.*":
> +    description: IEIT SYSTEMS Co.?Ltd.
>    "^ifi,.*":
>      description: Ingenieurburo Fur Ic-Technologie (I/F/I)
>    "^ilitek,.*":
> -- 
> 2.34.1
> 
