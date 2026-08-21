Return-Path: <linux-aspeed+bounces-4817-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBD4C5DF7D
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 11:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRJ4W0gNFz2xKN;
	Fri, 21 Aug 2026 21:29:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787311787;
	cv=none; b=W9/2rUjeBcrhgyMvf49oG84zMyBGnksKxnQqyeNZuSfBiFfDZxkIoHQkbx2l6tMHjwUGufN0Mg/ft7n3Cx57P0gwp0b1NRKH7bTSBU1IGJRylSST9PUI30msvFwnPoNsYHMc5CHfbgF/i26lhOwI9kZWlGV1ynm8p9lDU3V8lxmZCBlJLjTXxf+Tc3evJ1V4h6Cii3aVRYQM/CK1D6f3rkX0i+BkW74IFVjWbEVaCXHEoBwaThQI67CdXdsES8xUuKZeXljuXgQzuO8CcehgbbtmnpZtt0/Wn3wIYbmr4M9ySL8n2mUJcBu3sWs3+e4Kw/I1ClR5iY4uTlC+MSyJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787311787; c=relaxed/relaxed;
	bh=yvXny4Uzt3tUYS9bpKHRNKA1xycDne4ixBPlCcMH+lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSPmVNMVxvZvoo8eRxydqgZENQN+sOCXhC8pjT1KmrQAqC6lSCkeZ+QW3CK6rCFVxXJTnQKzNtXmKAceCrmXsvAxSfseAjjNyYiYiyTnX+a5HaVK3/CDAvOPa+R0RTwqu2ds+s4OSHg1DD7Ni+waGqyUZeLLG1bWFbAsCQgsJKgpz28vxhYwtN714dT+yZt0MI2Avc9s0b3dfpWu9cuPKBNU89f52HcH4RynbelWzc3bG1D0nJ7coMH0Gv9yvk3gumwLiTRI0sBnGsKwJXHEBDlvKEhZjhc1OEvmvGPES0Q0eI/Czq+HZoQipUbAbclVUoHBQGkKBerX2s5QAdW+cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eGnnwg7S; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=liviu.dudau@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eGnnwg7S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=liviu.dudau@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRJ4S6ww8z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 21:29:44 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DAF822C8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 04:29:09 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 012B73F763
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787311753; bh=rReboDtVWR+LchIn66VCIiRA4RrsNZEU4pEK04rnFMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGnnwg7Sqv+uHxl6WRHEjI9MzT/5e0EM2f25m5rFWCT0h10dPLDyr9uDP+o6wZiWA
	 3sKkDqP8eNCW6mggHaiiwsyAX0rihOiulqDVc4g4fhdZQfHcPBN1bCNaJcd+EHh5hg
	 8DV5czwVke18MVEqqmYe/3Evz36eEAqMBmeWJrvs=
Date: Fri, 21 Aug 2026 12:28:01 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Linus Walleij <linusw@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	David Lechner <david@lechnology.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 40/45] clk: versatile: Make sure clk_init_data is fully
 initialized
Message-ID: <aog2QXT_86BrtvTs@e142607>
References: <cover.1787239813.git.geert+renesas@glider.be>
 <7c480e73222bb51982fb82dc0cc6cd503f2e8b92.1787239813.git.geert+renesas@glider.be>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c480e73222bb51982fb82dc0cc6cd503f2e8b92.1787239813.git.geert+renesas@glider.be>

On Fri, Aug 21, 2026 at 10:53:50AM +0200, Geert Uytterhoeven wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Compile-tested only.
> ---
>  drivers/clk/versatile/clk-icst.c         | 2 +-
>  drivers/clk/versatile/clk-sp810.c        | 2 +-
>  drivers/clk/versatile/clk-vexpress-osc.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
> index 6bd3db54dd229d28..97a1bfd6cf0ed995 100644
> --- a/drivers/clk/versatile/clk-icst.c
> +++ b/drivers/clk/versatile/clk-icst.c
> @@ -360,8 +360,8 @@ struct clk *icst_clk_setup(struct device *dev,
>  {
>  	struct clk *clk;
>  	struct clk_icst *icst;
> -	struct clk_init_data init;
>  	struct icst_params *pclone;
> +	struct clk_init_data init = {};
>  
>  	icst = kzalloc_obj(*icst);
>  	if (!icst)
> diff --git a/drivers/clk/versatile/clk-sp810.c b/drivers/clk/versatile/clk-sp810.c
> index b0e69686f7a9a93e..28e5c0cf1fda38e4 100644
> --- a/drivers/clk/versatile/clk-sp810.c
> +++ b/drivers/clk/versatile/clk-sp810.c
> @@ -86,7 +86,7 @@ static void __init clk_sp810_of_setup(struct device_node *node)
>  	const char *parent_names[2];
>  	int num = ARRAY_SIZE(parent_names);
>  	char name[12];
> -	struct clk_init_data init;
> +	struct clk_init_data init = {};
>  	static int instance;
>  	int i;
>  	bool deprecated;
> diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> index 9adbf5c33bd1cada..72e872ec6b7c9b47 100644
> --- a/drivers/clk/versatile/clk-vexpress-osc.c
> +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> @@ -64,7 +64,7 @@ static const struct clk_ops vexpress_osc_ops = {
>  
>  static int vexpress_osc_probe(struct platform_device *pdev)
>  {
> -	struct clk_init_data init;
> +	struct clk_init_data init = {};
>  	struct vexpress_osc *osc;
>  	u32 range[2];
>  	int ret;
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

