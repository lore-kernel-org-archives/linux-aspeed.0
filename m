Return-Path: <linux-aspeed+bounces-3888-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F249F45A0B
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Apr 2026 02:31:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsyMx1hqzz2yk6;
	Sat, 11 Apr 2026 12:31:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:c98:2060:a004:1::200"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775856573;
	cv=none; b=f9Nni5mW1KavUTlKWdIsbR4Qbc5P8ClFCJVsrausbKnH5pqyU0SZR3zBDu3jOzxSUaUdr7GNvkbGHkjpxz3zB8W8uzlpHDw+EJ/zo1xu1jU9b1xAXRr1qi5oEoN/xBi5L9b4MVWAM5+N0Ngo4L6UEqK4fHNDW0XLqEXgR89p8qJgC/2Yux5G2uxIs2dgO8yzOT/St02EsaS3h5Y65a07tej1GU5j+1PBV+ets4CNSg26JGUIhvY7vfP94aPTHe4jAnlb6drt1kdYzQkpGhKwUlGnF8rqTGd8p7j7eZu/2w8YDgh6KZCTKdaIp/7Ksvd8RJR22evVuu9reRoFuFjNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775856573; c=relaxed/relaxed;
	bh=D4Zfbjm4MkkPRNcu/lkToxV+ObwGoSvmfiyPV7tjrN4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E17n5dTZX/3HYf2gntzvOok72S2lneb5ZZfg3wuQIfknipla563pGEoUFVT8efEnRIiTeR37CPWdV4V5pyyFmK4lmpGIt0LoueRN4uZbgr5zJAk9B2NGEFgTIKqGeW9uSMA19si1AGHx8han01mw8mKXOpFGSO5NyqhO3UbGoK9EPPFAu9bsMOl7ox1YkZ2gY1fcZzs2eX6Po2SqphD6vkQ/itvpSBt4ar4P2DZPVcCJHU6SSq9d8jYbaNBIiHVqCuvO3RBV52fiC68koJ5M6OGc4n3balYYpVQxGi5nRx2UohFm+ga5q66mB5q3IH1dYXq+aBt5TdjWnEarJkzVlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; dkim=pass (2048-bit key; secure) header.d=svanheule.net header.i=@svanheule.net header.a=rsa-sha256 header.s=mail1707 header.b=bAkLb03z; dkim-atps=neutral; spf=pass (client-ip=2a00:c98:2060:a004:1::200; helo=polaris.svanheule.net; envelope-from=sander@svanheule.net; receiver=lists.ozlabs.org) smtp.mailfrom=svanheule.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=svanheule.net header.i=@svanheule.net header.a=rsa-sha256 header.s=mail1707 header.b=bAkLb03z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=svanheule.net (client-ip=2a00:c98:2060:a004:1::200; helo=polaris.svanheule.net; envelope-from=sander@svanheule.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 437 seconds by postgrey-1.37 at boromir; Sat, 11 Apr 2026 07:29:30 AEST
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsqgt3wP8z2yhV
	for <linux-aspeed@lists.ozlabs.org>; Sat, 11 Apr 2026 07:29:30 +1000 (AEST)
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 805BB74665B;
	Fri, 10 Apr 2026 23:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1775856124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4Zfbjm4MkkPRNcu/lkToxV+ObwGoSvmfiyPV7tjrN4=;
	b=bAkLb03z7VWjwwinayKy0UinK2NeeyXmLjxtVWLWzopQZe/CEqd7MO7MK4lvGQ8TTldQUk
	fcDYkSR6tAgJVvweYLghVtF4Xw99PvAsyR//i3bFXXikpARiUp74Y/f5mMn0ZGFBKIPCtb
	vLqVj7AzirgexJZSyP0MSHpn3+6rBsDF790y5JKogAgATvb8s8T9x0JtgySogkCbMZnz/V
	tsh8XX77wx7Fp82NJjy1u3yA+nZNhRphlQZZJ/d43GA0lin6qCQLIYE1tdQNO/ixtJTHnE
	tLuWWhZtiEo+6+q7y901DBqv7S5sIqlM/bhmuIhlit4jqRfuYOOxIhxS2jpv1g==
Message-ID: <a5e993d2b6c8b57d2057909812ce831877762bd6.camel@svanheule.net>
Subject: Re: [PATCH 3/4] pinctrl: vt8500: Enable compile testing
From: Sander Vanheule <sander@svanheule.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Linus
 Walleij	 <linusw@kernel.org>, Andreas =?ISO-8859-1?Q?F=E4rber?=
 <afaerber@suse.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Jeffery
	 <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Joel
 Stanley	 <joel@jms.id.au>, linux-realtek-soc@lists.infradead.org, James Tai
	 <james.tai@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>
Date: Fri, 10 Apr 2026 23:22:03 +0200
In-Reply-To: <20260410-pinctrl-testing-v1-3-6f708c855867@oss.qualcomm.com>
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
	 <20260410-pinctrl-testing-v1-3-6f708c855867@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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

Hi Krzysztof,

On Fri, 2026-04-10 at 15:04 +0200, Krzysztof Kozlowski wrote:
> Enable compile testing for Realtek pin controller drivers for increased

Small nit, but this looks like a copy-paste error from the other patch.

	Realtek -> VIA/Wondermedia (or vt8500, whatever you prefer)

Best,
Sander

