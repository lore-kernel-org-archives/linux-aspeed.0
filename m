Return-Path: <linux-aspeed+bounces-4890-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69910C624CF
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 00:04:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYmM15tHbz2y2P;
	Tue, 01 Sep 2026 10:04:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788190576;
	cv=none; b=B/6A3YnBTo5yMpPefB+AyEqdNcUAJ+Y8uvzVujOasZgJeQiU8EsTi4Y5acFZUa9tbW6/quN+sxH6YeyitVa/aRQxSURFrNJNaVn5l/603UQ0MeVeSkIZgXGfdWsuXRUjIUumFyuoxp3hW6/bPbarFIKNNPUPAw1uiN5l9KX0jIAF5TztAtqQnIT093AUIQFKHtz9vIXZy01b+HH/zMoOdlAvAlvBim6F4FwWIyS6SQw7oj4mQc055Tx3VPNrMAclHmp24qaXtigg08ZIZC8yYumk/rDM6QZYShFIav5xFN14Z6WK++wtORl+4Pw8RccY4uEs3/4DmR/l3eWbuLYb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788190576; c=relaxed/relaxed;
	bh=uVxBilOuJ3eJRjLFViKxIC+i5050iOvt2YALC/2UHq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DEDmiUR6gV7711Mil32GMUDXsLbmPri9cy1h6HG2WPA1eT6us1FyYPb62DDIpLBoREbpImUOz2YeLL1VmNX6Flmg0YOW20wmYplktONpZycSMmUEjX0Ro1knpWxPmdHVxG+lq9xDIlcrOqTYC5smJUt/C6NuRydSRoAWgLwZoLLKqqJH95RjY+8LWyUw7/Z+btLvA8ZjxYAmv82T7d4x5kL4du+NoVWGXOQJm0dApv8TQr6+6a5828gXqa8PHKhODRlDerIHGEi6lo9+jw5bo/SosmG7WKDfpOMB5+TXDiwZLdNuvOSmiBc2g12CKtdIDNY7NtWK7WGlAnQrOLOJ2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dakA0lC1; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DoZaRGFO; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dakA0lC1;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DoZaRGFO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYY4G1rNLz2y2J
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 01:36:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788190568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVxBilOuJ3eJRjLFViKxIC+i5050iOvt2YALC/2UHq4=;
	b=dakA0lC1O+Wx9Un543FmnQ6r29Xds96hGCtuQA0VAHdBGT4SYp21rIzYG6yTjUx4ehqvn9
	c08hMuqN3YlfCLEhSC3xsVCpI50N3PWBXPbusYv/nz3G1+t0tRx0ybS8myVyb71FOJZZpU
	JUSv2Oq8Nn0tNxtxjBy9F1QDAWhlfUU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788190569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVxBilOuJ3eJRjLFViKxIC+i5050iOvt2YALC/2UHq4=;
	b=DoZaRGFORDYR9MGM0sRcU9/wFabknqxcGo+jVurZB320dsiWul3xxdd7RVRJ20H/Vnl8U1
	K+SsAVoX8MUNUmgzLzPeBHm1UXQFRJbu1jc6vZ13E5zzKjZXcQYw7/dKz2fxft262fRRbB
	N2PiBaSlBTTCXP961orHKn/I2OohB2M=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-_j925C7DN120V-dhJs1AfA-1; Mon, 31 Aug 2026 11:36:06 -0400
X-MC-Unique: _j925C7DN120V-dhJs1AfA-1
X-Mimecast-MFC-AGG-ID: _j925C7DN120V-dhJs1AfA_1788190565
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66e44d96aa0so4121886d50.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 08:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788190565; x=1788795365;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVxBilOuJ3eJRjLFViKxIC+i5050iOvt2YALC/2UHq4=;
        b=YbZ8fmduDXDK6Io//B4yb3tOewJG5baQy/9p7ZSSC349gLANlWzsJqaJz6j3GUG8VY
         5eoFcj7Filf3a87oVLOvwV7h6flhCe/j1AsJ4plI3eTAf3OwIU8MAUrxmOgKFXGQy4Yk
         eB8dsz4gHP1+oYFeCcy468lvu/oxRWx8N9jfa7qrZFB3ZD6xQlvVGNakRAb7RVVlcwtO
         SJH5GUs1cWA6KDMrJv9aisd7YAxh0lpOyznWyhh5jVHQH8+tn9LmIZqXbeefh4QqA/M9
         Xnl2ZGW5mzSon0gnCf1yCMWFL2IrNVQMpH0fU4f6L7FSlrjDC/0PFrGp3Lx8/TnxiZQU
         6B/w==
X-Forwarded-Encrypted: i=1; AKwUvBx8Y6721S8C4AoyganfPbiYsL9mn/q80ryIgD9dGrsUC00j36BuAd6bEke9b0enWWKglB/CHNLAn2sNsfM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kxDPpKIhry78UeZK5HligoVdQfyQNb84R1XLEPY0hrKY6r8GnQ
	u2D5EW/1kuE8sNhEjTz7aKn6g46R/LViXhy5EWQeHfW68es8iu8XKyDISysYPyrpF4K93VWD7Ne
	qMio88fGMh9P+7dDzkkNbAa+ILN4L/F85qBKOTUOoTLjauFiNcE+64yIDqpD7jjEk2Kc=
X-Gm-Gg: AYBFou05ZiA/fkHp221/jc/SflRolU4096cLpBUFAJLnxzhnFKHpR608/siWRWy6tdP
	eYwzs7UFCDphgsNFlIZ4PzjgBkAyehUVi1mujx4YufeEqFQhnAbOl1cr/41dJTFamBEO+rOcjoq
	+/Mg9AVxhL0T4uqWnBJaRHFXsPOsSg52ByspEp2jWIiQiofivnfn6Y97wIxMYX+6GDgOf0flKQ6
	UbOcZho0RrUS+A/930RiPq7YsFhgob0Fawqq21tquc/3J9oAodsRK1GVxSTXz8PHnsDXRQEtnfV
	S08/Hc6i/OoKsllrGyF3/vDAHhtHE+XzFMdGiUW/xHd0JlGZq6/r5FbL7enkHr3FSjqyNTZGXt0
	=
X-Received: by 2002:a05:690e:13c7:b0:66f:8255:9f3d with SMTP id 956f58d0204a3-66f873db9b1mr559449d50.7.1788190565266;
        Mon, 31 Aug 2026 08:36:05 -0700 (PDT)
X-Received: by 2002:a05:690e:13c7:b0:66f:8255:9f3d with SMTP id 956f58d0204a3-66f873db9b1mr559344d50.7.1788190564555;
        Mon, 31 Aug 2026 08:36:04 -0700 (PDT)
Received: from redhat.com ([2600:382:8519:3f74:ab6c:bb55:e9cb:f8d6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66f7efc9dbfsm2062227d50.9.2026.08.31.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:36:03 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:35:55 -0400
From: Brian Masney <bmasney@redhat.com>
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
Subject: Re: [PATCH 00/45] clk: Make sure clk_init_data is fully initialized
 (part two)
Message-ID: <apWfW5ahiYagw0OR@redhat.com>
References: <cover.1787239813.git.geert+renesas@glider.be>
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
In-Reply-To: <cover.1787239813.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yeT7YJBbr07CEimIVyCx8rRXsR7ll3R4c3xdzylpFtA_1788190565
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert / all,

On Fri, Aug 21, 2026 at 10:53:10AM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Hence this series aims to make sure all members are fully initialized,
> to avoid such bugs, and to prevent future breakage when converting
> drivers to a different method for specifying the parents.
> 
> Part One[1] fixed all cases that I identified to be real bugs, in
> response to a crash I saw on BeagleBone Black.
> 
> This series is the clock subpart of Part Two, which fixes remaining
> cases that are currently harmless.  These are still fragile, and may
> cause future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Thanks for your comments!
> 
> [1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
>      initialized (part 1)"
>     https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be
> 
> Geert Uytterhoeven (45):
>   clk: aspeed: Make sure clk_init_data is fully initialized
>   clk: at91: Make sure clk_init_data is fully initialized
>   clk: bcm: iproc: Make sure clk_init_data is fully initialized
>   clk: berlin: Make sure clk_init_data is fully initialized
>   clk: cdce925: Make sure clk_init_data is fully initialized
>   clk: clk-axi-clkgen: Make sure clk_init_data is fully initialized
>   clk: cs2000-cp: Make sure clk_init_data is fully initialized
>   clk: davinci: Make sure clk_init_data is fully initialized
>   clk: fractional-divider: Make sure clk_init_data is fully initialized
>   clk: gemini: Make sure clk_init_data is fully initialized
>   clk: highbank: Make sure clk_init_data is fully initialized
>   clk: hisilicon: Make sure clk_init_data is fully initialized
>   clk: imx: Make sure clk_init_data is fully initialized
>   clk: ingenic: Make sure clk_init_data is fully initialized
>   clk: keystone: Make sure clk_init_data is fully initialized
>   clk: lmk04832: Make sure clk_init_data is fully initialized
>   clk: mediatek: Make sure clk_init_data is fully initialized
>   clk: milbeaut: Make sure clk_init_data is fully initialized
>   clk: mmp: Make sure clk_init_data is fully initialized
>   clk: mvebu: Make sure clk_init_data is fully initialized
>   clk: mxs: Make sure clk_init_data is fully initialized
>   clk: nomadik: Make sure clk_init_data is fully initialized
>   clk: npcm7xx: Make sure clk_init_data is fully initialized
>   clk: nxp: Make sure clk_init_data is fully initialized
>   clk: pistachio: Make sure clk_init_data is fully initialized
>   clk: pwm: Make sure clk_init_data is fully initialized
>   clk: renesas: Make sure clk_init_data is fully initialized
>   clk: rockchip: Make sure clk_init_data is fully initialized
>   clk: samsung: Make sure clk_init_data is fully initialized
>   clk: scpi: Make sure clk_init_data is fully initialized
>   clk: silabs: Make sure clk_init_data is fully initialized
>   clk: socfpga: Make sure clk_init_data is fully initialized
>   clk: spear: Make sure clk_init_data is fully initialized
>   clk: stm32: Make sure clk_init_data is fully initialized
>   clk: st: Make sure clk_init_data is fully initialized
>   clk: sunxi: Make sure clk_init_data is fully initialized
>   clk: tegra: Make sure clk_init_data is fully initialized
>   clk: uniphier: Make sure clk_init_data is fully initialized
>   clk: ux500: Make sure clk_init_data is fully initialized
>   clk: versatile: Make sure clk_init_data is fully initialized
>   clk: vt8500: Make sure clk_init_data is fully initialized
>   clk: x86: Make sure clk_init_data is fully initialized
>   clk: xgene: Make sure clk_init_data is fully initialized
>   clk: xilinx: Make sure clk_init_data is fully initialized
>   clk: zynqmp: Make sure clk_init_data is fully initialized

44 / 45 patches have been added to clk-next. I took it all for simplicity
rather than everyone trying to cherry pick just their parts.

Geert: The only patch that didn't apply was:

  [PATCH 27/45] clk: renesas: Make sure clk_init_data is fully initialized

I didn't look into it too much.

Brian


