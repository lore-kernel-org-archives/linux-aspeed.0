Return-Path: <linux-aspeed+bounces-1026-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BF4C28B30
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 00:58:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGtkc4Gppz2ygm;
	Tue, 18 Mar 2025 11:58:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742259512;
	cv=none; b=eHl1PAfoBvb0ttToxcQsA0QkZCuzKQx9D1RdHJK0XCHsUejDVdBMl5G4A5WcV52OrP/iMO+/uCAOdEKK/nWKtfn7SxZhTQe5FBbtiT9ccmxxmELn3L2jM4xYp44U6qeuMruNd94yXYIJ2s+hr5RkJg5tQTWjeKbJbI1VbnM86zZCEPI8xbS4DDRJm3b8e4CDEWm/Srd67DSodmE4xW0Z6wOg5czf7DNZZHBsLH+h3CK/AS0BfVyrKWGWmi3irUJXoGWANrMyNCT4vp9fS2s2C1ajfJhcqZ0P9bu06oSlYyLN7un1MjLONhrYptl4q0aKxzPWVw/b1QJEn1aFCbDk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742259512; c=relaxed/relaxed;
	bh=8nsBNvnH54hqAh3jvOcKxLcm0lF5Rm/1ukltzQEWli8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdYMEimLYJ6jOLj21sIDNTWFli6WKf3r9ZugrpjKbcX+hAVTChbaJNCPjt7Y6MPlb+TycNNd042txQPSah7FYrY2DLA2djDlJoa9X4wcyCavMbEa2Kj6OyE7RIpMReVeKW5cjn1mL9zZ7kK8pDtSK5SAR/8s+iwWvNNOU7gQmI2NGHvkWg1cnDsWYrvJZCobd5s7l0lhoUSR/TL8AsDZ9WsqsAxmKpVecgQQItExuGlm4WwXZAyEcQLVTZSOFVBVTnaK8WORY4VV7JU2/5kScuDQhXCt0OSk2k/gFnWy0xmI7nPbwKE8vX3qjJeyD0gH++tLikulHUonOtvpxdcG4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jc8BN7Rd; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jc8BN7Rd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGtkb6Vx8z2yfx
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 11:58:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742259511;
	bh=8nsBNvnH54hqAh3jvOcKxLcm0lF5Rm/1ukltzQEWli8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jc8BN7Rd17gp2gtEEmn7TWB7s4bL/KU9WzIoZXxwN0EXE71k/IBhjJ+q389jhLkFh
	 IdxPT9Z6TJhLCxxAIGaPi/VyQKog/r3YqcPEFnPtF+U6OeS4BHFLDsU1cQgkR8l9fC
	 jaD1J2NKmGr8roMHDZPf6TDA3s9WwqZTw30pOurMTzahUISzqlD+tF4+7MNqrWElPk
	 IQjOSwm2zi669uXJEub8r3Cz9A+EPj/LvtmNuaNPKOJ/XPO6H3Li0oKxcKVnKTSEN4
	 +hR0JWntitto6WeNRxUqnDmKb4vmL0CunRRtl+XT776blnwKyTi9dENlyucXHxDtN9
	 LK1os6FdOJemg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AF2C277BB4;
	Tue, 18 Mar 2025 08:58:28 +0800 (AWST)
Message-ID: <3e6a356cf1e6f293a2218e1c006f0222c9e01fa6.camel@codeconstruct.com.au>
Subject: Re: [PATCH 03/18] rtc: aspeed: drop needless struct
 aspeed_rtc::rtc_dev member
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>, Chanwoo
 Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley
 <joel@jms.id.au>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Linus
 Walleij <linus.walleij@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  =?ISO-8859-1?Q?T=F3th_J=E1nos?=
 <gomba007@gmail.com>, Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org
Date: Tue, 18 Mar 2025 11:28:28 +1030
In-Reply-To: <20250228-rtc-cleanups-v1-3-b44cec078481@linaro.org>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
	 <20250228-rtc-cleanups-v1-3-b44cec078481@linaro.org>
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
MIME-Version: 1.0

On Fri, 2025-02-28 at 14:07 +0000, Andr=C3=A9 Draszik wrote:
> The memory pointed to by the ::rtc_dev member is managed via devres,
> and no code in this driver uses it past _probe().
>=20
> We can drop it from the structure and just use a local temporary
> variable, reducing runtime memory consumption by a few bytes.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

