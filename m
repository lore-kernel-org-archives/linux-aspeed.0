Return-Path: <linux-aspeed+bounces-4843-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97DAC5DF9C
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 23:51:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTSNq4SYsz2yps;
	Tue, 25 Aug 2026 09:51:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787584465;
	cv=none; b=IpZykT86A2aqJLdAbCZFXpg5qLNEKGHscfD7Y/+7CIt5cUXvVpUCW1jWjCxIsaUY9E6XFmp/Qok1+we4gRruBxBecGcbcemEGGhSOxhtwpBaM/Qfy5lTHiOH83xrgFZNKEc7cgCeFm3H/AdfCKpBRCvlvhGl/sIf/YHauc8+j0zPikwuiHT2IDJN04ZGyQmqqaV92tAUwHzMeVyMsCgkQmkVBj8LPlqZ41HTZZNXetFar/tcVkxXrqc5jjZn/Exuwc49yNaR+c84D+aIDkOqvujzCfjkktrDQXIww/VBFJq51ALYaLQp19r9f3bpJd/wBtnjBSYuKpMLxcyafmSn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787584465; c=relaxed/relaxed;
	bh=r9JEBxETCpjKOyzPxUj8DiK5Y8iV5A7DhykNYlgKppA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FyA9fel+ScFRlV0QfgiqqZQhD6VLnr8E1UrGB/1CpTK38DEarq0rle2wrYBRqHzuU0gUAv5JF74R7VlR2JYpaOQnWcMPllx9+uDHkOligMIJgLickXY04MBJfQso3eKu2QZ99MY46PDl6XkLQX1rFTY/GTF1GderMEwtq6t9h8Re6IUufZwgbfDFWZvT3KfAKAdXgQhsoWuN1CDxZdITHbkDrCJ5flolb6gYqAk+IsKCH6/wS9fwHW6cOpNrboz1/jxDRJnNIO6mZd5GEreJIqphPbVk/9a/y7b5kabDu/UEIjb6l+VPY3uz4E/gq8H6ZsMA94cLJ4HIXuxyn5O5aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=arEZlnlg; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQ1ywwYh; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=arEZlnlg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQ1ywwYh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTDwJ5ZGdz2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 01:14:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787584459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9JEBxETCpjKOyzPxUj8DiK5Y8iV5A7DhykNYlgKppA=;
	b=arEZlnlg4W2uN8jNuObPdV7XEADzujjJXwvcZ0jsYyOs1GpgplUEFL8fS3dR8trvvObtIj
	bogtbd+W7m+xsHUVN4Gk5Ma9VphbXjVZO5f8hcrXCgQVPh7THWyq/OlM+xHXE2aDqP4kZc
	OzOCr0NnyCMMjqrNBjxYsN60anza9lc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787584460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9JEBxETCpjKOyzPxUj8DiK5Y8iV5A7DhykNYlgKppA=;
	b=RQ1ywwYhBSzgemMFnvk2LOPOKEsN8G3U041gYQ1gub52vQQf5JXQmWNISH87NWSdr9U59b
	5E96eDnCvOE61vPX7qcjGITu8btjfXfBDaYSloduwbM05tjtDJKEiQz3gJPU9ar9WEc5s6
	6R1b5qs/zj7KBGmuE7LcEWdx0lUo6B4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-rLfGC-xBNY-Lfb149LRokw-1; Mon, 24 Aug 2026 11:14:18 -0400
X-MC-Unique: rLfGC-xBNY-Lfb149LRokw-1
X-Mimecast-MFC-AGG-ID: rLfGC-xBNY-Lfb149LRokw_1787584458
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa3d9dfbso409145285a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 08:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584458; x=1788189258;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9JEBxETCpjKOyzPxUj8DiK5Y8iV5A7DhykNYlgKppA=;
        b=V7oi646mpldmbquaznkbhsPjb1ywly/3vJt1viVaPn644aaWCCyzu50XQStJLSFrb/
         0KJscIhmlCuHxEoJbELaa5DGc1nz84LmevYeJTpaqRv6+6ks5Q0Q3Ssi03TkK0k7U9I+
         oIJzIfo4kO/+QBZL3mVwJCK4gvLsdPldqeCjfRKjDQY/2zAH8NSAHvw1VjJ+i4yn3VuG
         PqYyUejOpVeYLJQGGAzqzSF0PuG1/bAKMu9J0efCJfZOsO6MxiWtFvgQrgf5iuCJwot1
         YtRMyVi6x0wWK+fXutCDhsmuK/dsKAkwzZIBx7jqcozPQBEKr8OPbO/a24Z01oTi9hAw
         NQsg==
X-Forwarded-Encrypted: i=1; AHgh+RoHv+jJS8hWV3ZhA4xUuaUdj1pK67J07bbtTnqPLcUF6HabiZDVwpfOOZGQ6S1ryH1pTndHd9Ye2mZhmRQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lKqU0vVBbZgC2rH0mzOpPi+EZNbOpnyzDTsbZ+3r0wqZTUDhzb
	/PpWRvMKyKFxE1wwW0ljGo2ezeGPbokjT0ukFAnYpd3jmTJZj6O4tgO0wiG8oNeAX+EH7ouK+SV
	Sio/gu0UUCCAaqMtR2g6UAV+4Yo6Hrb51B/kCoBXmkndUziXCW+2rZb1cBgQdYnY5YT4=
X-Gm-Gg: AR+sD10LxnroBA+ddKxsYMhn19qXMDzo/yneEZ8OrsSAZtENeVjeKHoPz5V3xpsIgsg
	nn3UHBc4qySHEV+zoHnmmO+RXDD0IYLUtx4lRruGqXVyMDYqj4O8UikLAfO79bLoK7+ThfTXCsY
	6PsWLHo7ZahG46h7GGLvW7SKwznCaDFZ2RZRu2w5O+BFxbGEzjooIhpPwdAw2AYfQfR7QJ7/tAW
	sg8XmrjIfrF9ZnvraAWOCGEbmNehS9TaOwTCq0QzLl+tU7GSe+B3BCSP7XhaI/EyXSskkTjfiOw
	PB3XLdC1m5cBbW3zKBiAEYOQbYuOXeRJF//cHbwn3AnpYFPXfTHY97G/+OcJv9NHmSa63Q2nJtd
	QFOZbIbVK3VHvFiCTubrxj6Ad0WA9y6kuYKA=
X-Received: by 2002:a05:6214:2a49:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-90c80942e22mr260846506d6.4.1787584457462;
        Mon, 24 Aug 2026 08:14:17 -0700 (PDT)
X-Received: by 2002:a05:6214:2a49:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-90c80942e22mr260845166d6.4.1787584456812;
        Mon, 24 Aug 2026 08:14:16 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a82554sm64013126d6.45.2026.08.24.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:14:15 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:14:11 -0400
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
Message-ID: <aoxfwycOmEzLzhEU@redhat.com>
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
X-Mimecast-MFC-PROC-ID: sOjM1mQnUrvuuMnIsFzaSBgWAde3fXRu0OlJf9exJag_1787584458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

Thanks for cleaning this all up! For the series:

Reviewed-by: Brian Masney <bmasney@redhat.com>


