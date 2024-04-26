From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 08:29:03 +0200
Subject: [PATCH v3 10/14] dt-bindings: i2c: i2c-fsi: Switch to yaml format
In-Reply-To: <20240425213701.655540-11-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-11-eajames@linux.ibm.com>
Message-ID: <f84ddcdb-8f8a-4cf6-a851-243baa1745ac@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2024 23:36, Eddie James wrote:
> Switch to yaml for the FSI-attached I2C controller.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline), work on fork of kernel
(don't, instead use mainline) or you ignore some maintainers (really
don't). Just use b4 and everything should be fine, although remember
about `b4 prep --auto-to-cc` if you added new patches to the patchset.

> ---
>  .../devicetree/bindings/i2c/i2c-fsi.txt       | 40 -------------
>  .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
> 


> -    };
> diff --git a/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml b/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
> new file mode 100644
> index 000000000000..473a45de1b6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/ibm,i2c-fsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM FSI-attached I2C controller
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description:
> +  This I2C controller is an FSI CFAM engine, providing access to a number of
> +  I2C busses. Therefore this node will always be a child of an FSI CFAM node;
> +  see fsi.txt for details on FSI slave and CFAM nodes.

Here and in all other schemas - remove reference to fsi.txt. You are
going to drop this file once you convert everything, right?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ibm,i2c-fsi
> +
> +  reg:
> +    items:
> +      - description: FSI slave address
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c at 1800 {

So no wrapper node is needed. Drop the wrapper node in previous patchset
where you introduced one with warning.


Best regards,
Krzysztof

