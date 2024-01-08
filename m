From: Mark Brown <broonie@kernel.org>
Date: Mon, 8 Jan 2024 21:34:47 +0000
Subject: [PATCH v2 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
In-Reply-To: <20240108204114.1041390-4-ninad@linux.ibm.com>
References: <20240108204114.1041390-1-ninad@linux.ibm.com>
 <20240108204114.1041390-4-ninad@linux.ibm.com>
Message-ID: <b09d6e54-66e9-482f-8f45-38381fa6b62e@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 08, 2024 at 02:41:14PM -0600, Ninad Palsule wrote:

> +	regulator at 60 {
> +		compatible = "maxim,max8952";
> +		reg = <0x60>;
> +
> +		max8952,default-mode = <0>;
> +		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
> +						<1050000>, <950000>;
> +		max8952,sync-freq = <0>;
> +		max8952,ramp-speed = <0>;
> +
> +		regulator-name = "VR_1.0V";
> +		regulator-min-microvolt = <770000>;
> +		regulator-max-microvolt = <1400000>;

A regulator labelled VR_1.0V can vary between 0.77V and 1.4V and has
exactly the same configuration as another regulator labelled VR_1.2V?
That seems...  odd?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240108/958e027d/attachment.sig>
