From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 13 Apr 2024 09:47:32 +0200
Subject: [PATCH 1/3] dt-bindings: fsi: Document the IBM SBEFIFO engine
In-Reply-To: <20240412144358.204129-2-eajames@linux.ibm.com>
References: <20240412144358.204129-1-eajames@linux.ibm.com>
 <20240412144358.204129-2-eajames@linux.ibm.com>
Message-ID: <2a3e4ef9-1e4b-4f9e-a2f3-0ac95db42fdf@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/04/2024 16:43, Eddie James wrote:
> The SBEFIFO engine provides an interface to the POWER processor
> Self Boto Engine (SBE).

Boot?

> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/fsi/ibm,sbefifo.yaml  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml b/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
> new file mode 100644
> index 000000000000..d70012e42d79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fsi/ibm,sbefifo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM FSI-attached SBEFIFO engine
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description: |
> +  This binding describes an FSI CFAM engine called the SBEFIFO. Therefore this

Don't describe the binding, but the hardware. Drop redundant "This
binding" and say what is the hardware here.

> +  node will always be a child of an FSI CFAM node; see fsi.txt for details on
> +  FSI slave and CFAM nodes. This SBEFIFO engine provides an interface to the
> +  POWER processor Self Boot Engine (SBE).
> +

With these two changes:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

