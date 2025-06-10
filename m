Return-Path: <linux-aspeed+bounces-1339-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A80C5B543
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Jun 2025 12:17:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGnpw1Wsyz306d;
	Tue, 10 Jun 2025 22:17:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749557832;
	cv=none; b=CAPyKwvqrkSnUSOwkmd9+ogX+d25lagiRWh9jhdTNwfNdJ2qY1lNgA97TA0yCkpry1SwWOsN+tYnyxYowp3bQpugxTLNcRyPmZNapV92bwBDq/Eotl5w0e6jd73waC5NPDmWZS68slAbKc3/l9z5nzYyTdeCy0mBIod1BzdZX2NYyPcAKASzyw2WRwQqHndn0x8r72qx1WNOWAinAXA9J7sJX/RUnK28IEpM/6Xu1XB55eb5SBZ17gyk9gcfEnkpCscQNYp7uk1FQT/yC4QEA586jKxLhxJRpYrFddrnSGXuZsLAiZsOSdJrHaZphSDiKYO1EJ/QIeqe3OfNj218HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749557832; c=relaxed/relaxed;
	bh=siXBLzRLss7mh07NwalB4yKgr7YnqKr9rIj6Xo6f3j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQMYK1CDJF49EblMIRj225ZH9V5qisq+IWAcQbwFQLEV8M6bdj961um1h0bj2pD2juV+sdLCC9CKBL88XeBKXaltQwnowQyqMIjNUru0FeWXS9CNbiMVG4SaZt77N7/W86deWf3n2XMk1hZDv2PATvFu0JKKhOOMFdL4DoxCA9UQXGeJ28giDRGLqS9zu/MM63+t1rCMoywGgz1kxZddMc7LFpsme69Y5b6vpg07jNY3otVSf7IqA08T7s56+q7WO13yVbA7SSynX2jH/gmSPE3OJSqJkYS/jGiBkj9+LSDkdcHYgxsNy+IHb3mByeH1fJA52ezFHj9yuBgII1bZRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gxE2J3yi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gxE2J3yi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGnpr4Dj6z2xd3
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 22:17:07 +1000 (AEST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-310447fe59aso51954801fa.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749557821; x=1750162621; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siXBLzRLss7mh07NwalB4yKgr7YnqKr9rIj6Xo6f3j4=;
        b=gxE2J3yiN/zwsCVYRaOWFCrB0wvcWotj4I8QieVNFp9Lx7QsiTdam/gmEMdrgllboJ
         G/3afahfwirFLYLd1oKBacb/YnYRMgJfhIsQ9WFD1shAqaVqVbgimrlDilsMhcEqFg0L
         UY0kEsLbDW6CbMum2aSxajnwhXhSya7zCKtYvwqhffKIn/euyFbZe5sCUVWF0dYm0RRD
         8OO20X2XRo52QiY2zO2ewo5c4fsNIrKgF40veRg9i1tgM9RAWDiFm+652Ko6B7jf6O6M
         9H5aIcDG8CvJwdWT8Ykbw+LO0kTGH6gnJaawZrcjw8rOiTAcJPZRWeRzvCIht0NeBsis
         DWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749557821; x=1750162621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siXBLzRLss7mh07NwalB4yKgr7YnqKr9rIj6Xo6f3j4=;
        b=IAsyk9pEZVk46L5yTw/k8RobYq+KNPEsRVtleD7h1QUotjTK0xhRsDaPULMcuExAER
         LhexJttOBrVwG1YyIuApBwKodX7qjAExDpnHBNAZkFMg9jW9/esR4I6AFBFH7BRSwr8p
         c7AKJUy6M4GWjZAu/PSNS88BPh4bm6E6hmRmgqBWQykaUF/Nsm/FvgoJr7LqB4rvDKIO
         zn3Nx8QuoSylBIaq0Bv2GlPWC5wiC2eqCCysOopdWy73UJrjV0hcs9IRAb6GDvcVRPLb
         SdCu0pMvw1/ifBoys+ybrx6EpzzsDBvq/NRLLHBtzigu0oB/cT9YVgLIhxrC1qBcUeHL
         oDkA==
X-Forwarded-Encrypted: i=1; AJvYcCUGm8OLd8QteVvD+K6e4JnFD3IbThpHiXq0MGeFbC2xRkgOdyGZATNG3k/QGnE1fxBBGOhA7vSPUOg1DnM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLfBI5dVtpwSQC2gJ4Rq+7dwe2jnMM3sMciVpg5dKfYeoIO+KI
	wyTBPEzqnhSWW61deb9eQ8/Vg3Bberrza+PXBmEigechSmGTrfHDATBoVaUpzFM97oaz18gCncR
	dAZV0WC8d3F4GeFutxgulJgF5uTVa3Ms8EBgQF4qOIA==
X-Gm-Gg: ASbGncuO+zoEwR6cmcG7Ok/LjCjCaIJDOF5CPXKPKehp3wIKW4zUa8OkM8lqwnZYL6z
	ApIxFpW9UxjVlYohMy/L45tA88s8fCrbkTZRALqJgQAHCTUn1wIrQHcUMozmW8mNK8F9Ly4y4Iu
	Q6Mnko36S9/md41RocQBObeex/Kb73hr+jtv9u2/vX3/t4rDz8UifxRw==
X-Google-Smtp-Source: AGHT+IFQxMti2+Q8Uenwhc0/S6UdaliHxGCkJGgDod8emAA4asQK/90KUnu0JtAhA4sI4nKXBC2mhVRJZkpkWFN1Jcw=
X-Received: by 2002:a05:651c:2211:b0:32a:8591:66a9 with SMTP id
 38308e7fff4ca-32adfbb0c50mr43449421fa.6.1749557820819; Tue, 10 Jun 2025
 05:17:00 -0700 (PDT)
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
References: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
In-Reply-To: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Jun 2025 14:16:49 +0200
X-Gm-Features: AX0GCFuA2Dfvx1J77MshD7Tzhu9rwDlijvkgXfC-wltdCoDdq-4uVh1ABAKFvmw
Message-ID: <CACRpkdaQLq3YGfOg81gt5=1Wh2ZkoKHeK6H=NWaeW9aLbX4VCA@mail.gmail.com>
Subject: Re: [PATCH 00/17] pinctrl: Constify pointers to 'pinctrl_desc' and more
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Jesper Nilsson <jesper.nilsson@axis.com>, 
	Lars Persson <lars.persson@axis.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Michal Simek <michal.simek@amd.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@axis.com, linux-riscv@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, May 28, 2025 at 12:41=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> In several drivers pointers to 'struct pinctrl_desc' is not modified, so
> since core does not modify it, it can be made as const.

will you rebase this series on v6.16-rc1, fix the snags and send a new vers=
ion?
It's all nice cleanups so it'd be great to just merge this.

Yours,
Linus Walleij

