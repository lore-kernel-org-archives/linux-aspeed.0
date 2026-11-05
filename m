Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8379606A31B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSW+bpRC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLHD72mXHz2xGr;
	Fri, 06 Nov 2026 09:34:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793881541;
	cv=none; b=ZlwoKwZzbWaopir4FOyy8/w7J4Q6/W6w8xSk71YrVzZjChpvte6wDVmzDiLDWANzpWkTfW+vFe4Fp5fhV1IJaYOybucqyeF3EHE5RlwH4bQezUskVCl4GLtEa+Ajj4QRfNamnUTj2bVsbuoRlefbm+oX32Buga2l1ol21q0dJ5tnCLwSYSnNGjW3w4H9dB038L70sxa9YcPmP7PO1090o2S56icqjkJr3G0XKiIa/SyzbeH7ccjEeD0PMQN/4olRGATmRybhopvLxF10XK6sOgTZ2s4rXoYIuiy5MqaoHXT061qvmqYakCELkrf0SBv5JIOZ9oeTmy8JHVNAIN/gWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793881541; c=relaxed/relaxed;
	bh=5triMnaj+pld1/ZkHnww/ZTGYlR4kdR37WbQmvo0E+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEddVHckMxXKN+cZfUqGpVv+JTrgNIy1gj6PC8VriHB3JNdrp7s60NGKqVoKy9+dMODcNcVC86NuVsCyH3Z/rjkw4MWlHgtI9P6sI67cuyzxH0zHUTcsjdpB0Xc2unMud3TYJbe5dLY6s3x1f9UIQ+2PX4Ui1e18OE0MZA6JapP8bRJTuPofsMRNi3GmJ8ct75Y9HAACIZWhqaipHqBhfrvQs6liS4mfQFyilajVkQaAR/D7e3tkgj6kcpKNBgRXvYfn2VdrABe2o4nGitKbOgA5tDpDd5cSLeDxwVwUpHkk4+XkiwA1ntpxOf94tQ7oe2VEqm9ryD8C3QrLvEZyBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSW+bpRC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSW+bpRC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jL1jw1RwZz2xSV;
	Thu, 05 Nov 2026 23:25:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 1EA6160F20;
	Thu,  5 Nov 2026 12:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E9BD81F00A1C;
	Thu,  5 Nov 2026 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881537;
	bh=5triMnaj+pld1/ZkHnww/ZTGYlR4kdR37WbQmvo0E+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSW+bpRC5/OtERfddmxxD47rtdgY7drS4x1h9FWwypwvgjQQLJG4iTAm6/TUtQUbq
	 IiZuATXLd3LAxCpuw8R+bMUOvh3lciPaGvevBovd3QKWsW5Y4FEE65Abpe70tcefDW
	 LNpOF1hD396m8K4hS/U5rd0wiR8PAmrXyC2g6JAfgX8u1ym3pLHliSZ1gqRgSLW+Bc
	 HX49I5XIf2eGuAaWlxtXXmvjW7Xb6hnAMLMzc+IGOOZWZbsMS43S+7Bz5Kl63ztaNT
	 pksjjqJMzfTRz7MCNKhc/3WIhoncfEvk6Lo0/zVDsCqyHXoooOlGiXvSfl7gdoDOj4
	 ig/01HIsQNlIg==
Date: Thu, 5 Nov 2026 13:25:34 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-hwmon@vger.kernel.org, 
	Matti Vaittinen <mazziesaccount@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>, 
	Robert Richter <rric@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Message-ID: <le5gbua6s2mhhv32di4j77qr2we5z5ngzyzmiemhodmblvjiji@q4wf5tdgrbtv>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
 <auxh9PxpJScFO3i2@monoceros>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auxh9PxpJScFO3i2@monoceros>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 12:06:33PM +0100, Uwe Kleine-König (The Capable Hub) wrote:
> 
> Maybe you just need to add `-3` to your workflow? ISTR this should be
> the default for b4, but it seems if failed to mention the -3 in the git
> am cmdline.
> 
> Should I still resend?
>

No, it's alright. I would have preferred a clean b4 shazam but that
works too, thanks.

Bart

