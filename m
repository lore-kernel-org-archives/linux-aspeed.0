From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 06:24:25 +0000
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <20200910175733.11046-2-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
Message-ID: <CACPK8XdocAX5mOXf3VP29cNXH+6unYunB9NiT3qFVKyzR6WXPg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2020 at 17:57, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Convert the NXP PCA953x family of GPIO expanders bindings to device tree
> schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

> +patternProperties:
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> +    type: object
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name: true
> +
> +    required:
> +      - gpio-hog
> +      - gpios
> +

> +            usb3-sata-sel-hog {
> +                gpio-hog;
> +                gpios = <4 GPIO_ACTIVE_HIGH>;
> +                output-low;
> +                line-name = "usb3_sata_sel";

I would prefer we didn't require the addition of hte -hog prefix. It's
mostly just a matter of taste, but I can think of a few more concrete
reasons:

We don't require -high or -low prefixes, so the node name doesn't need
to describe the properties that will be found below.

Changing around node names for existing boards carries with it the
chance of userspace breakage (as sysfs paths change). I would prefer
we avoid that if possible.

Cheers,

Joel
