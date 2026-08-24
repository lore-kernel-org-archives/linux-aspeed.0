Return-Path: <linux-aspeed+bounces-4836-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C71C5DF9C
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 12:47:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT9gJ1XQhz2xnW;
	Mon, 24 Aug 2026 22:47:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787575676;
	cv=none; b=BpcUfVRVVANGnS766MppAKQjuqdduYQpvxx3aG5bdg3jVLJ1hMfWQeHqsWOtFRM0bcQafEgPJ+oayso1Q9GjIcnVYAvfh8TbmkZfj4hjf9pc4hebUhFu0hEHSO5hRpBUyffqvZd7B7d5I/dtiH2vcCsa4dU7NNkS92oCteEe/mzRSOKhNE86Kw2tbZgQ9yPSoqY2/KjiYwHk0KYAc3kxAEbk2pW4vSXIVaM/I5WpZ73mtMowL4iYprNhANhDD7R1dsgRWRD7Q7B/AE8RLiU/ggK7qwLHPNtuK9Zx3GlqjuWQDdK1L8jz46yraJDlXXgHo2t5zU2Aj0Q4z2SHpmFnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787575676; c=relaxed/relaxed;
	bh=9ghuoduRfOzi+AYpDw8t1/oQryAhFbodaTAoc1849Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEkj1Fye8meXJBk1z4t+ZbMKMluD7erYVrbxkdDRaT+fPm0O/2RmVTMQGpQ7QcRLnx/LG4fEMj0lvunswb+a7UulZEJ8QhdtDJOg8lfhpHRcg6iDkstetLiPZIN5WCaevpVey8Rz5nug1NdwdMjIYLHYRv1tc8+NXRaleBrMaLHXlw/PWL5G+5HQiIrSmeEup/99l6pgrF2X5kLytypQjRVZ8EJRsDQMMpUapsaYKSnZ4FflxySG92IE8bQQz7ATlMMBK121JxOsPxINTfRgzW9uFw5mFOpy+lpvYExLS5765rQXICk2Z2PrIVdnkwMxQ/aI5EbQ5pN7cFm1gbAScg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=74.125.224.43; helo=mail-yx1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.224.43; helo=mail-yx1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT9gG3CzLz2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 22:47:53 +1000 (AEST)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66ce00575dcso4634187d50.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 05:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575671; x=1788180471;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ghuoduRfOzi+AYpDw8t1/oQryAhFbodaTAoc1849Hg=;
        b=nCK8Wagf2RBOERHhG4rmBDmJfNG0BCEZfSM2fK933lw0h8pRbyp5eUaY+oZkfAYj5+
         RaNawT4xwrrEtXV8xITD2ZXhP4ojotmoY8iQ6MsYWKah1ikhZtDjB/34rUQiR2Yl9/oJ
         O3uJGImLAloNgaIPkp0Y1mX4OhdSohK0iUQF5e5/qZ8OLXhWo4ByudRA/hvwxLrUJcj2
         oSx5SHO5CCvtg6o5dve+BKT2vpMeHnyX3y9D/6z2HlieVj1Z9zhaO1z4ecNF0rbK1jbv
         uxldbNrKfF0MQQ/APMkc07aGIbccvxJl52pSVWGLmUMI0gK+qZqqFdkOMDr/7I+v4njm
         lsHw==
X-Forwarded-Encrypted: i=1; AHgh+RrS7tEuewsxHoXVnAEUyXfWTJ0dD0t+m15oJbh3AgH915lbbKWQBD9sqh1F5w7yce8gY7FrbwlSQZs3NHQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nbuvOrByijsnJMBMTlkB+yc8PYW5wJ6SiB1Qz1o8iAnzx8To3c
	Mh4cK+4T7bHPn3xVfJUbae8N/ISmc5V6VhAyG+QSKGuSuzq+9JcPHDI+hTmJfQcx
X-Gm-Gg: AR+sD11GEVvVs86EV+r96Ct2r32gNwbTTv5OoZbJo/RaMlRXV/Uw/f69FY495jqBwBs
	uqi3xWLaiGu/m+W1mSLlmCinELusNSJsEAQZKZHN4rG9TFzv0iQXdIBu5uRtdMwE6IeviegfktI
	uCW/XhiSQpdb1MpBc7gUk2rZS9gYgYovsZZ37WKgkii7+POEmd/HmZ1UN7eY+HwGe1tQTX0r8F2
	ia/yA8Y/sxIvyc8tWQ+sJh7dDA0gP9eumNzZqkg27APsgwj30WgDRqTzfzYfSsuDgDA0skHqYcY
	oPGTtmI02TPkBs1qwNp4upyD0Niox/RJbvYaKRKXFKM5w9PiX5SL4A5+spaimyKfKq5NxT0KnMz
	e6YnrTJz2WvPMeOD43ywE7BKl6/euk9iCNTGp+IaTCTzl6qanWY4uh2UL5VapyWtyR0eQeBuZHi
	wK44ZJdgpIKUk83kRj3G532je28XB0LiMg6iD2b5PBFKprKAD599gRVS3RnjaAFnHyvksHrMgLC
	bAOXu94Byq7H609RnZe8pzaCA==
X-Received: by 2002:a05:690e:4892:10b0:66b:30cf:64fe with SMTP id 956f58d0204a3-66ce4acfebdmr6446729d50.26.1787575670462;
        Mon, 24 Aug 2026 05:47:50 -0700 (PDT)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com. [74.125.224.51])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4624e9esm3606970d50.2.2026.08.24.05.47.50
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 05:47:50 -0700 (PDT)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66ce00575dcso4634153d50.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 05:47:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrrcHCSRjwr7EFfh2KPYinm1CS3Qn543KXgdDoojxYO0FQ6ie9W6+IuwrujkvvXXxkr9dIMymdu62ZkEcM=@lists.ozlabs.org
X-Received: by 2002:a05:6102:26c5:b0:772:5acc:b848 with SMTP id
 ada2fe7eead31-77a62c46273mr7826182137.6.1787575289120; Mon, 24 Aug 2026
 05:41:29 -0700 (PDT)
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
References: <cover.1787239813.git.geert+renesas@glider.be> <87b3e83137e1a987f3c69d214706e93ef3898cab.1787239813.git.geert+renesas@glider.be>
 <60a8d05a-76fa-43c3-a0f7-fb26a3b659b8@kernel.org>
In-Reply-To: <60a8d05a-76fa-43c3-a0f7-fb26a3b659b8@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2026 14:41:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnXTAVZ_eBfoWNe-sy6BC1X+5EHkDw9R0TAA65Opzi_Q@mail.gmail.com>
X-Gm-Features: AcwNN1UOdKQEkPlARJoVF2UurscVPaHj9T1_AXs-3b7YtVRMAHuDfcVjJgM-XPk
Message-ID: <CAMuHMdWnXTAVZ_eBfoWNe-sy6BC1X+5EHkDw9R0TAA65Opzi_Q@mail.gmail.com>
Subject: Re: [PATCH 29/45] clk: samsung: Make sure clk_init_data is fully initialized
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Linus Walleij <linusw@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, David Lechner <david@lechnology.com>, 
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, 
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

Hi Krzysztof,

On Fri, 21 Aug 2026 at 13:04, Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thank you!

> Let me know if I should take it via Samsung SoC clock tree. I assume by
> default this will go directly via clock tree.

In that case, please provide your Acked-by, so the clock maintainers
don't have to parse your English response to find out ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

