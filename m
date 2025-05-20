Return-Path: <linux-aspeed+bounces-1223-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0EAC2D0CD
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 May 2025 00:23:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1ZzW4ycFz30Wh;
	Tue, 20 May 2025 10:23:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747700631;
	cv=none; b=UAIx8lk3jEZFNBud9MmmsxMQaAMqzjzLPkiYpJVHJkYaVgodKu7g4iYqsMFNeekEDLGKeIBAFnImCmxV7Y2ib65m16M4xZtP5dwTZ71mW1WeE60qHhnmhMCaX0K5qXTFXoEDvJV8vpqcUhp71s94dImCT8dPQt9FtQVKQhL4z5cW7j8jqhCV4yRsIi8Kr40kIdekmwRS1y7dZi2HW2lUqno6wXpjxoNaz1uk/TwpNKDd3onUg5jF1wNlZV5HF3a1DQiUd+kOAFhb+9MHYnKQ8CFAKe44JQ5VB18nyjm9RIGieG2b7UFTHqt4hACwLh3sGm70sTYZt9fGatGhLMfCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747700631; c=relaxed/relaxed;
	bh=jVbDrHX4p3eETAYYbC8E/B38AzMWjZPxZbviRuREGuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RL5l7qzLR/rxPBf+hQotcXWJekFmQLu0rkiozPLYcTAzy8gOqtd1C64EhSpEnG1O7F9g49ew+CCDV0HSHsbxceSjfnaeJ9M/UEuc4EZBrXB/17ayCHw4OFWrTJkqiNIDkhT2LLRdZH4jddTfxqvGawU8eTwvHvxH+76pl4x7lukubZTpL9C4nceO+noSrQMLVf1OAGBtJlNySj2SIujhv/bsuBVylP0iA2HTJC7CyElhelzyhrATLwfoHqivhRa1nG4K4oJW+2+WL2QOlISJXjyMRU7HI1fy5PbhGTiWkK7VPNFapi1HCEjauRpvr2YBupGjQj/rsOrl8Wq/nPOU5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HA7AscUC; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HA7AscUC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1ZzV4wZ8z30WD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 20 May 2025 10:23:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1747700627;
	bh=jVbDrHX4p3eETAYYbC8E/B38AzMWjZPxZbviRuREGuw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HA7AscUCU63hu4pNCk7Z8VKwggRSY1X/g/VPH5PfBXPSY/ysZ6+TnYOGje7OE88wH
	 jIy20LQ6Gb6hzjna2EODuadUcLPwDYdpKPOM9EDz+dXCvoN2sy98vGNnxSlnbXHQjp
	 w+FSvaUEbpeVomXLiupz0jt4lRtSL9sgFtL2pdiJQzJ7j5VwBjW1BaR9b/5dy4lp8K
	 BjH+DM8fBKGKw5qPdTjHNuYZavHiiGBfmvjRL9GOJ5PO4aKQFNrdr/SHVoXHg+F8yR
	 rQNZuvPlpre4LzYKQWnIR320KkLwsmwodYltopC+jqqHA0jGMVpuY1OfXTLD/9xGQ/
	 PEFyd/Wuo0gEA==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1291A640A1;
	Tue, 20 May 2025 08:23:45 +0800 (AWST)
Message-ID: <ac008c13719e2c91d7d377cd7a6151393934d854.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] arm: dts: aspeed: yosemite4: add gpio name for uart
 mux sel
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Marshall Zhan <marshall.zhan.wiwynn@gmail.com>, Delphine CC Chiu
	 <delphine_cc_chiu@wiwynn.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, patrick@stwcx.xyz, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Tue, 20 May 2025 09:53:44 +0930
In-Reply-To: <7a5f60e9-376c-440e-a369-5c8d5e10c72a@kernel.org>
References: <20250519024850.2894895-1-delphine_cc_chiu@wiwynn.com>
	 <7a5f60e9-376c-440e-a369-5c8d5e10c72a@kernel.org>
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

Hi Marshall,

On Mon, 2025-05-19 at 08:10 +0200, Krzysztof Kozlowski wrote:
> On 19/05/2025 04:48, Delphine CC Chiu wrote:
> > WIWYNN PROPRIETARY
> > This email (and any attachments) contains proprietary or confidential i=
nformation and is for the sole use of its intended recipient. Any unauthori=
zed review, use, copying or distribution of this email or the content of th=
is email is strictly prohibited. If you are not the intended recipient, ple=
ase notify the sender and delete this email immediately.
>=20
>=20
> We cannot test proprietary patches. Start working with the community in
> the open.

The kernel.org mailing list docs elaborate a little on Krzysztof's
point:

https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-d=
isclaimers

(It's worth reading the rest of the page too).

Cheers,

Andrew

