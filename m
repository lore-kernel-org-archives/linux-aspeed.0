Return-Path: <linux-aspeed+bounces-391-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4592E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:38:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV45P2kPfz3cW3;
	Sat, 11 Jan 2025 01:38:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::226"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736519897;
	cv=none; b=ZQYVvknGVM0EhG8f2WddZZY75DnHoLYPjm3FBci4ZtAhHQ/IUlY7Dt/n6eM64gXQDWvg5+u3UoHatgZLvfbO0r2S25RnQnrR2RjFlXDveMHi8Hv4WFVKH+buEsHksaf5nvMV/Gp8L/L2ra7TnBp5EeUBEM94XcBu75TzCsJQBwOjfqJvOOCMrBOpzfJegBo3PP5zqJkzxQkBMGvutZlL11ThAE753GvYG53w1pw1WTbk538GKp6ufHDffolBCDnXAhEJWkb3qcPMA5tFao6KEgVu0uP9z7W4y9dBLZtXHeDecmy3jDChBpd+ETE5az3kKDD2SJiYMDPEsZ//cEbo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736519897; c=relaxed/relaxed;
	bh=AqHOTtKrS2nK6owEMQCN+3bics3pst072/Bpdc2sk1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cc5DutCRQRF5HZmmyZ/XMx1//b2SWwc7d4JPUqPukn5WjzFPwXa2/lLRHhGzXW5D+slsZNrlza4BHhXvB3/UYZBp5YAobZ54YCIMNNfvNg582A+4YdT2wgVHbSr4HccshsfA7oS7xPNjGdB2+rCUbniqfxEG4vAONmJ6l0hPu/LafRQLkrspMAnxQRSg3Pz0NzrQpIbbpZTnI8hfDBia31swSAPetJiPU2rL4KIv5us0PU2URT2+IPjfbEDy+aKa3fGrish/+b3c6Fyogg44UoPkHX/FuL3lZh2yiiJ+uUlMcVEchy/sXuuLIoU1RMiXqdjGxSc+G2qgnIruo8W3VA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=m/PU3jSV; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::226; helo=relay6-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=m/PU3jSV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::226; helo=relay6-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV45M03gsz3cTf;
	Sat, 11 Jan 2025 01:38:12 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 980E5C0007;
	Fri, 10 Jan 2025 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736519880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqHOTtKrS2nK6owEMQCN+3bics3pst072/Bpdc2sk1Q=;
	b=m/PU3jSVOUgUfNeqSsjZfGTt+SAIExnswQ4nJ1ydWLAlAqDyJgvFnyk8HKoBD9BUxG16hy
	Kxy9n0Cwf1Hc7YihZi5k5w9nwTsGIYKn4FnnKxNF0C/9/xC2AA8aQ8o73ouUrLBlKrfiyx
	AyjzfEzOaOEu/KSVKY/wAa4K7WUjTk5cuP80r3I36oJZfq/WPge2eyw/Q2gARWb7KL+upy
	Ls5pf4WYuuJ+rGBVEyY/yx0BMp8H7ueg0TrVzxvdSUOcEZM3LoiSsfBxWSFXKt701XzzPJ
	/SMNBlfNJ7hqRZFrr0ROsFwE2/gIY4flK+fkxxJW4GO12ujEoN3r4OMJKmWnZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,  Serge Semin
 <fancer.lancer@gmail.com>,  Han Xu <han.xu@nxp.com>,  Conor Dooley
 <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung <schung@nuvoton.com>,
  Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater
 <clg@kaod.org>,  Joel Stanley <joel@jms.id.au>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Avi Fishman <avifishman70@gmail.com>,
  Tomer Maimon <tmaimon77@gmail.com>,  Tali Perry <tali.perry1@gmail.com>,
  Patrick Venture <venture@google.com>,  Nancy Yuen <yuenn@google.com>,
  Benjamin Fair <benjaminfair@google.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Raju Rangoju <Raju.Rangoju@amd.com>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin
 <stlin2@winbond.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  imx@lists.linux.dev,
  linux-riscv@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  linux-rockchip@lists.infradead.org,
  linux-mtd@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
  openbmc@lists.ozlabs.org,  linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 20/27] spi: spi-mem: Estimate the time taken by
 operations
In-Reply-To: <ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk> (Mark
	Brown's message of "Fri, 10 Jan 2025 12:42:47 +0000")
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
	<20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
	<ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 10 Jan 2025 15:37:52 +0100
Message-ID: <87tta6ag5b.fsf@bootlin.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mark,

On 10/01/2025 at 12:42:47 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Tue, Dec 24, 2024 at 06:06:05PM +0100, Miquel Raynal wrote:
>> In the SPI-NAND layer, we currently make list of operation variants from
>> the fastest one to the slowest and there is a bit of logic in the core
>> to go over them and pick the first one that is supported by the
>> controller, ie. the fastest one among the supported ops.
>
> This breaks the build:
>
> /build/stage/linux/drivers/spi/spi-mem.c:580:5: error: conflicting types =
for =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct sp=
i_mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_op=
 *)=E2=80=99}
>   580 | u64 spi_mem_calc_op_duration(struct spi_mem_op *op)

Crap, that's a fixup that landed in the wrong commit (mtd: spinand:
Enhance the logic when picking a variant). I'll fix it.

Thanks,
Miqu=C3=A8l

