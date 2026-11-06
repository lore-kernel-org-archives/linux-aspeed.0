Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BD606A330
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=S9CZ7drU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLbfN5CH3z2xPb;
	Fri, 06 Nov 2026 21:54:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793962476;
	cv=none; b=RHWu+OVSwSeB0REl41is7Hy/CbFoy1tcxYAi4egdbtDE4E8ZazEbmMdZtAngsoSxs4c7CB0+Sb9j6fPKxWnpmhTqjrOaUxX2dsgSfQSknr8t1PoyeN6ZFTzrsj4SBHnM9JQefu+rSOKAQBEui+o5p6LyvyyqDk5anm7YOb0o7QzKt5IlI/53HOf7/l3nM3x0MI1y4KZMCa9PVyOglUidxHxU/FWUALMKAs73IwzO4MDHR+7LHmeF9JOUfOfFltMFRRBZytKdLEK9y05IqEU8JWueZuzvrcZaOIRzfedrsV0HmNw97RBEzCGncmFXL5n8CkAWE5tgWXRpQvrR9MiYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793962476; c=relaxed/relaxed;
	bh=T/o8bXf5PHZlheqxRxfmBCJt/OymULZgaq0Uhe1HUU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nobyFBYd6ElhcL8wNdUkkXk9y25KjWxh4ngmVY4XmZwYLNBIH2Wayyfp25ftooeXb+ufIPYhAabkjJ8qtsB+HcFzrHnklaoV9SfiHf+tOYCfwt19cJ96aU+HtNpJ+W36SusWu7cjS+2ZbIsjBrEIzMDKqE7vnqS5txXqxXBTbqKRlnOMTEb7DQ9WrbZItM5mamB7O2dw2vghIYMFwWOJ4joRtg05StrRv6XWfVJZ04Wxx0VuQ7EypN9MF5G2L6VFUs1rnmNmxelf92us5ysMhmvBQn1MS1Vy9MaWvXvgcCaJCjHCCFfdqrU/kdiiByEh7r2bRTkSE9qu3dekKFn/8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=S9CZ7drU; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=S9CZ7drU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLbfM2mZFz2xNC;
	Fri, 06 Nov 2026 21:54:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793962472;
	bh=T/o8bXf5PHZlheqxRxfmBCJt/OymULZgaq0Uhe1HUU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S9CZ7drUjqsCJ8M15r9HvsUT9+474uDOoxRacnjTRbGxcbNWAwYsSkurkrLIDbxA+
	 cz78l6XQlnKNm5n0vX0iHIPmOOAb2TpP6EFLrDlpkqYcdBS+6oFGsj6cgHPLhWDjc3
	 cB1vZapkoUL6tFhOhgAjKpevKy0K+PwyBMT0d4XiopyfdVf+UT9NgbGT4MydNPvROJ
	 41lwszhU25LKpy7CrM375gnYDK6U5ot2OSmOHTYTAdnaGVpGu6pOaENTZEw/THPPK3
	 topzgx3s79HCzmRM208DOiLZ24j8rbTQitAJDqa1iLhCid8QwrY/tGgBMSLY1Z1DTs
	 za+KuJnn1iXJA==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 170FA64952;
	Fri,  6 Nov 2026 18:54:31 +0800 (AWST)
Message-ID: <71eb94df4d373d0f3afbe2a8ff880869f96e054b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/2] pinctrl: aspeed: Hand over global GPIOP
 passthrough to local mux controls
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>, 
	linusw@kernel.org, Tan Siewert <tan.siewert@9elements.com>
Cc: joel@jms.id.au, ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com, 
	brgl@kernel.org, tan.siewert@9elements.com, linux-aspeed@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Nov 2026 21:24:29 +1030
In-Reply-To: <20261106022907.10735-3-prasanth.padarthi10@gmail.com>
References: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
	 <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
	 <20261106022907.10735-3-prasanth.padarthi10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Prasanth,

