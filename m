Return-Path: <linux-aspeed+bounces-4820-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D7C5DF87
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 13:41:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRM0G6jcyz2xWt;
	Fri, 21 Aug 2026 23:41:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787319678;
	cv=none; b=VzslcEprCPQCCMDjbVE70++13sEH0Er3JZrX8OINeNNUZCF2kYIrWVnueUMdyzDUk0c45EEu9LamPF+o7mh1KWL9DgEwYFT00eio8QYO0V9H4AJqUwXDcAfpZ/hHRtHfYH1tGm+RVzbdUNZLYgJDRFvJzpYwG7s/d8CyKoCdbHQ2H9H4TSMDR+mMOmbzscGphG6ddR065SoHm5+GqHUU2n5xkowB24FVAZ50Xod001dkb9hzflFt6IfGU+0xN5YHmMeFFiTwnYYhhPiQ1J7klJzssg6xrGFugNekHn1SA9LS5pFYgSZDRFsIpyjXJ0MbnYkokR0unsdyvzTK0CbmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787319678; c=relaxed/relaxed;
	bh=snYMSQGLX7fdVb26BR0eBaIgLA3y4337AX1lKdDJKJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J58fTsj8dvjuFJmkxJuqyTdZoufzM+f1JAwgFKG9tu1N9m7Uk9D4c7kVG8jL2vIVhviFUIZA2ow6NQekKog7w3J9Ymgo+62Uuo5NNCSsWjd+id7opEBoim+xSf6DmIw1T1A6bThw0sjwzeWQwe2GdeH1lXChDtokpm+HC1918JIe5uk9ECusTySWnzh/VtkOli/nKNqifuM8RHyC/Xb05tWFHFbQKqsaRdbRzXTj/AGecctlWv5/VcidJxJeLyhbeLl9FQ4j0908P/7rWpDhMyQdXV5B6K8PYH2x/03ZOzGFReHeQZIoaHXJs9XoCwtWz5NgOX4SY12wfbVjJG5DTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=TiVTjfTc; dkim-atps=neutral; spf=pass (client-ip=68.232.153.233; helo=esa.microchip.iphmx.com; envelope-from=prvs=6865a69cf=nicolas.ferre@microchip.com; receiver=lists.ozlabs.org) smtp.mailfrom=microchip.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=TiVTjfTc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=microchip.com (client-ip=68.232.153.233; helo=esa.microchip.iphmx.com; envelope-from=prvs=6865a69cf=nicolas.ferre@microchip.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Fri, 21 Aug 2026 23:41:16 AEST
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRM0D2bKYz2xQ7;
	Fri, 21 Aug 2026 23:41:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787319677; x=1818855677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nZtcGenSSy82MXscgS3TQDHNGhXxDRFUvHEV/XVmaDg=;
  b=TiVTjfTcjlIyZeyM6vsGeTFDnBALumnbEh6H7rxWGtOgp43K3rCWG08q
   z4egXeEsZp34HyMmI/FRmhsuMYZ+SNcn+lvaoUo7AKDZZnUHomQzdVFOY
   RIW+6kGjAdG6z2SEbxFO2JfNo5Z773yIHSfZSH+BopeD6JzNdQFlqT+L4
   x4GVj9ZiDA9gt2ymxukvh+mEYIjy1ft6LxRZTawMrhcvKycQI0+UKtnxG
   MtF3QXX9BaryVa1k+9z7BBJqf0BTdhcH9EKty0iaNmWT+837y1lIaA7EW
   TANxlt5EYlYh4pIKdzv6TLvPwHr4nAvE7gDfXOHGe15avUzejHcAExYyU
   Q==;
X-CSE-ConnectionGUID: HyXRN8+nRO6IAOBi+2U6dQ==
X-CSE-MsgGUID: F1ngVutmTiOQH0sP1B/9VA==
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="62471628"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2026 06:40:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 21 Aug 2026 06:40:04 -0700
Received: from [10.171.248.60] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 21 Aug 2026 06:39:47 -0700
Message-ID: <0903bc22-e913-4e14-99f6-db6b97aa3a27@microchip.com>
Date: Fri, 21 Aug 2026 15:39:46 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/45] clk: at91: Make sure clk_init_data is fully
 initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ryan Chen
	<ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, Stephen Boyd
	<sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
	<jbrunet+clk@baylibre.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Taichi
 Sugaya <sugaya.taichi@socionext.com>, Takao Orito
	<orito.takao@socionext.com>, Linus Walleij <linusw@kernel.org>, Avi Fishman
	<avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry
	<tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen
	<yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Sudeep Holla
	<sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, David
 Lechner <david@lechnology.com>, Abel Vesa <abelvesa@kernel.org>, Peng Fan
	<peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>,
	Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Heiko
 Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester
 Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Dinh Nguyen <dinguyen@kernel.org>, Viresh Kumar
	<vireshk@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Emilio_L=C3=B3pez?=
	<emilio@elopez.com.ar>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Prashant
 Gaikwad <pgaikwad@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
CC: <linux-clk@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <arm-scmi@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <soc@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
References: <cover.1787239813.git.geert+renesas@glider.be>
 <f402b659481b7e5abe90340bb43adc427cdfe70f.1787239813.git.geert+renesas@glider.be>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <f402b659481b7e5abe90340bb43adc427cdfe70f.1787239813.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2026 at 10:53, Geert Uytterhoeven wrote:
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
> ---
> Compile-tested only.
> ---
>   drivers/clk/at91/clk-audio-pll.c | 4 ++--
>   drivers/clk/at91/clk-h32mx.c     | 2 +-
>   drivers/clk/at91/clk-main.c      | 2 +-
>   drivers/clk/at91/clk-pll.c       | 2 +-
>   drivers/clk/at91/clk-plldiv.c    | 2 +-
>   drivers/clk/at91/clk-slow.c      | 2 +-
>   drivers/clk/at91/clk-smd.c       | 2 +-
>   drivers/clk/at91/clk-usb.c       | 6 +++---
>   drivers/clk/at91/sckc.c          | 2 +-
>   9 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Geert,
   Nicolas


