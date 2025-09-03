Return-Path: <linux-aspeed+bounces-2119-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB65CCA0FF2
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 05:05:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGrCF2v8Kz2xPx;
	Wed,  3 Sep 2025 15:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756875913;
	cv=none; b=JIK4B3+tXlVOHSIv0wkJVfT9ZOXmBFEAyYqjcPQivebu5PMIjZ62qtrRcheUH2q0SfS7ile6RIABrpv6UXeiHgW8Bl192U+QubCbNhwW6yoi9DpjVquYrGfRGmWFTO3z9nH237QUzM8QWMsPZgJD1MgeEs1in4sa7GFaUKthYgllEqfFgGnWLPtB/685vBlpumlNX4l4EEdCxFumn0zbWaE2Dr0v6DKDEhA6rgiIMEyfUBBDkPvwexoJJS1QjcwRQBjOpuhbgVzSZqVB+C/KwvJcYC8TGe5QNoqngUMJC35MfV3B/jHntH4svpUodLQBpU6WgCZeb8dRQhqTW87i/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756875913; c=relaxed/relaxed;
	bh=z/aNFcuI5ER/zUmHNbZkEITb8B+mXfHQs+aVMjxDIgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNG+6ihAlxJrluF9u858/pDXGQmtsPZ2IM1JII8iJHFoM1CmwTXZsFxP2jr/siZfoPDqfekR5Pd46ISUboxsEAaiqZH8SQ6QWWPR2MLJuOb72pDXbz6UDqrlaVhSnq0iBQp/wUi2ODhOX3yA7Kjp6OWLZYSRdYTxYMsbaoGyrgNHA9YNyyhiCeKY5q2RLUM68B9tKlQ1dl6eTpaekPkbrOFEgHy4sshCdfBpzvrrtai5woXqM2/bIUBPPGY4o/Uki68D+maIFmBRH/EFeToo+/IlP+GqU1PAlk510wbK+71yI8ViGvE5Wzoa7IE8NxW1nHV3sS0amU4HGFISjxgE5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=TFWlqiIu; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=TFWlqiIu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGrCD1ywvz2xHY
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 15:05:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756875911;
	bh=z/aNFcuI5ER/zUmHNbZkEITb8B+mXfHQs+aVMjxDIgQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TFWlqiIuq/EgRqWg5UZI7aD6HRJWbNSWozu+PymRFHSv2k6UeOld6m0jYPcxjava0
	 Vugz8yzOCBq02zTe/CBiKirpQyvEce/jcBYOO24thW8g/Dly1TIVEUXM2RqY6JHy0y
	 EKKRfbTP67sSiWeSptiKYQFGu7qTMz1ve1+9LKY4lnx0K4HjcPG+c24cRag9nM9FBC
	 g4djJ97GqjQm3aYAFwVlN42Owr329lTtiWBGHQXg9dJDoXHmfyo4+SwbxR07FLtbjf
	 g2guGt2m4+Rg7dpn+eFMvcpn98t3W6Ki/oo39zxVt0+LCFmVZhAqecTXmacPRl31Vt
	 k9fwlk2bwV7Ew==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 45A266E02C;
	Wed,  3 Sep 2025 13:05:03 +0800 (AWST)
Message-ID: <9e3d52078b0ad9da6015229d6f39cb013a4cffbd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v11 0/3] ARM: dts: Add support for Meta Clemente BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,  "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	bruce.jy.hung@fii-foxconn.com, Conor Dooley <conor.dooley@microchip.com>
Date: Wed, 03 Sep 2025 14:35:02 +0930
In-Reply-To: <20250813-add-support-for-meta-clemente-bmc-v11-0-8970d41f88b0@fii-foxconn.com>
References: 
	<20250813-add-support-for-meta-clemente-bmc-v11-0-8970d41f88b0@fii-foxconn.com>
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

Hi Leo,

On Wed, 2025-08-13 at 18:04 +0800, Leo Wang wrote:
> This series adds initial support for the Meta Clemente BMC based on
> the
> ASPEED AST2600 SoC.
>=20
> Patch 1 documents the compatible string.
> Patch 2 Add pinctrl nodes for NCSI3 and NCSI4.
> Patch 3 adds the device tree for the board.
>=20
> Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
> ---
> Changes in v11:
> - Rebased on bmc/aspeed/dt as requested.
> - Link to v10:
> https://lore.kernel.org/r/20250801-add-support-for-meta-clemente-bmc-v10-=
0-c1c27082583d@fii-foxconn.com

I've applied v11, after tidying up some whitespace and the subject of
patch 2/3.

Thanks,

Andrew

