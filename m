Return-Path: <linux-aspeed+bounces-5205-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F2FCCA473
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X8L56ntz30B9;
	Fri, 16 Oct 2026 15:31:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791966083;
	cv=none; b=gkpo2No5H5d86s+/KMuKerlPWs8VdOz9d69jXt9hx4yADIoYCIdE7skSiKrfZ1M9nyeOwkQf2+32Pc0OS1gbw0PO83rwTYgN7PYeVIv2/vdCV+A3B0H1+luPG2m5kg5aS6Vu6FM2+T+daHqLT5sCrGD6cLchb19Gq+nf5iLwOjz05ZxcW7Sv85lP2bYaE/alI/2u2amr6w4cviKy7qYnTxnFkpurBubNm+XWE7d8aJw0yttjp2fOlIa6GED4ifiPULZwT0pLJ7Km802HyXpjg41LX425HGg4AJH8Zl3syTcr4YdAJkiw0SpjgdlBEarwkZJjC906aX1MOCzs7x5Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791966083; c=relaxed/relaxed;
	bh=j8YsVbXOdF61Llj8qBDqVp2Fp9mYBbP2iNpUhV0IltE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODa9vdtn4RVQtLEzQOFmi6mOfRWDBhEGTIaDvA8gLjMt/P5qJKQdOoQz5ydwO7U0GFCHzUzGwhhxyqL+C6OgLsWLIAR0WMUoA0YFBv+v9M1ln5H7S7XP/C6DqoQHCWXvxY5FPPEyC4CPknHgIxaFMrA52wFftDZw6Rkbcs8u1SahV15AyHb+VqBcrZfgp8dCsFjXrK7ROkEbW1WjWIgwC/N7ve42dp3JE1SD0cjRUCz6g3bv/I64rxidrxWCoHqvTqWc7cQuBeIQANDS8vhzCiBhRTD6U7HtIci9i0ApYHpO558YK9W6UquOJfHgw9ZZs6tcLuKjPbiNQy+tTlZXhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UKvXTKeI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UKvXTKeI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4PL96SWwz2xwM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 19:21:20 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1654550a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791966078; x=1792570878; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8YsVbXOdF61Llj8qBDqVp2Fp9mYBbP2iNpUhV0IltE=;
        b=UKvXTKeIt/9uiROlud9HNy+FplbPbk+55Qygml6GtzzqYCp4RQWDb/Xs/Wgbtahstj
         7/ra2o26vQpP957gHjKtclfFVz+C6j1r9rQiFBo3MEROUIAIRU1NSAHK1UQfsOQmJiz8
         tDcPEw4YoAn63iTMW7dW/NjVTlw2ra7BGHBTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966078; x=1792570878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8YsVbXOdF61Llj8qBDqVp2Fp9mYBbP2iNpUhV0IltE=;
        b=H6RdrN2L72mRW/f1dr3XfKsZVHLgF2RyH31UaWYra43jtA/b+jbptr5AM/8Zpnltex
         kyKJD+OWqWnjtppJ3sfwuw4z8kptSOK1R/sDAj8hJlr3yMy4Kk1G17jFN39sUuLTn+Fp
         WdmgXUb+DSFgLTIyhc1YKVSGYkEn8I+1l2Mrh3W4XOgrgCKO+86Ztqk8hYqiIDZK0v67
         R1ju+2JU8+apS4rZhb0nK1U14UdedHjFO6Bn5CtnyoIrrYO9qM9HFsxrY74esQ1TivMb
         R80PPy8MJF8BQrY/F8vVfmXJdndi8mASuSFFcpHhhVkH1C1VBRkFjNE6o+vs96iBkfIK
         HT3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxtwI7Ci+03m/1mM0iAe4yX9Wwly4w2Dk6QZSXkzdFXUjv0Yf+TlSM/eo4wrohv3k2zH5LyAofH5a91aCU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJkGkYzdTHoosyGhublicUax8qegrEYNrEbvkSuiaFi4+7mj4A0
	FeiBE5CK+naWjVcfghWypCV69DGUTXWFj8Qk5V98WSMO8srSakZLYVLrbTKeofibV7YqSLGKVkJ
	6Lnr7Jw==
