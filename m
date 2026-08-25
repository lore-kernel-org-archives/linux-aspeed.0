Return-Path: <linux-aspeed+bounces-4847-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD7DC61DBD
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Aug 2026 23:51:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4Ld0p0Xz2yWK;
	Wed, 26 Aug 2026 09:51:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787670725;
	cv=none; b=UNhWm533nzA/TEpfzrVBqq1HnVkFNE229q2CWp1EDAJPjJjLezEg7GpRDnrc2jKz21wCvYQvDU99SSTlTDvnOTOhZ91ZL/9iC5zUGPQGPfN4nvBKcLwZw0zAG1qc+32VjishWZaKU1Ju29HQryBtKtR5+GnIjLBrl7XS4QL86eS2Vrc4IaMUPz6SpdPCD+Piga9gt/YXdn42AwUpZZIQ0ZUGJSn2kUWgMbqFBw99lRPC55G/AYFsSt7R5hx9Wh2TcTweFmGl42UB31MZ7Tb5dWnds0oALqNTKlVGhZR1tWYjaoFwM6aXXurIC6t26iwTFyterM51J6VIG/zkOggivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787670725; c=relaxed/relaxed;
	bh=l2TAxOwHRDlM6cSmZF0xTyxxMoyKXBFa/St1ecjf+fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lsean25q+p0Vov9PbmDVtgDFkyhtS7+z8e6pMbj/cXBr2Di5QKi+EuuyG2jTdIv1eXEghcncwS+/v98R8rs/YAgyvwk2LUlpFCWjRYUaj5EVrWOurArb0VGXjPVQfI6MzK8P8yYqRhUMm0R/hqS8JjpUCXvm7d4DZTQI/PphbAzV3DEBTbWVOeoTqno8Lt8mETuVsVCVJRx0Jn5FzzmEUe8IRGE8EHGAPQg8LMIUcppd/my/wY1Qpn3hU+QCddO5BK0pXG3H361hXLozDwoKUM/agmlYVleqwMrFAs4gziG45j5pDQ+WXTXBGoygAheVyue4GvyFyl5ceHb5im8Yew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZkI7zZw; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZkI7zZw; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZkI7zZw;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZkI7zZw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTrq71cL8z2x9g
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Aug 2026 01:12:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787670717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2TAxOwHRDlM6cSmZF0xTyxxMoyKXBFa/St1ecjf+fY=;
	b=LZkI7zZw55bdeb5npFKH/g+PiuCEcq83NwIN9Q/mEwZZ2SJ8BRORJHCx52a6M+0o3KIUCd
	VbHHR/1AZukJtEQN+26SRzR5AAWKkW0yC9LcH18at2Qp1p27GjEyprlIEy0FPf7VFAFJF6
	mzH2YSQSg/lt9r5X+aHbp3Avl/S9gi0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787670717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2TAxOwHRDlM6cSmZF0xTyxxMoyKXBFa/St1ecjf+fY=;
	b=LZkI7zZw55bdeb5npFKH/g+PiuCEcq83NwIN9Q/mEwZZ2SJ8BRORJHCx52a6M+0o3KIUCd
	VbHHR/1AZukJtEQN+26SRzR5AAWKkW0yC9LcH18at2Qp1p27GjEyprlIEy0FPf7VFAFJF6
	mzH2YSQSg/lt9r5X+aHbp3Avl/S9gi0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-a3NPwRNlNvCZo1O49qYqcw-1; Tue, 25 Aug 2026 11:11:53 -0400
X-MC-Unique: a3NPwRNlNvCZo1O49qYqcw-1
X-Mimecast-MFC-AGG-ID: a3NPwRNlNvCZo1O49qYqcw_1787670713
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0e702df8so67495041cf.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 08:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787670712; x=1788275512;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:content-type:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l2TAxOwHRDlM6cSmZF0xTyxxMoyKXBFa/St1ecjf+fY=;
        b=GfSIIaLJYApDDJ0yFsvDooZQh1610XmriFmUx3wiw1GfsLF2Y/zufezrlZdOXwqj24
         9fb4Fiwe1Wo0tCWQ0r4KIUXBSGYBwUUjvp7XZ5EoDQaOKfOaHH0au6568uIbfupMzSzW
         SZjG2/RJoBA7r4gLnd9/uvi7lW4qln+mR3FXWebLr62KFhs8fLd+RlcRtamHhpyn6m9E
         lOzadGRyAlXO8sOJIJSski1nlCw1Bwn+zKJMJqcWxSKurVaQ1rGmapxy0BMU+MebGB+i
         7UzacKirgi2j6G1fSXU6d6nh/gCbFFHgQxdDoTGkJ8hNfj3wGdGwzjCBeEWxtzh28LZD
         kHzA==
