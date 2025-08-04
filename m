Return-Path: <linux-aspeed+bounces-1894-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBA8C87FCB
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Aug 2025 00:43:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwHpd6L8kz30RK;
	Mon,  4 Aug 2025 10:43:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=71.19.156.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754268185;
	cv=none; b=nt1QV6G99qu7dtQKO4ugdvPJ4aF/1LxDnrwwS4IRQKGyXj4GPTcrzn/w0WuhfOJT6jTIefId1QqfBhb24f3uaHj/PXeEaro6mHAbfVdYE0M0kigdhl3Se0dUpbt+8J/qaN/oqjiSVLYPJ0bRznO9bm7NN/UgTa/Mzd7YwXWKqKsZbliw2HkiFSI1PJRaVecW1CL2FPuhMRsBp4OWlU9SRbB9l/XQ5etZ0PSKIIFayCLn6aOzlpcJSizJZZY5d6q1eJzTxvgJaELPG4SzLGUcoUGYKsOnBsIT6a9560HvumyZQ0JTrkcfV8KFem3W6Y+iurYa5M0mZx8vMk0I/YF3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754268185; c=relaxed/relaxed;
	bh=rZ2GTvtdLR4dKtuUYv6XmG3B25FHcvC5Jt/WkbqgpN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9V7sgYz5i79X6adjD1O8GNLFlKZ3NZFyez0TGztMq3RLbWQ/74xbfexKzWzdep8Bxqswb8Cuk/wxS0QtOlp9uuBldOVWMKpMGSDjyGrhZ3lCiSQWCFpZKcjJNWtHEhpfS5f3R5UREIntlvZGHhnX/m8Bj+dPLusvJyyEPDWDYxOTCqA5kjNacTvWo177yKZ5aVh4E2kqTmsQxNIZk5Tag65g4kyLou3CzcYedlIDBz07cbol0tQ3+tB27eyUTaT4VYeokrDAyYgEniSt1fUhcmGoclhabSCy+EkCHoRjyJG/KHOqNWxsdlNX1629I61fcgv/bw3GSTtWc1XuGybTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=m+4UT2bm; dkim-atps=neutral; spf=pass (client-ip=71.19.156.171; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org) smtp.mailfrom=bewilderbeest.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=m+4UT2bm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bewilderbeest.net (client-ip=71.19.156.171; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 588 seconds by postgrey-1.37 at boromir; Mon, 04 Aug 2025 10:43:03 AEST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwHpb4Czhz2xHp
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Aug 2025 10:43:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1754267587;
	bh=rZ2GTvtdLR4dKtuUYv6XmG3B25FHcvC5Jt/WkbqgpN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+4UT2bm2WHVQ46yE1uRgn0S4VP9FzC0oNr5wheu+bDu1L8wmbe7jR+n2sjbi6pCo
	 p6SKJ9JiagEp4DE4NOWOOTeHERCb3/dafxI/GDL8dyQP/FpuKO62aK6r8T7lhmNZ16
	 jS9Du+WwNr6ych95GqYrsyGZ/1g9IRdoleKWod2k=
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5f:8500::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id EA55D198;
	Sun,  3 Aug 2025 17:33:06 -0700 (PDT)
Date: Sun, 3 Aug 2025 17:33:05 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Tan Siewert <tan@siewert.io>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Convert remaining ASRock systems
 to NVMEM layout syntax
Message-ID: <4a58b9cd-8c1f-4a93-8c84-e8f625e1b6c2@hatter.bewilderbeest.net>
References: <20250803151822.68080-1-tan@siewert.io>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250803151822.68080-1-tan@siewert.io>

On Sun, Aug 03, 2025 at 08:18:16AM PDT, Tan Siewert wrote:
>Hi,
>
>While investigating an issue with an ASRock Rack platform, I noticed
>that most of the ASPEED device trees using NVMEM cells to populate
>MAC addresses still rely on a deprecated NVMEM binding syntax.
>As a result, the MAC addresses are not populated from the
>device tree/NVMEM cells properly, and an address from "the chip" is
>being used instead.
>
>Commit 76c5533925434 ("ARM: dts: aspeed: convert ASRock SPC621D8HM3
>NVMEM content to layout syntax") was the only system that had previously
>been converted to the new layout syntax.
>
>This patch series converts all remaining ASRock Rack systems in the ASPEED
>device trees to use the new NVMEM layout syntax.
>
>Tan Siewert (4):
>  ARM: dts: aspeed: e3c246d4i: convert NVMEM content to layout syntax
>  ARM: dts: aspeed: e3c256d4i: convert NVMEM content to layout syntax
>  ARM: dts: aspeed: romed8hm3: convert NVMEM content to layout syntax
>  ARM: dts: aspeed: x570d4u: convert NVMEM content to layout syntax
>
> .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts | 12 ++++++++----
> .../dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts | 12 ++++++++----
> .../dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 12 ++++++++----
> .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts   | 18 +++++++++++-------
> 4 files changed, 35 insertions(+), 19 deletions(-)
>
>-- 
>2.43.0
>
>

For the series,

Reviewed-by: Zev Weiss <zev@bewilderbeest.net>

Thanks Tan!


