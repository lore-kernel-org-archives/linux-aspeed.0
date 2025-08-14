Return-Path: <linux-aspeed+bounces-1960-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0860CA0EE4
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 Aug 2025 10:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2hxc0HYyz3cZy;
	Thu, 14 Aug 2025 20:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755168979;
	cv=none; b=CrcNG/21PHHlyQXH0syDc3adzN2YKdLrWFJKAlVb9Y+kFx+8Jr3ckqKPqbm9kVtqXftQWlDKoNtcq3Gh+2qfGX/CGHbVOVBWcO82g1ks9C+XRpJlcHSlqkeo2LlH5tXJ4pGxlx/MOPvIpmOCGYs679sJAZxyQw0+xJDo2VXDsonkSSle/xD5sOrXsDgTH0a2wJcBgxYE9rEdSccDfPfMyjkvE5s5JNWidnYR0upvP9GWgEhliOSIEEkipdFPfT9RRRkeYn8ZwUdFW7VxvTd+7ayCfTg6aTAedQ+TU1UJVoG2cOGDHFGWkxNLaf9UwZFS7nnk5vmNvxWsEyoxa5OkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755168979; c=relaxed/relaxed;
	bh=JbR4eavo+UWsC7orzrkKTILPFvXCBJmRNvGulr+5qiU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Un6VCmSkeVpnHxlDoQb5b958FAS5nYWxUTyRNIGTtFM7fQbadyFe4mOTcD3WHKvhAX2l85Z02PAxGtMWCM2g49cBO51HMhc96MXDY5Kq84/syrhgEKE9JHd33qTeXtONWg/KtRAilZ92LwCJxLze3v48xDImdkBJ5/9piAW95V/I17E290CX+CWZGiYPdhHeyBYSY/4/cD3vveZtmsXWPUfMkzVJCqfIW+VsQaJ0lKCDP0qGsdZg8r0ccvPTxndejPNaAVWJGgyfcA3d37mVddIDw4Y826AdeY7jDjYSkqWVETOeiWF69pTpZIxarS951Ap2sg7qLrXp5FYSkvk3TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2hxZ6Dfkz3cZx
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 20:56:18 +1000 (AEST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcq-0001YI-AE; Thu, 14 Aug 2025 12:56:04 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcp-000EyL-36;
	Thu, 14 Aug 2025 12:56:03 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcp-000Hxp-2o;
	Thu, 14 Aug 2025 12:56:03 +0200
Message-ID: <7933061270daa3f9c53021064f92f7431fdac9de.camel@pengutronix.de>
Subject: Re: [PATCH v12 0/3] Add support for AST2700 clk driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mo Elbadry
 <elbadrym@google.com>, Rom Lemarchand <romlem@google.com>, William
 Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
 wthai@nvidia.com,  leohu@nvidia.com, dkodihalli@nvidia.com,
 spuranik@nvidia.com
Date: Thu, 14 Aug 2025 12:56:03 +0200
In-Reply-To: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-aspeed@lists.ozlabs.org

On Di, 2025-07-08 at 13:29 +0800, Ryan Chen wrote:
> This patch series is add clk driver for AST2700.
>=20
> AST2700 is the 8th generation of Integrated Remote Management Processor
> introduced by ASPEED Technology Inc. Which is Board Management controller
> (BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
> is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.
>=20
> v12:
[...]

Applied patch 2 to reset/next, thanks!

[2/3] reset: aspeed: register AST2700 reset auxiliary bus device
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D9c50f99c1353

regards
Philipp


