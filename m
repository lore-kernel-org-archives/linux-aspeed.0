Return-Path: <linux-aspeed+bounces-4845-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4D0C5DF81
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 23:52:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTSNt4Mrnz2yr2;
	Tue, 25 Aug 2026 09:51:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787577414;
	cv=none; b=W6o7s+7pma9NBy2zz3TRJHXzHCcIZTKCG+x4J2z0Hl2+RtkeUAnXBgxF6646lyLWMxXe4drMefVPjZ3Cvr0YssMNl7fuPv+WhnSM2xvyVdINex0KUWcxT6cQPNUTdcwUDabahJZTw0wfa9PT9tAgKlbfIpylgSW/DkevW0ftue/UugIFQvXmkHisuxeyFWbUYA3WQAkW15S95bY9jv3smbrYMKuUIia+J9/TwgUHlcK8KEQ4fORf+MP4KA3OFA2vdTmwbLFvbe4J1lGd5Ka4buA0g5svQc0UbgXs8/Rfv5wRL70obsnezN1hg6Krm/848/LtPxzQ58pa4P5Z7Vnqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787577414; c=relaxed/relaxed;
	bh=a5uoZNVB2XRKnrTBdvCmJrG8M4XSoSEJo8KaXU4b4e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eF4olFjlG9uyvPxksF1RtCOp/Iq9OpDkaAAhiFmvt8sNUqAyqygAiHsq36rxzzw9OS/YvO0QbQWVAavJFDdC5VsNhLRL8IvM82TmxXRlTMSR5JVWRf2Y62CaL9+H30j1PFWQ+w1yj8Kr0UXFZ8qliZrRdcuB+732OhtlNSCiSU5SpTmY04THkt3bYNN4HWLxH49b74WcpJYM3JUIWT4Fdcos2y8wP4uWblnhOhnl5PxxzXYGnPhyBKZNYMAirOiwmr+5z//7Ia5zLieN9mwaaXULtFj/76WC+K2ImieJNPzZI5MDz8RxCEIOp4BURMs99Wo+Gk/cBQaZITQh/B2zug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IKg/D0on; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IKg/D0on; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IKg/D0on;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IKg/D0on;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTBJj0rM1z2xnW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 23:16:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787577406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5uoZNVB2XRKnrTBdvCmJrG8M4XSoSEJo8KaXU4b4e8=;
	b=IKg/D0on6WuGIEkDRlaA0AGzaoUcMm9W7vHGwfBWAJy9PM1TAsZ835LTmG9fe7n+UgnIFF
	bvopKA+EBWEpOmco21ROIk5dc1pKqA14gO8mCCyOW4PPReTY0qxr9Q2Eqkr9ZRnyin93aC
	96Kp3cH7vPISNQm2ue5R69NB2ZqffVM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787577406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5uoZNVB2XRKnrTBdvCmJrG8M4XSoSEJo8KaXU4b4e8=;
	b=IKg/D0on6WuGIEkDRlaA0AGzaoUcMm9W7vHGwfBWAJy9PM1TAsZ835LTmG9fe7n+UgnIFF
	bvopKA+EBWEpOmco21ROIk5dc1pKqA14gO8mCCyOW4PPReTY0qxr9Q2Eqkr9ZRnyin93aC
	96Kp3cH7vPISNQm2ue5R69NB2ZqffVM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-k9SLU70bN1WNyOYXyn2tHA-1; Mon, 24 Aug 2026 09:16:44 -0400
X-MC-Unique: k9SLU70bN1WNyOYXyn2tHA-1
X-Mimecast-MFC-AGG-ID: k9SLU70bN1WNyOYXyn2tHA_1787577403
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7f5b54da461so58803257b3.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 06:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577403; x=1788182203;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5uoZNVB2XRKnrTBdvCmJrG8M4XSoSEJo8KaXU4b4e8=;
        b=aV9JoyAWZHIfD3myJOSVj3srRiWt3CKs6GBSKwzKIHnxJQHbXMrU109MWZugQkVsPd
         pCiHoTYY8XCEAdkQ/o5ZNErDGQops1VZepjrrKNUhGx7oOHZk/0h/bIfSYNzbX7U0IKi
         iBhYuPTZoD5dEnniT32glieZEW4WxvqwRoJu/MobDHOLKPe+SRf2VG48wG+EZ2qDKK7s
         t1qixe27E5JP6RWf9YKZ+1oG4uEm066gUEh87swY5awA5g3SuRNnycnniwTU7i6lwLbe
         EnT5gktrN0yG5D8OLFH3CjM2zFznCtDEsMNNvyqqPreugofgTd6nBllIwnoekFJvqKjc
         7Acg==
