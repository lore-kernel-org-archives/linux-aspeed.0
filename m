From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Jan 2022 03:17:42 +0000
Subject: [PATCH v5 01/13] dt-bindings: Add generic bindings for PECI
In-Reply-To: <20220112230247.982212-2-iwona.winiarska@intel.com>
References: <20220112230247.982212-1-iwona.winiarska@intel.com>
 <20220112230247.982212-2-iwona.winiarska@intel.com>
Message-ID: <CACPK8Xfi33mr38_sdxF_Hi8Pw7VHzxH0zJd09gQz0voJm2xDBA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 12 Jan 2022 at 23:03, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> Add device tree bindings for the PECI controller.
>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../bindings/peci/peci-controller.yaml        | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml
>
> diff --git a/Documentation/devicetree/bindings/peci/peci-controller.yaml b/Documentation/devicetree/bindings/peci/peci-controller.yaml
> new file mode 100644
> index 000000000000..bbc3d3f3a929
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-controller.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/peci/peci-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic Device Tree Bindings for PECI
> +
> +maintainers:
> +  - Iwona Winiarska <iwona.winiarska@intel.com>
> +
> +description:
> +  PECI (Platform Environment Control Interface) is an interface that provides a
> +  communication channel from Intel processors and chipset components to external
> +  monitoring or control devices.
> +
> +properties:
> +  $nodename:
> +    pattern: "^peci-controller(@.*)?$"
> +
> +  cmd-timeout-ms:
> +    description:
> +      Command timeout in units of ms.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    peci-controller at 1e78b000 {
> +      reg = <0x1e78b000 0x100>;
> +      cmd-timeout-ms = <500>;
> +    };
> +...
> --
> 2.31.1
>
