Return-Path: <linux-aspeed+bounces-2845-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAE9CCFA13
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Nov 2025 13:35:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4DMb286tz2yrm;
	Mon, 10 Nov 2025 00:35:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762695355;
	cv=none; b=Wl76WfGg81vHE3B6Hva2343XHM7HzoPfWR6UtjJ+8qows0tV0vXtaXBWMAYgD/gkvPiy77nRQf3v/oG88do5A9PmyeUgQJAlVIvLtMdWUqIYqUPxwatviOFHnhLLYGHSNGyVIqlkIk3Z/IlysApwmy58Iv2vJy2Jpru2WGbSLT8/YbP1rjNyqyX8x+4yk/FUPXDnkI5ASAvizpF232bTPrB141Mk7IF/KmC7Bu/bTZASOAWDTccgB6DprwTVJlYTLzDDEZ93SeVBPP3AUG9aVsEBWxsTA/JdrolRBKDbXB57+ScyFU6WuERHQCHGuRJId6qHiDiR/9pOPyYCkLYySg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762695355; c=relaxed/relaxed;
	bh=n6Irv+vDU/Q0rfiBgoM32DfWEkvZtWWYawhKMOr73ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiiJwSSe0TO40D2a+o36hSLDUDiTAZWYqtlZW8ttZt5Fgynpwqxg9OQ2tIf2KtSFFrGe+CVw4hVoUaegqxPNkBV7TmNBjLQferZOfGInthKJxItsj1XtKbwa6rSbrxXtD3i6KKZhLmKxC8o3K7kuIEldmshkjhlXUUn6vRbNiFkuoUwH9KSg3h4d258vwKRfq+l9wGYjkIgLSXbU9enEj7r3UNrs0Udff3RYEUYsYS1BkoWLBItpy+N/+6ee678s4akNWACqiE40xorFpKLj8cHy7dEC22agnH7BF8QJGQh4nLIaCToVFVBjkcL80QnPELoOM0yWqQbFpBz40Vx1hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Eh/R4uiY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Eh/R4uiY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4DMZ3mryz2xlQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 00:35:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 595F5600AC;
	Sun,  9 Nov 2025 13:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFBCC4CEF8;
	Sun,  9 Nov 2025 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695352;
	bh=O/YevAPjyQGJdjnwul8SWCeizRWaGIKJUDYVqj133Q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eh/R4uiYje//x/E5NBguFrAqNCuLNel2cOHVhB27Mg9Ytw5ykUA7PQ8TDbMs/JZjX
	 f1oopBccD9AxDT/b5bTaUSCsognIXnybjXtM46XVqUITHz1ROp+Zg8I24NX+Lq7LAv
	 xnEVEIa4W6NUN3MQQwkPuZopRE7KDBtY7covt4n6cMIJa4/lRpvS8y99BUDZkG+BAI
	 QLJLaDrWai+mDshH9IzoBP5cBagFVRBQyeGWSKBqI63izs4ODJ8DCKMsY6YtYSBIzD
	 t+VQiT8DuVUPVwNqVTLmyaG/5qdjzCcdv+utzFlsriA8NN6vyQ6iW64snJa8cW7h6V
	 Wf2dpoQrjO4Sw==
Date: Sun, 9 Nov 2025 13:35:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun
 Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
 <tony.luck@intel.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Jianping Shen <Jianping.Shen@de.bosch.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org,
 qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/26] iio: mlx90614: #undef field_{get,prep}()
 before local definition
Message-ID: <20251109133534.3326fb4b@jic23-huawei>
In-Reply-To: <6c773f03da99ccc081a33d2363879957ac96ce33.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
	<6c773f03da99ccc081a33d2363879957ac96ce33.1762435376.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 14:33:54 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