X-Forwarded-Encrypted: i=1; AHgh+RqZi3LDizsLYW1kWbOCttIeuvpGitewzi3tyA/OQR80VoAmnT1lDQj1c/rbobGkxNiWcA3UiDgXg4A65po=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kpcG47tOVYw0COgNLZ5trDAKeNiRT0rEwwWRkJPdFSm64g4gNY
	Q/2mYVwM7CTpguNnOUFZs9zb1lqd/mYp0ZurRl5xghweVSbeg3uZ8Yku+4Q7YwTSIbXhyfdwAiq
	rNIlxbe+b8tbYTRbC5U3PB9+oD3LMJ3KNN39254bBW/D4CVn5YIEN/u9poyvLYqOr9ew=
X-Gm-Gg: AR+sD11Gt9AccN79svOLuwE4wd1w5Aclzn8wMBa51FWDH+3fCToMC+ylO9Ol2nDkrmP
	AG/MgPH5f5vruCQz+Y3nZy7Y3zKVTiaZNfBPdZMbBiXAcJ/poa9A6hQgjFnxLCo9zrGrU840i1E
	GnfBEOAYgMtota9+Q/9l1AfE2Xac5ucxrMzFXtl/76sPzWYZU6lRmuGIAJXpa0CbSQNdIhkSfZY
	qBd7EYT1L2dqBuMuASlsbDrDOezSw48JdFjlRoo7BOAvcw6WX3B2QRBU+8e0GAiJwvqvkrFvqt+
	T2finy1uvzFiCu6mHuAQvy8XkSHByfmhzgImU5xkPqm+pEuO17vrclA4SPU55SjofArosQfxaoc
	CyU4LnP7fR8ZMf6cy7B+XVawwJsp+g6WdzvY=
X-Received: by 2002:ac8:7d13:0:b0:52d:3d46:bfd0 with SMTP id d75a77b69052e-52df5a4a41emr343135651cf.32.1787670712342;
        Tue, 25 Aug 2026 08:11:52 -0700 (PDT)
X-Received: by 2002:ac8:7d13:0:b0:52d:3d46:bfd0 with SMTP id d75a77b69052e-52df5a4a41emr343134781cf.32.1787670711664;
        Tue, 25 Aug 2026 08:11:51 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09aad030sm71209161cf.15.2026.08.25.08.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:11:50 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:11:47 -0400
From: Brian Masney <bmasney@redhat.com>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
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
	Vladimir Zapolskiy <vz@mleia.com>,
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Message-ID: <ao2ws3ZA-o8ZVjTh@redhat.com>
References: <cover.1787239813.git.geert+renesas@glider.be>
 <3074509.irdbgypaU6@diego>
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
In-Reply-To: <3074509.irdbgypaU6@diego>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HXjOusl1BH0Hp6j88ywXm9MeTdzawCl0ZkTyTYpRgAQ_1787670713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Heiko,

On Mon, Aug 24, 2026 at 11:11:32PM +0200, Heiko Stübner wrote:
> Am Freitag, 21. August 2026, 10:53:10 Mitteleuropäische Sommerzeit schrieb Geert Uytterhoeven:
> > 	Hi all,
> > 
> > The clk_init_data structure contains several mutually-exclusive members
> > for different methods to specify the possible parents of a clock,
> > prompting drivers to initialize only the members they need.  However,
> > not initializing all members may cause subtle issues, which are only
> > exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> > enabled.
> > 
> > Hence this series aims to make sure all members are fully initialized,
> > to avoid such bugs, and to prevent future breakage when converting
> > drivers to a different method for specifying the parents.
> > 
> > Part One[1] fixed all cases that I identified to be real bugs, in
> > response to a crash I saw on BeagleBone Black.
> > 
> > This series is the clock subpart of Part Two, which fixes remaining
> > cases that are currently harmless.  These are still fragile, and may
> > cause future breakage when converting drivers to a different method for
> > specifying the parents.
> > 
> > Thanks for your comments!
> 
> I guess more a handling question, how do you expect this series to be
> applied?
> 
> I.e. each clk-arch-maintainer, or in one big thing by the core clock
> maintainers? Just wondering if I should pick the Rockchip patch
> or just let the whole series get applied by the clock maintainers.

Before you pick up anything, let's see if Stephen picks up this series
the next few days before he sends his pull to Linus.

Next development cycle, Jerome Brunet and I will be clk co-maintainers
[1] and will start collecting patches then. If Stephen doesn't pick up
this whole series this week, then pick up the patch(es) relevant for
your tree and send Jerome and I pull as usual. That's just in case
there's other patches that come in during the next development cycle to
these files and to avoid merge conflicts. I don't have a strong opinion
about this though, and could be convinced to take the whole series for
simplicity.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=8bc7ceadce1f362a8b0e88075ef3d926b286c01c

Brian


