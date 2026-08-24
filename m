Return-Path: <linux-aspeed+bounces-4844-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B585C5DF9C
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 23:52:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTSNt33V2z2yr0;
	Tue, 25 Aug 2026 09:51:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787603981;
	cv=none; b=Fseu9blSHIIXy2J0kobm6iJ9y1q5rUmaLDPW/zATQCMgVRHN7/qQgLvgQFPm3s09OaV+mT2+QtniEPZqdkxA4fg+3C3r+S6MoBmPyJ/DcAB4c1TewfkhfcswM7qBCh8TMSwtePAl1A4YsBxyH7p2RkmKBm4ZgGL3GW4GQTXobO5TVIpUYbGDHOmwIFwqpJ9iYQ+ROO3iJST5Gvm7mnNsSiX5BMDqESEalK/XVKaqakF1ER2mywbs+/5rWG3VQrE64EILjuyT6+1Jnpgrk3WOar7gOxdX40xhea7xXT+u1PwWEwEVAwm+O4KOQRuw5lrd7VRljfL/NvSD4ekY51Gdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787603981; c=relaxed/relaxed;
	bh=LEMIXlW7UB4hHdDf5XWpYKY9mKhf7DDvl0I5DYYVcWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asTK8aoMTHF4YmW7T/xl3eJ+SyYHrzErtNR7mlDuqnadfwnPjpfwrR2c+7e61jR41FImR0Amx9JAV128W2v9ZfIiq2ES4ZwbdNltPVmzbFg9i1SoJhebxLUwJxK43pZ+6udrwphN5wK7wlveBccfPrM6mseA3MYI2X1EYVn893cgmpE7HYLhjf8Ufp9xre+7F73yUmL4DCpDJ06zRZw2jRupirA2s8fPSHcL5sT4Kw6fOj0qudYYGjEaeTJNpQ+ZaC4XxHGZnoUiR4QKxKBEZDsqOC/JhA/01gLU0HXNToPGoExo0a5ecd228By3TdJIxSsqdTZn0wRys2uopbJ1NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=op1PqS0Z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=op1PqS0Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTN7c1Ydwz2xr2
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 06:39:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D5C244EFD
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 20:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443F61F00ADF
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 20:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787603977;
	bh=LEMIXlW7UB4hHdDf5XWpYKY9mKhf7DDvl0I5DYYVcWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=op1PqS0ZcwJX9065pz+7n7Mhcirj6eX3k7xLqlZ+ppKs9SUQjaRYatOf7zFET/tfn
	 ul80C8GWnGTALvbcy587qsJUwsDqASYiSFMYfHcPITUgCg3TZF48GkIuTKGWZKFR9M
	 4KN8Sznl1jMlE46rBL1TjVyK3aAD3CngSTThQG0+P9d0RdhdZTKci8rg+oXU2+Knhy
	 NbhSdxhVqpnJaSio1FP0K7pN0IwaOCStdR+sCf1wtsi2SseznQCBLMUxP19S9nO/9Q
	 MUef/TEDW6ujepu5thZa0JHNFheaGU558HmIHS4lCPCIS/Hkxb7SN9fJwNlrWxn60U
	 rLdy0en7BtOBg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-45171f2f608so3599669fac.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 13:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqaBca/er9CH4PGTBUmI6024ya1/E4GPlXCzSo0h5cU3D7NfyT5nfYX32P8rS7l0Ioi3KxY6DZgXG/qZ0o=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kiJefWi5TbO8C5aw9135+axIvDn0+FyeSn0lAIRWyZfuvnSMhc
	2wx9Vg8jrTkaWR8lMSkTYy5HJDoDPW76YkHTHspz+VGDxFF9biBqiMcGyMYTPSLeMX1FNfNXefE
	vlVOJ31BwnlyKonoTa+DNYK5ElhU564c=
X-Received: by 2002:a05:6871:331c:b0:457:ed1a:9da3 with SMTP id
 586e51a60fabf-4644af0a69cmr1563335fac.17.1787603975698; Mon, 24 Aug 2026
 13:39:35 -0700 (PDT)
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
References: <cover.1787239813.git.geert+renesas@glider.be> <33f8a87834a75b6677894f1993c90f00eb6a2547.1787239813.git.geert+renesas@glider.be>
In-Reply-To: <33f8a87834a75b6677894f1993c90f00eb6a2547.1787239813.git.geert+renesas@glider.be>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 22:39:20 +0200
X-Gmail-Original-Message-ID: <CAD++jLnWF5Y+=Dz4XxFyHqrxuOtGucvYLaqMGDNH4XoR1S+rrQ@mail.gmail.com>
X-Gm-Features: AcwNN1XmhR7K3AKRJKXT4Sd3qYlnwrUuNbhbfYVIv-485OoNG4okiQZloSgYvOE
Message-ID: <CAD++jLnWF5Y+=Dz4XxFyHqrxuOtGucvYLaqMGDNH4XoR1S+rrQ@mail.gmail.com>
Subject: Re: [PATCH 10/45] clk: gemini: Make sure clk_init_data is fully initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	David Lechner <david@lechnology.com>, Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	=?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	arm-scmi@vger.kernel.org, imx@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 10:53=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

