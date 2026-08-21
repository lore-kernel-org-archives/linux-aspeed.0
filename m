Return-Path: <linux-aspeed+bounces-4814-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF294C5DF8E
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRHTt6y9pz2yLP;
	Fri, 21 Aug 2026 21:03:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787310194;
	cv=none; b=D30M2ikxUqOPzXAdsAZNCay3M0dqoOYrrDRqPwsv1bGJGFthNh+50hXBrpU4760V9Wc1Kqezq+xngJx/23jpF3x12aUPma3R7YPnHvSAQXY6aSJaQzR/VtTcZJTdHgGF/B+6OYAyNRWMtzw2J+lo+gVlHu4Hts6jQGlrrPZbAAknFMnJJHkvMk+DGArx9t/I87m8WBgjEjjoa71qlQomWzGNg5PCLucuMblJ3roi0tORZ1W6GuOlMtnLGiJp121lvB/W3PwP1zKmkE5v348uQHU52mdKNoqD5BSFR+TDP3n5TA85JGXz73hiLvRZDSrQRCBtVwA1lCrtc0W2FbLZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787310194; c=relaxed/relaxed;
	bh=qhigk4FfzQYWTvMTLq/I40KhIpujv/zfq6N4v+rAOow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djPu2cL7+OW3RzFQKjk50C06F8hEzls6NnnR03b4VjOWtNjN9nvdx2xamacHXKpk+wFmtU51k7k4XBxwxqu3uRNaIK8EDRPXsVfkDbyj6MCTpD+pAEanDEse9STAyuAt9Kv76z6U6rosfY22dmna5FvH1rGtHDPkzDmb9BjUuig/pISbhN2Fcx3bPWrG30yn9vgB59mgaqpBfgnAoQqTGWKOveMYlNeuM5Pw2I/URMyqIvxOUAz2qfHYmMllvU68u0m6c7EaGDxksGHeh1/Qg0L78PySkx1ytaGTFb5RPBaKOFti7YdapSCIpyWN7OrF04d2dMBi+f5weBRzBgQUcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; dkim=pass (1024-bit key; unprotected) header.d=crapouillou.net header.i=@crapouillou.net header.a=rsa-sha256 header.s=mail header.b=BpBexqdH; dkim-atps=neutral; spf=pass (client-ip=185.119.170.32; helo=aposti.net; envelope-from=paul@crapouillou.net; receiver=lists.ozlabs.org) smtp.mailfrom=crapouillou.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=crapouillou.net header.i=@crapouillou.net header.a=rsa-sha256 header.s=mail header.b=BpBexqdH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=crapouillou.net (client-ip=185.119.170.32; helo=aposti.net; envelope-from=paul@crapouillou.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 349 seconds by postgrey-1.37 at boromir; Fri, 21 Aug 2026 21:03:13 AEST
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRHTs0q0jz2yK8;
	Fri, 21 Aug 2026 21:03:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1787309837;
	bh=vTxNGzhiU+qNcfdup2iOrcIIe1C5zjV7/YGX2sRgMes=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BpBexqdHP7l9UXTEi7tNsKJ7v5JrQ5ZdZndkkOW3FK62QJkZPxJxds1XBB60/ptCZ
	 +4FqA3I5gWE42Mn2k6xdUvuXJ8BcmPf1ehfDBkHnO4hKYrgHCV6w9pWnetTgnV1jir
	 xW2jslhE/JH3XZR6Ix/Z58ce1yPaK58iX5BHv9Jg=
Message-ID: <3596303d8fc1ccbdbae9277e599b1a37682fac2a.camel@crapouillou.net>
Subject: Re: [PATCH 14/45] clk: ingenic: Make sure clk_init_data is fully
 initialized
From: Paul Cercueil <paul@crapouillou.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ryan Chen	
 <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, Stephen Boyd	
 <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet	
 <jbrunet+clk@baylibre.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
  Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Taichi Sugaya
 <sugaya.taichi@socionext.com>,  Takao Orito <orito.takao@socionext.com>,
 Linus Walleij <linusw@kernel.org>, Avi Fishman	 <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry	 <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen	 <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Sudeep Holla	
 <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
 David Lechner <david@lechnology.com>, Abel Vesa <abelvesa@kernel.org>, Peng
 Fan <peng.fan@nxp.com>, Frank Li	 <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Santosh Shilimkar	
 <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement	
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth	
 <sebastian.hesselbarth@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Heiko
 Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki	 <s.nawrocki@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Peter Griffin	 <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, Dinh Nguyen	 <dinguyen@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Maxime Coquelin	
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Emilio =?ISO-8859-1?Q?L=F3pez?=	
 <emilio@elopez.com.ar>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec	
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Prashant
 Gaikwad <pgaikwad@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter	 <jonathanh@nvidia.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Matthias Brugger	 <matthias.bgg@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	soc@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Date: Fri, 21 Aug 2026 12:57:09 +0200
In-Reply-To: <e3a8b277773f46eb200f3c4bac98ee380f3a24bc.1787239813.git.geert+renesas@glider.be>
References: <cover.1787239813.git.geert+renesas@glider.be>
	 <e3a8b277773f46eb200f3c4bac98ee380f3a24bc.1787239813.git.geert+renesas@glider.be>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Hi Geert,

Le vendredi 21 ao=C3=BBt 2026 =C3=A0 10:53 +0200, Geert Uytterhoeven a =C3=
=A9crit=C2=A0:
> The clk_init_data structure contains several mutually-exclusive
> members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.=C2=A0 However=
,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE
> is
> enabled.
>=20
> Make sure all members are fully initialized, to avoid such bugs, and
> to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> Compile-tested only.
> ---
> =C2=A0drivers/clk/ingenic/cgu.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 41e4c69131bd6ec7..ad223aa20e8db5a5 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -644,8 +644,8 @@ static const struct clk_ops ingenic_clk_ops =3D {
> =C2=A0static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned
> idx)
> =C2=A0{
> =C2=A0	const struct ingenic_cgu_clk_info *clk_info =3D &cgu-
> >clock_info[idx];
> -	struct clk_init_data clk_init;
> =C2=A0	struct ingenic_clk *ingenic_clk =3D NULL;
> +	struct clk_init_data clk_init =3D {};
> =C2=A0	struct clk *clk, *parent;
> =C2=A0	const char *parent_names[4];
> =C2=A0	unsigned caps, i, num_possible;

