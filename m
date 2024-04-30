From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 30 Apr 2024 09:04:47 +0200
Subject: [PATCH v4 08/17] dt-bindings: fsi: ast2600-fsi-master: Convert to
 json-schema
In-Reply-To: <20240429210131.373487-9-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-9-eajames@linux.ibm.com>
Message-ID: <af51132f-e4a3-4f45-b066-24b8c348eb28@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/04/2024 23:01, Eddie James wrote:
> Convert to json-schema for the AST2600 FSI master documentation.

Please mention all the changes from pure conversion.

> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v3:
>  - Remove quotes around compatible strings
>  - Re-order allOf to below required
>  - Add child node in the example
>  - Change commit message to match similar commits
> 
>  .../fsi/aspeed,ast2600-fsi-master.yaml        | 81 +++++++++++++++++++
>  .../bindings/fsi/fsi-master-aspeed.txt        | 36 ---------
>  2 files changed, 81 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
>  delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
> new file mode 100644
> index 000000000000..fcf7c4b93b78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed FSI master
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description:
> +  The AST2600 and later contain two identical FSI masters. They share a
> +  clock and have a separate interrupt line and output pins.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-fsi-master
> +      - aspeed,ast2700-fsi-master

There was no such compatible before.

How does this even validate? Where is fsi-master? You dropped a
compatible without any explanation.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +


Best regards,
Krzysztof