X-Forwarded-Encrypted: i=1; AHgh+RoiBTn1sbY2J9Vl9MysSvBdWEU9HteQ4XG3LKFyVXiCSw9biztlPu3ZEyLn2Z1yc3NRg7jKS1973bUvdXo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ldQQbipnT3pGFJfuy3zMPaTuxyyW9b2obGASlFynBO/GVmnJqn
	E83V2IiAUv6tCKuGjWqIIFuvVDvZZkZ/av18bZJYNF+HaWcYOYLUpwC5FQYXb0vIOImxiW4Tbes
	9WZoTUf6TXQqeg07NDlIawL6l4rqpit0zuQQJDQ85CvMJ53WzOtxolGulzV32tyzU7p8=
X-Gm-Gg: AR+sD12dJnCAOObpEAOw3o0PrRZk6+0DVmi3srTNm3JlwYMuxLJ2h3YGPLR80VN7zBB
	PxCpU5g2jMLz1JvNr55t6bikPpZlwjD62aCuvc6McvYHH7qVUx48xzy/92mAX7xap1eQhaRQ6IB
	dGRU4EsKXKngtptf17HswNvYqHra4PCnHxk6LEiO1Dtk+xqR01LkTqvDGIwdeUJmWEhzP13dO4P
	l9diZqcPSqx5CbS9HZELiWoRIeLzjHhrL9TwwkdOpIE/YrdhNi7CoRotlIfUU0TFgDk7cMF+JV7
	UVfiHWrNpBxFS1y0RMxjtspIP9Vpr5daXs2xASmcs5aExFtEuGty8n6iFJ0o08KBOTU4xH/FNw8
	b/H/AtOFygYzR4ycArk+jf/+R22yeFB9E7Jg=
X-Received: by 2002:a05:690c:e0c1:10b0:81e:a4cf:131b with SMTP id 00721157ae682-849f4a7cc91mr76173127b3.22.1787577403129;
        Mon, 24 Aug 2026 06:16:43 -0700 (PDT)
X-Received: by 2002:a05:690c:e0c1:10b0:81e:a4cf:131b with SMTP id 00721157ae682-849f4a7cc91mr76172227b3.22.1787577402495;
        Mon, 24 Aug 2026 06:16:42 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5d254adsm33243617b3.16.2026.08.24.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:16:41 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:16:34 -0400
From: Brian Masney <bmasney@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
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
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
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
Subject: Re: [PATCH 29/45] clk: samsung: Make sure clk_init_data is fully
 initialized
Message-ID: <aoxEMm6FGf_onEBf@redhat.com>
References: <cover.1787239813.git.geert+renesas@glider.be>
 <87b3e83137e1a987f3c69d214706e93ef3898cab.1787239813.git.geert+renesas@glider.be>
 <60a8d05a-76fa-43c3-a0f7-fb26a3b659b8@kernel.org>
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
In-Reply-To: <60a8d05a-76fa-43c3-a0f7-fb26a3b659b8@kernel.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RfTUM1m811u1vTKWiIl4vdJ-boMBTUT9K82tJCxuj-8_1787577403
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Krzysztof,

On Fri, Aug 21, 2026 at 01:04:01PM +0200, Krzysztof Kozlowski wrote:
> On 21/08/2026 10:53, Geert Uytterhoeven wrote:
> > The clk_init_data structure contains several mutually-exclusive members
> > for different methods to specify the possible parents of a clock,
> > prompting drivers to initialize only the members they need.  However,
> > not initializing all members may cause subtle issues, which are only
> > exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> > enabled.
> > 
> > Make sure all members are fully initialized, to avoid such bugs, and to
> > prevent future breakage when converting drivers to a different method
> > for specifying the parents.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Compile-tested only.
> > ---
> >  drivers/clk/samsung/clk-cpu.c | 2 +-
> >  drivers/clk/samsung/clk-pll.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Let me know if I should take it via Samsung SoC clock tree. I assume by
> default this will go directly via clock tree.

Please take it through your Samsung tree to avoid merge conflicts if
there are other changes to these files during this development cycle.

Brian