X-Gm-Gg: AYBFou25V61bychOUUQCLsUaGRUWzJKT0t/QSveX2bGpnEUxyODHJtlw+kXIU9hqNqz
	BzN++EhEmV+ZHkZuHku/QGlJTe4EZvXyUPU62QSqHNvPxrJ9ph4Cfd6KnDtxDebRHk+xsrQLqIk
	rdfdNftv+kGHTxtZjLPIjrqsKODKNs4dZ+GjYkPx0Q757eUAXbyLZuODXKd287X9MPvhqUS1N7G
	PydMlSAM6c5YLzAQ/vNdszbaHiFFJnXCs+zY4hFuPzsiYlvrxmw1RaWa4EhBu20n6MugVrr+oV9
	iUig0Ui0mw/nlhN3xlj63QO/YEbX425smGkxeaJlSTp0naK+e9EhjSt4TSJlNYE3d3lcZrLGAN9
	un2EkaKAs1QDCe0jqRGUQOaXdXc0NoKj+9smaeDHjoFPi7byNKRe0RnT6XdAA3Q/sM4UiKA4Vhk
	0VdGqDKzdW/qPal84LK2PA9hjRg981ur88mb+J71dS6jKuhmV/jpq4H437bytHyxeRR34vWG4f1
	w2GTVK9VGun0iDtqckqsgXGjMKi1nCbOdDXajX5RC0GtN5LEGdTxOKHmcVHpnnkzfDr
X-Received: by 2002:a17:90b:4a45:b0:39d:f247:bab with SMTP id 98e67ed59e1d1-3ab3a2fe791mr12737876a91.6.1791966077891;
        Wed, 14 Oct 2026 01:21:17 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:373a:9eb7:c5ba:7b5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f04e324sm3682141a91.2.2026.10.14.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:21:17 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <balbi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Michal Simek <michal.simek@amd.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Wei Yang <yangwei1@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Hang Cao <caohang@eswincomputing.com>,
	Li Jun <jun.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Roy Luo <royluo@google.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Xu Yang <xu.yang_2@nxp.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Stanley Chang <stanley_chang@realtek.com>,
	Ze Huang <huang.ze@linux.dev>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 0/2] dt-bindings: usb: downstream host ports for hcd and dwc3
Date: Wed, 14 Oct 2026 16:20:34 +0800
Message-ID: <20261014082037.1774672-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
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
Content-Transfer-Encoding: 8bit


Hi folks,

I mentioned to a couple people at LPC that the USB host controller
bindings were missing downstream port definitions, and that the ones
used for dwc3 don't align with USB hardware port numbering.

The dwc3 discrepancy was originally noticed by Wei [1] and Konrad [2]
while adapting my M.2 E-key USB support series [3][4] to Qualcomm devices.

Here are the binding changes. If you were CC-ed, then you were listed as
the maintainer of any one of the dwc3 implementations or platforms using
it. So this change would affect you.

Patch 1 adds the "ports" definitions to the common USB host controller
binding. This just follows what is used in usb-hub.yaml. Nothing
special.

Patch 2 "fixes" the port numbering used in the common dwc3 binding. The
dwc3 includes an XHCI for host mode operation, and its port numbering
should follow the common usb-hcd.yaml binding. This clashes with the
existing arbitrary port numbering found in dwc3. I checked all the
big projects, and it seems that only Linux is using them, and it doesn't
care about the numbering anyway.

So while the patches looks small, there are actually 26 other dwc3
implementation bindings that are affected.

And this series currently only has the binding changes. There are
probably close to 500 dts files that need to be fixed as well. I asked
LLM to help me fix the arm64 ones already, and it seemed to do a good
job with some hand holding.

Please have a look. I fully expect there to be a lot of hair pulling.


Thanks
ChenYu

[1] https://lore.kernel.org/all/20260731073306.1895428-1-wei.deng@oss.qualcomm.com/
[2] https://lore.kernel.org/all/c6526ba0-be08-46c6-a501-1b161939657c@oss.qualcomm.com/
[3] v6: https://lore.kernel.org/all/20260721065413.2306137-1-wenst@chromium.org/
[4] v9 (latest): https://lore.kernel.org/all/20260916075745.3549953-1-wenst@chromium.org/


Chen-Yu Tsai (2):
  dt-bindings: usb: hcd: Add downstream USB ports
  dt-bindings: usb: snps,dwc3: Fix downstream port numbering

 .../devicetree/bindings/usb/snps,dwc3-common.yaml      |  4 ++--
 Documentation/devicetree/bindings/usb/usb-hcd.yaml     | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog


