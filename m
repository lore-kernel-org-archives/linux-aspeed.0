Return-Path: <linux-aspeed+bounces-3255-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBABD14893
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Jan 2026 04:46:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmsmt52cDz2yG3;
	Thu, 08 Jan 2026 15:46:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767847582;
	cv=none; b=IUBpabFCFq230JqwIUzZ4llNb0DOfS3OdGlzNUYxkkGkXEY941tT3pIVDtSQkMBfi7aR4FTGw2b6hO+5mLKIJvNvFJiZ9dY++3lGp69fv80Aat0djrqjOEOlNsF487rHvRVbH5hsLpzjuBvjwPv5muBufj0ImeBXO8+GvViNGHQPDsmZD9SBiLwhi10hC/pa5L0BgLZ/tlS0KAr7XQIOhNr3Egq3eIeSfxUei9P7EpP5L50UepcrmC76r0QQydTQw0D+ZGtmedibeXSMKlGkGW4Zf5A8b/O5BT2d2EEtIJwPjKRyvBOntlJRVhpmz0nwlrTBYhgxwxtmk2gP6ehAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767847582; c=relaxed/relaxed;
	bh=mza9GtPsCZLKy+XJqnLyYl8qsw+mGBG9tczLaxgUCDc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7PPQtcSM6PD2e7tVPRs17lL0o1Ap1S5tzUeFfSTfo4S9sRL1V90tG6Ea46yLX0qKeGWPZvrQ1k/4OHmMF8QKxdsB+2vL/9LoNrKMSs0sAbHgckzJZpT1GHY6Szu17IZMTJer3N1YXbUm72rS/ExbdcfUY4+RlTeY1cQRRbM4rtQiAoNv3eyKypd4rQGPG5WDnwUoGgVPaichlavTGcfJXIirzhZKnDnBq7ZXEA4wOM0ydrs7VVLmsEQPCS1bkHFznTb6VQcv60kPAK6e+ZNX7s5dtzfPxhEwPvaLOQqKhKkuFk/wptSAJBc8v3CrNZy9x8nUBMPyqsbvNRsLsppKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=TyIxG2bg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=TyIxG2bg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmsmt0Qtzz2xZK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Jan 2026 15:46:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767847581;
	bh=mza9GtPsCZLKy+XJqnLyYl8qsw+mGBG9tczLaxgUCDc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TyIxG2bgkBhsdIYW38rKXW++/Ld6xXFCIe4TS/ssxX4Z6i6DG6yxFkEWV/4xZa6Bk
	 mwWrp9aTaGvSzNWsNFyBjrWTCPLjaVLOLuZI4VlauW1WmCDhu2f7KRA/LhY2CpS7/J
	 Ugx2ztmNRyhg00QcRAYpfMOKhkDoHo5I3YFs9J6zxQRV3QBJcIynPzTFk8cSmrnNSw
	 Q7cPtiCGy9sDjTsJlGOTG2CZlZkJ0Wo4om8iFHcPQjwE9vKwYQpL/p0FK7v27V9S/r
	 BiQOfFgZ7IMc/7g6DO4VSokhSlvn+e4luIkP2M9CtsXrjAo+m1YakSCZ/Fo/uBXEzL
	 RjZIhUEG8+QiA==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8DDF879F8C;
	Thu,  8 Jan 2026 12:46:20 +0800 (AWST)
Message-ID: <a0d802a1e450860a9859ce3d456fcce81dde8ba3.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite5: add x4 E1.S expansion
 board I2C mux
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, Jackson
 Liu	 <Jackson.Liu@quantatw.com>
Date: Thu, 08 Jan 2026 15:16:19 +1030
In-Reply-To: <20251222-yv5_add_dvt_e1s_ioexp-v1-1-25ad202d2681@gmail.com>
References: <20251222-yv5_add_dvt_e1s_ioexp-v1-1-25ad202d2681@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Mon, 2025-12-22 at 19:25 +0800, Kevin Tung wrote:
> The new hardware design adds two additional E1.S devices behind an
> I2C mux at address 0x73 on bus 10. Add support for this mux in the
> DTS device tree.

Out of curiosity, you're monitoring them with the NVMe-MI basic
management command and not NVMe-MI over MCTP, or is there something
else going on which motivates describing empty mux legs?

Andrew

