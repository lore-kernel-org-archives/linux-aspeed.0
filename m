From: Joel Stanley <joel@jms.id.au>
Date: Tue, 21 Jan 2020 01:53:15 +0000
Subject: [PATCH 1/2] hwrng: Add support for ASPEED RNG
In-Reply-To: <20200120150113.2565-1-linux@neuralgames.com>
References: <20200120150113.2565-1-linux@neuralgames.com>
Message-ID: <CACPK8XfuVN3Q=npEoOP-amQS0-wemxcx6LKaHHZEsBAHzq1wzA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 20 Jan 2020 at 15:12, Oscar A Perez <linux@neuralgames.com> wrote:
>
> This minimal driver adds support for the Hardware Random Number Generator
> that comes with the AST2400/AST2500/AST2600 SOCs from AspeedTech.
>
> The HRNG on these SOCs uses Ring Oscillators working together to generate
> a stream of random bits that can be read by the platform via a 32bit data
> register.

Thanks for the patch.

We've been using the timeriomem-rng driver for the past few years on
aspeed hardware. You can see how that's set up by looking at
arch/arm/boot/dts/aspeed-g{4,5,6}.dtsi

I suggest we continue to use the generic driver.

Cheers,

Joel



>
> Signed-off-by: Oscar A Perez <linux@neuralgames.com>
> ---
>  .../devicetree/bindings/rng/aspeed-rng.yaml   | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/aspeed-rng.yaml
>
> diff --git a/Documentation/devicetree/bindings/rng/aspeed-rng.yaml b/Documentation/devicetree/bindings/rng/aspeed-rng.yaml
> new file mode 100644
> index 000000000000..06070ebe1c33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/aspeed-rng.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/rng/aspeed-rng.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +
> +title: Bindings for Aspeed Hardware Random Number Generator
> +
> +
> +maintainers:
> +  - Oscar A Perez <linux@neuralgames.com>
> +
> +
> +description: |
> +  The HRNG on the AST2400/AST2500/AST2600 SOCs from AspeedTech  uses four Ring
> +  Oscillators working together to generate a stream of random bits that can be
> +  read by the platform via a 32bit data register every one microsecond.
> +  All the platform has to do is to provide to the driver the 'quality' entropy
> +  value, the  'mode' in which the combining  ROs will generate the  stream  of
> +  random bits and, the 'period' value that is used as a wait-time between reads
> +  from the 32bit data register.
> +
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - aspeed,ast2400-rng
> +              - aspeed,ast2500-rng
> +              - aspeed,ast2600-rng
> +
> +
> +  reg:
> +    description:
> +      Base address and length of the register set of this block.
> +      Currently 'reg' must be eight bytes wide and 32-bit aligned.
> +
> +    maxItems: 1
> +
> +
> +  period:
> +    description:
> +      Wait time in microseconds to be used between reads.
> +      The RNG on these Aspeed SOCs generates 32bit of random data
> +      every one microsecond. Choose between 1 and n microseconds.
> +
> +    maxItems: 1
> +
> +
> +  mode:
> +    description:
> +      One of the eight modes in which the four internal ROs (Ring
> +      Oscillators)  are combined to generate a stream  of random
> +      bits. The default mode is seven which is the default method
> +      of combining RO random bits on these Aspeed SOCs.
> +
> +    maxItems: 1
> +
> +
> +  quality:
> +    description:
> +      Estimated number of bits of entropy per 1024 bits read from
> +      the RNG.  Note that the default quality is zero which stops
> +      this HRNG from automatically filling the kernel's entropy
> +      pool with data.
> +
> +    maxItems: 1
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - period
> +  - quality
> +
> +
> +examples:
> +  - |
> +    rng: hwrng at 1e6e2074 {
> +         compatible = "aspeed,ast2500-rng";
> +         reg = <0x1e6e2074 0x8>;
> +         period = <4>;
> +         quality = <128>;
> +         mode = <0x7>;
> +    };
> +
> +
> +...
> --
> 2.17.1
>