On Fri, 2026-11-06 at 07:59 +0530, Prasanth Kumar Padarthi wrote:
> On B650D4U, GPIO-only host power control fails when SCU51C[9]
> enables GPIOP passthrough, even after the normal GPIO request path
> clears the individual SCU4BC selections.
>=20
> Transfer globally selected GPIOP0-P5 THRU roles to SCU4BC[29:24]
> before registering the controller, then clear the active shared
> sources. Leave PWM selection and the strap-source selector unchanged.
> Clear SCU510[28] through SCU514 and verify the shared enables cleared.
>=20
> If handover fails, retain an instance-local error and reject affected
> GPIO and mux requests before changing their mux state. Check every
> pin in a mux group before calling the shared helper. Retain prepared
> local selections after partial failure rather than blindly restoring
> a shared enable.
>=20
> Probe-time normalization policy, concurrent SCU writers and
> post-handover registration failure remain open design questions.
> Electrical continuity, mixed-pair forwarding, protected-write paths,
> PWM coexistence and SCU510[28] hardware handling remain unvalidated.
>=20
> The implementation passed remote power-on, remote graceful power-off
> and physical-button power-on tests on B650D4U with an OpenBMC Linux
> 6.18.24-based kernel. The rebased version was ARM compile-tested on
> v7.4-rc1 using aspeed_g5_defconfig with AST2600 pinctrl enabled.
> With the managed-registration prerequisite, the v7.4-rc1 version
> also completed one unbind/rebind cycle under generic KASAN on
> B650D4U hardware and in AST2600 QEMU. Host power operations have
> not been retested with the v7.4-rc1 kernel.
>=20
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> ---
> =C2=A0drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 145 ++++++++++++++++++=
++-
> =C2=A01 file changed, 141 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl=
/aspeed/pinctrl-aspeed-g6.c
> index 85d6640ff..be22a9184 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> @@ -4,7 +4,10 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> =C2=A0#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> =C2=A0#include <linux/pinctrl/pinctrl.h>
> =C2=A0#include <linux/pinctrl/pinmux.h>
> =C2=A0#include <linux/types.h>
> @@ -36,6 +39,8 @@
> =C2=A0#define SCU4D8		0x4D8 /* Multi-function Pin Control #23 */
> =C2=A0#define SCU500		0x500 /* Hardware Strap 1 */
> =C2=A0#define SCU510		0x510 /* Hardware Strap 2 */
> +#define SCU514		0x514 /* Hardware Strap 2 Clear */
> +#define SCU51C		0x51c /* Hardware Strap 3 */
> =C2=A0#define SCU610		0x610 /* Disable GPIO Internal Pull-Down #0 */
> =C2=A0#define SCU614		0x614 /* Disable GPIO Internal Pull-Down #1 */
> =C2=A0#define SCU618		0x618 /* Disable GPIO Internal Pull-Down #2 */
> @@ -2743,12 +2748,56 @@ static struct aspeed_pinctrl_data aspeed_g6_pinct=
rl_data =3D {
> =C2=A0	.nconfmaps =3D ARRAY_SIZE(aspeed_g6_pin_config_map),
> =C2=A0};
> =C2=A0
> +struct aspeed_g6_probe_data {
> +	struct aspeed_pinctrl_data pdata;
> +	int thru_error;
> +};
> +
> +static bool aspeed_g6_is_thru_pin(unsigned int pin)
> +{
> +	return pin >=3D AB22 && pin <=3D AB23;
> +}
> +
> +static int aspeed_g6_gpio_request_enable(struct pinctrl_dev *pctldev,
> +					 struct pinctrl_gpio_range *range,
> +					 unsigned int offset)
> +{
> +	struct aspeed_pinctrl_data *pdata =3D pinctrl_dev_get_drvdata(pctldev);
> +	struct aspeed_g6_probe_data *g6 =3D
> +		container_of(pdata, struct aspeed_g6_probe_data, pdata);
> +
> +	if (g6->thru_error && aspeed_g6_is_thru_pin(offset))
> +		return g6->thru_error;
> +
> +	return aspeed_gpio_request_enable(pctldev, range, offset);
> +}
> +
> +static int aspeed_g6_set_mux(struct pinctrl_dev *pctldev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int function, unsigned int group)
> +{
> +	struct aspeed_pinctrl_data *pdata =3D pinctrl_dev_get_drvdata(pctldev);
> +	struct aspeed_g6_probe_data *g6 =3D
> +		container_of(pdata, struct aspeed_g6_probe_data, pdata);
> +	const struct aspeed_pin_group *pgroup =3D &pdata->pinmux.groups[group];
> +	unsigned int i;
> +
> +	/* Check the entire group before the shared helper changes any pin. */
> +	if (g6->thru_error) {
> +		for (i =3D 0; i < pgroup->npins; i++) {
> +			if (aspeed_g6_is_thru_pin(pgroup->pins[i]))
> +				return g6->thru_error;
> +		}
> +	}
> +
> +	return aspeed_pinmux_set_mux(pctldev, function, group);
> +}
> +
> =C2=A0static const struct pinmux_ops aspeed_g6_pinmux_ops =3D {
> =C2=A0	.get_functions_count =3D aspeed_pinmux_get_fn_count,
> =C2=A0	.get_function_name =3D aspeed_pinmux_get_fn_name,
> =C2=A0	.get_function_groups =3D aspeed_pinmux_get_fn_groups,
> -	.set_mux =3D aspeed_pinmux_set_mux,
> -	.gpio_request_enable =3D aspeed_gpio_request_enable,
> +	.set_mux =3D aspeed_g6_set_mux,
> +	.gpio_request_enable =3D aspeed_g6_gpio_request_enable,
> =C2=A0	.strict =3D true,
> =C2=A0};
> =C2=A0
> @@ -2778,15 +2827,103 @@ static const struct pinctrl_desc aspeed_g6_pinct=
rl_desc =3D {
> =C2=A0	.confops =3D &aspeed_g6_conf_ops,
> =C2=A0};
> =C2=A0
> +/*
> + * Experimental: transfer the global GPIOP0-P5 THRU selection to the
> + * individual mux controls before registering any pinctrl consumers.
> + * PWM selection is higher priority and is deliberately left unchanged.
> + *
> + * Do not undo the local selections on error: a shared enable may alread=
y
> + * have cleared. Keeping the equivalent local selections preserves routi=
ng
> + * while rejecting affected requests, rather than granting an unsafe GPI=
O.
> + * Signal continuity during this transfer still needs hardware validatio=
n.
> + */
> +static int aspeed_g6_thru_handover(struct regmap *scu)
> +{
> +	const u32 local_mask =3D GENMASK(29, 24);

Defining a variable with the value (even though that variable is
qualified const) means it's not an integer constant expression, which
may impede some optimisations.

Further, local_mask is not a descriptive name for what's occurring
here. Please name the mask in terms of its behaviour. Perhaps:

#define GPIOP_UNGROUPED_PASSTHROUGH_MASK GENMASK(29, 24)

> +	unsigned int strap2, strap3, local;

Please lets improve on the name 'local'. Perhaps: ungrouped_passthrough

> +	int ret;
> +
> +	ret =3D regmap_read(scu, SCU510, &strap2);
> +	if (ret)
> +		return ret;

Consider this error-handling strategy:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/pinctrl/pinctrl-gemini.c?h=3Dv7.4-rc1#n2556

If the first read doesn't work, then we can't expect any of the further
accesses by the core aspeed pinctrl implementation to work either, so
we can just bail out entirely in the caller.

> +	ret =3D regmap_read(scu, SCU51C, &strap3);
> +	if (ret)
> +		return ret;
> +
> +	if (!(strap2 & BIT(28)) &&
> +	=C2=A0=C2=A0=C2=A0 ((strap2 & BIT(30)) || !(strap3 & BIT(9))))

Please give these bits named macros. This is not easy to comprehend as
it is.

Also, consider FIELD_GET() from include/linux/bitfield.h. Something
like:

   if (!FIELD_GET(OTPSTRAP_ENABLE_GPIO_PASSTHROUGH, strap2) &&
       (FIELD_GET(OTPSTRAP_ENABLE_DEDICATED_STRAP_PINS, strap2) ||
           !(FIELD_GET(STRAP_ENABLE_GPIO_PASSTHROUGH, strap3)))


> +		return 0;
> +
> +	/* Preserve every globally selected role, including under PWM. */

This comment feels like a classic LLM statement that somehow manages to
be simultaneously both too abstract and too detailed, while also devoid
of context, all in 8 words.

Can we rather say that the PWM functions on these pins are higher
priority in the mux than the pass-through GPIO function, so if PWM is
already selected, then the following write does not affect the PWM
configuration?

> +	ret =3D regmap_update_bits(scu, SCU4BC, local_mask, local_mask);
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_read(scu, SCU4BC, &local);
> +	if (ret)
> +		return ret;
> +	if ((local & local_mask) !=3D local_mask)
> +		return -EPERM;

Please add a comment here about the write-protection in SCUF30.

> +
> +	/* Leave the inactive GPIOZ6 source alone in dedicated-strap mode. */

'dedicated strap mode' is a confusing statement because ASPEED's
documentation is confusing. I think we can drop this comment with
regard to making other improvements.

> +	if (!(strap2 & BIT(30)) && (strap3 & BIT(9))) {

We've already inspected these bit values previously. Please consider
extracting them to bool variables for re-use and to improve everyone's
ability to comprehend the expression.

> +		ret =3D regmap_update_bits(scu, SCU51C, BIT(9), 0);

Essentially, having configured the ungrouped passthrough functions
above, we can now de-configure the grouped passthrough function in
strap3 (SCU51C).

It's probably worth noting in a comment that SCU51C cannot be write-
protected.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (strap2 & BIT(28)) {
> +		/* SCU510 is write-one-set; do not use an ordinary RW clear. */
> +		ret =3D regmap_write(scu, SCU514, BIT(28));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_read(scu, SCU510, &strap2);
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_read(scu, SCU51C, &strap3);
> +	if (ret)
> +		return ret;
> +	if ((strap2 & BIT(28)) ||
> +	=C2=A0=C2=A0=C2=A0 (!(strap2 & BIT(30)) && (strap3 & BIT(9))))
> +		return -EPERM;

This appears to be the negated expression of the earlier one, and given
we're only returning a fixed value in either case, you could rather use
the same expression again. Given it's repeated, you could extract it to
a macro or static inline function.

> +
> +	return 0;
> +}
> +
> =C2=A0static int aspeed_g6_pinctrl_probe(struct platform_device *pdev)
> =C2=A0{
> -	int i;
> +	struct aspeed_g6_probe_data *g6;
> +	struct regmap *scu;
> +	int i, ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +	scu =3D syscon_node_to_regmap(pdev->dev.parent->of_node);
> +	if (IS_ERR(scu))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(scu),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "No SCU regmap for THRU handover\n");
> +
> +	g6 =3D devm_kzalloc(&pdev->dev, sizeof(*g6), GFP_KERNEL);
> +	if (!g6)
> +		return -ENOMEM;
> +	memcpy(&g6->pdata, &aspeed_g6_pinctrl_data, sizeof(g6->pdata));

This seems unfortunate.

Have you considered other approaches?

> +
> +	ret =3D aspeed_g6_thru_handover(scu);

Must this logic be separate to the usual set_mux path? If not, I expect
we don't need to retain thru_error.

> +	if (ret =3D=3D -EPROBE_DEFER)

Do you have an example of how ret could be -EPROBE_DEFER?

> +		return ret;
> +	if (ret) {

If this handover logic is to be integrated here, can you please test
for specific return values to separate the regmap access failure from
the write-protection failure?

Related, I've heard opinions from Tan that this patch is not necessary
to get the platform booting. Given the current complexity, I'm
interested to hear whether you can do without it.

Andrew

